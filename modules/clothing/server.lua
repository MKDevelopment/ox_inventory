if not lib then return end

local config = lib.load('data.clothing') --[[@as table]]
local Inventory = require 'modules.inventory.server'
local Utils = require 'modules.utils.server'

local MAX_COMPONENT, MAX_PROP = 11, 7
local RECENT_TTL = 60 -- seconds until tgiann-clothing has surely saved a change made here
local cooldowns = {}
local recent = {}

AddEventHandler('playerDropped', function()
	cooldowns[source] = nil
	recent[source] = nil
end)

---@return boolean
local function onCooldown(source)
	local now = GetGameTimer()
	if cooldowns[source] and now - cooldowns[source] < 1500 then return true end
	cooldowns[source] = now
	return false
end

---Model hashes may be signed or unsigned depending on where they come from.
local function modelKey(model)
	model = tonumber(model)
	return model and math.tointeger(model % 4294967296)
end

---A part as tgiann-clothing stores it: { category, id, data = { collection, index, texture } }.
---@return boolean
local function isValidPart(part)
	if type(part) ~= 'table' or type(part.data) ~= 'table' then return false end

	local prop = part.category == 'prop'
	if not prop and part.category ~= 'component' then return false end

	local id, data = part.id, part.data
	if math.type(id) ~= 'integer' or id < 0 or id > (prop and MAX_PROP or MAX_COMPONENT) then return false end
	if type(data.collection) ~= 'string' or #data.collection > 64 then return false end
	if math.type(data.index) ~= 'integer' or data.index < -1 or data.index > 4096 then return false end
	if math.type(data.texture) ~= 'integer' or data.texture < 0 or data.texture > 255 then return false end

	return true
end

