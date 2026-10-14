if not lib then return end

local config = lib.load('data.clothing') --[[@as table]]
local Inventory = require 'modules.inventory.server'
local Utils = require 'modules.utils.server'

local MAX_COMPONENT, MAX_PROP = 11, 7
local cooldowns = {}

AddEventHandler('playerDropped', function()
	cooldowns[source] = nil
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
lib.callback.register('ox_inventory:clothing:wear', function(source, slotId, worn)
	if math.type(slotId) ~= 'integer' or type(worn) ~= 'table' or onCooldown(source) then return false end

	local inv = getPlayer(source)
	if not inv then return false end

	local slot = Inventory.GetSlot(inv, slotId)
	if not slot or (not config.items[slot.name] and slot.name ~= config.set) then return false end

	local metadata = slot.metadata or {}
	local model = GetEntityModel(GetPlayerPed(source))

	if modelKey(metadata.model) ~= modelKey(model) then return false, 'clothing_wrong_sex' end
	if type(metadata.data) ~= 'table' or #metadata.data == 0 then return false, 'clothing_not_worn' end

	for _, part in ipairs(metadata.data) do
		if not isValidPart(part) then return false, 'clothing_not_worn' end
	end

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

		if #replaced > 0 and not isNaked(replaced, model) then
			returned[#returned + 1] = { name = entry.item, metadata = garmentMetadata(entry.item, replaced, metadata.model) }
		end
	end

	-- the garment's own slot frees up; every other returned garment needs a free slot
	if #returned > 1 then
		local _, _, emptySlots = Inventory.GetItemSlots(inv, slot.name)
		if (emptySlots or 0) < #returned - 1 then return false, 'cannot_carry' end
	end

	if not Inventory.RemoveItem(inv, slot.name, 1, nil, slotId) then return false end

	for i = 1, #returned do
		if not Inventory.AddItem(inv, returned[i].name, 1, returned[i].metadata) then
			-- undo: take back what was already given and return the garment
			for j = 1, i - 1 do Inventory.RemoveItem(inv, returned[j].name, 1, returned[j].metadata) end
			Inventory.AddItem(inv, slot.name, 1, metadata, slotId)
			return false, 'cannot_carry'
		end
	end

	return true, metadata.data
end)

---Takes a garment off into an item; the client strips the ped once this returns true.
lib.callback.register('ox_inventory:clothing:takeOff', function(source, itemName, parts)
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

	local metadata = garmentMetadata(itemName, parts, model)

	if not Inventory.CanCarryItem(inv, itemName, 1, metadata) or not Inventory.AddItem(inv, itemName, 1, metadata) then
		return false, 'cannot_carry'
	end

	return true
end)