---Parts must be exactly the garment's components and props, in its order.
---@param def table data/clothing.lua item entry
local function matchesGarment(parts, def)
	if type(parts) ~= 'table' then return false end

	local expected = {}
	for _, id in ipairs(def.components or {}) do expected[#expected + 1] = { 'component', id } end
	for _, id in ipairs(def.props or {}) do expected[#expected + 1] = { 'prop', id } end

	if #parts ~= #expected then return false end

	for i = 1, #expected do
		local part = parts[i]
		if not isValidPart(part) or part.category ~= expected[i][1] or part.id ~= expected[i][2] then return false end
	end

	return true
end

---Whether the first part of a garment is "nothing worn" for the model.
local function isNaked(parts, model)
	local part = parts[1]
	if part.category == 'prop' then return part.data.index == -1 end

	local naked = config.naked[modelKey(model)] or {}
	return part.data.collection == '' and part.data.index == (naked[part.id] or 0)
end

---What the player wears, from the skin tgiann-clothing saved (the server's source of truth, so a
---client cannot report garments it does not wear); nil when it cannot be read.
---@return table?
local function savedSkin(inv)
	if GetResourceState('tgiann-clothing') ~= 'started' then return end

	local resource = exports['tgiann-clothing']
	local ok, hasSkin, _, skin = pcall(resource.GetSkinByIdentifier, resource, inv.owner)

	if not ok or not hasSkin or not skin then return end
	if type(skin) == 'string' then skin = json.decode(skin) end

	return type(skin) == 'table' and skin or nil
end

---The worn data of one part: a change made here in the last minute (SaveSkin may not have reached
---the database yet), else the saved skin. A prop missing from the skin is "nothing".
local function wornData(source, skin, part)
	local key = part.category .. part.id
	local changes = recent[source]
	local change = changes and changes[key]

	if change and os.time() - change.at <= RECENT_TTL then return change.data end

	local list = part.category == 'prop' and skin.props or skin.components
	local entry = list and (list[tostring(part.id)] or list[part.id])

	if not entry and part.category == 'prop' then return { collection = '', index = -1, texture = 0 } end

	return entry
end

---@return boolean whether every reported part is what the player actually wears
local function isWornAsReported(source, skin, parts)
	for _, part in ipairs(parts) do
		local data = wornData(source, skin, part)

		if not data or (data.collection or '') ~= part.data.collection or tonumber(data.index) ~= part.data.index or tonumber(data.texture or 0) ~= part.data.texture then
			return false
		end
	end

	return true
end

---Records parts just changed here, until the saved skin catches up.
local function remember(source, parts)
	local changes = recent[source] or {}
	recent[source] = changes

	for _, part in ipairs(parts) do
		changes[part.category .. part.id] = { data = part.data, at = os.time() }
	end
end

-- Pocket wardrobe: an owner-bound stash for carried garments (no weight, outside the main slots)
local WARDROBE = 'wardrobe'
local wardrobeSlots = config.wardrobe?.slots or 20

exports.ox_inventory:RegisterStash(WARDROBE, locale('clothing_wardrobe'), wardrobeSlots, 1000000, true)

---@return boolean
local function isGarment(name)
	return config.items[name] ~= nil or name == config.set
end

---@return OxInventory?
local function getWardrobe(inv)
	return inv?.owner and Inventory({ id = WARDROBE, owner = inv.owner }) or nil
end

---Where a garment given to `inv` goes: its wardrobe when that has room, else the inventory itself.
local function garmentTarget(inv)
	local wardrobe = getWardrobe(inv)
	return wardrobe and Inventory.GetEmptySlot(wardrobe) and wardrobe or inv
end

local warming = {}

-- garments added to a player by any resource (e.g. tgiann-clothing shops) land in the wardrobe;
-- AddItem must not wait on the database, so an unloaded wardrobe is loaded in the background
function Inventory.redirectAdd(inv, item)
	if not inv.player or not inv.owner or not isGarment(item.name) then return end

	local wardrobe = Inventory(('%s:%s'):format(WARDROBE, inv.owner))

	if not wardrobe then
		if not warming[inv.owner] then
			local owner = inv.owner
			warming[owner] = true
			CreateThread(function()
				getWardrobe(inv)
				warming[owner] = nil
			end)
		end

		return
	end

	if Inventory.GetEmptySlot(wardrobe) then return wardrobe end
end

-- only garments go into a wardrobe
exports.ox_inventory:registerHook('swapItems', function(payload)
	local to = payload.toInventory

	if type(to) == 'string' and to:find('^wardrobe:') and type(payload.fromSlot) == 'table' and not isGarment(payload.fromSlot.name) then
		return false
	end
end, { inventoryFilter = { '^wardrobe:' } })

-- a wardrobe opens only for its owner (owner stashes accept an owner from the client)
exports.ox_inventory:registerHook('openInventory', function(payload)
	local id = payload.inventoryId
	if type(id) ~= 'string' or not id:find('^wardrobe:') then return end

	local inv = Inventory(payload.source)
	if not inv or id ~= ('%s:%s'):format(WARDROBE, inv.owner) then return false end
end, { inventoryFilter = { '^wardrobe:' } })

---@return table metadata in the tgiann-clothing format
local function garmentMetadata(name, parts, model)
	return { version = 'ox', data = parts, model = model, clotheType = name, type = 'clothe' }
end

---@return OxInventory?
local function getPlayer(source)
	local inv = Inventory(source) --[[@as OxInventory?]]
	if not inv?.player or Player(source).state.invBusy then return end
	return inv
end

---Puts the garment in `slotId` on: the item is removed and what the ped wore in its place (reported
---by the client as { item, parts } per garment, validated here) comes back as items.
lib.callback.register('ox_inventory:clothing:wear', function(source, slotId, worn, fromWardrobe)
	if math.type(slotId) ~= 'integer' or type(worn) ~= 'table' or onCooldown(source) then return false end

	local inv = getPlayer(source)
	if not inv then return false end

	-- the garment comes from the pocket or from the player's own wardrobe
	local from = fromWardrobe == true and getWardrobe(inv) or inv
	if not from then return false end

	local slot = Inventory.GetSlot(from, slotId)
	if not slot or (not config.items[slot.name] and slot.name ~= config.set) then return false end

	local metadata = slot.metadata or {}
	local model = GetEntityModel(GetPlayerPed(source))

	if modelKey(metadata.model) ~= modelKey(model) then return false, 'clothing_wrong_sex' end
	if type(metadata.data) ~= 'table' or #metadata.data == 0 then return false, 'clothing_not_worn' end

	for _, part in ipairs(metadata.data) do
		if not isValidPart(part) then return false, 'clothing_not_worn' end
	end

	local skin = savedSkin(inv)
	if not skin then return false, 'clothing_unavailable' end

	-- garments the client says it wears in the places the new one covers
	local covered = {}
	for _, part in ipairs(metadata.data) do covered[part.category .. part.id] = true end

	local returned = {}

	for i = 1, #worn do
		local entry = worn[i]
		local def = type(entry) == 'table' and config.items[entry.item]

		if not def or not matchesGarment(entry.parts, def) then
			Utils.LogExploit(source, 'clothing:wear', ('sent invalid clothing data for %s'):format(tostring(type(entry) == 'table' and entry.item)))
			return false
		end

		-- only the parts the new garment replaces come back; the rest stays on the ped
		local replaced = {}
		for _, part in ipairs(entry.parts) do
			if covered[part.category .. part.id] then replaced[#replaced + 1] = part end
		end

		if not isWornAsReported(source, skin, replaced) then
			Utils.LogExploit(source, 'clothing:wear', ('reported %s it does not wear'):format(entry.item))
			return false
		end

		if #replaced > 0 and not isNaked(replaced, model) then
			returned[#returned + 1] = { name = entry.item, metadata = garmentMetadata(entry.item, replaced, metadata.model) }
		end
	end

	-- the garment's own slot frees up; every other returned garment needs a free slot
	if #returned > 1 and from == inv then
		local _, _, emptySlots = Inventory.GetItemSlots(inv, slot.name)
		local wardrobe = getWardrobe(inv)
		local free = (emptySlots or 0)

		if wardrobe then
			for i = 1, wardrobeSlots do
				if not wardrobe.items[i] then free += 1 end
			end
		end

		if free < #returned - 1 then return false, 'cannot_carry' end
	end

	if not Inventory.RemoveItem(from, slot.name, 1, nil, slotId) then return false end

	for i = 1, #returned do
		local target = garmentTarget(inv)
		returned[i].target = target

		if not Inventory.AddItem(target, returned[i].name, 1, returned[i].metadata) then
			-- undo: take back what was already given and return the garment
			for j = 1, i - 1 do Inventory.RemoveItem(returned[j].target, returned[j].name, 1, returned[j].metadata) end
			Inventory.AddItem(from, slot.name, 1, metadata, slotId)
			return false, 'cannot_carry'
		end
	end

	remember(source, metadata.data)

	return true, metadata.data
end)

---Takes a garment off into an item; the client strips the ped once this returns true.
lib.callback.register('ox_inventory:clothing:takeOff', function(source, itemName, parts, toSlot)
	local def = type(itemName) == 'string' and config.items[itemName]
	if not def or onCooldown(source) then return false end

	local inv = getPlayer(source)
	if not inv then return false end

	if not matchesGarment(parts, def) then
		Utils.LogExploit(source, 'clothing:takeOff', ('sent invalid clothing data for %s'):format(itemName))
		return false
	end

	local model = GetEntityModel(GetPlayerPed(source))
	if isNaked(parts, model) then return false, 'clothing_not_worn' end

	local skin = savedSkin(inv)
	if not skin then return false, 'clothing_unavailable' end

	if not isWornAsReported(source, skin, parts) then
		Utils.LogExploit(source, 'clothing:takeOff', ('reported %s it does not wear'):format(itemName))
		return false, 'clothing_not_worn'
	end

	local metadata = garmentMetadata(itemName, parts, model)
	local wardrobe = getWardrobe(inv)
	local added = false

	-- into the chosen wardrobe slot, else the first free wardrobe slot, else the pocket
	if wardrobe and math.type(toSlot) == 'integer' and toSlot >= 1 and toSlot <= wardrobeSlots and not wardrobe.items[toSlot] then
		added = Inventory.AddItem(wardrobe, itemName, 1, metadata, toSlot)
	end

	if not added then
		local target = garmentTarget(inv)
		added = (target ~= inv or Inventory.CanCarryItem(inv, itemName, 1, metadata)) and Inventory.AddItem(target, itemName, 1, metadata)
	end

	if not added then return false, 'cannot_carry' end

	-- the client puts "nothing" on these parts
	local naked = config.naked[modelKey(model)] or {}
	local stripped = {}

	for i, part in ipairs(parts) do
		local prop = part.category == 'prop'
		stripped[i] = { category = part.category, id = part.id, data = { collection = '', index = prop and -1 or (naked[part.id] or 0), texture = 0 } }
	end

	remember(source, stripped)

	return true
end)

-- the Clothing tab opens the player's own wardrobe as the secondary inventory
lib.callback.register('ox_inventory:clothing:openWardrobe', function(source)
	local inv = getPlayer(source)
	if not inv then return false end

	return server.forceOpenInventory(source, 'stash', { id = WARDROBE, owner = inv.owner }) ~= nil
end)

lib.callback.register('ox_inventory:clothing:closeWardrobe', function(source)
	local inv = Inventory(source) --[[@as OxInventory?]]
	if not inv?.player or type(inv.open) ~= 'string' or not inv.open:find('^wardrobe:') then return false end

	local wardrobe = Inventory(inv.open)

	if wardrobe then
		wardrobe.openedBy[inv.id] = nil
		wardrobe:set('open', false)
	end

	inv.open = inv.id
	return true
end)
