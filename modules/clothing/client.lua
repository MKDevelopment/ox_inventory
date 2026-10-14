if not lib then return end

local config = lib.load('data.clothing') --[[@as table]]

---@return table? tgiann-clothing exports, when the resource runs
local function clothing()
	return GetResourceState('tgiann-clothing') == 'started' and exports['tgiann-clothing'] or nil
end

local function modelKey(model)
	return math.tointeger(model % 4294967296)
end

---One part of the ped as tgiann-clothing stores it.
---@return table
local function readPart(ped, category, id)
	local prop = category == 'prop'
	local drawable = prop and GetPedPropIndex(ped, id) or GetPedDrawableVariation(ped, id)
	local texture = prop and GetPedPropTextureIndex(ped, id) or GetPedTextureVariation(ped, id)
	local collection, index = '', drawable

	-- DLC clothing is addressed by collection name and local index (game build 2699+)
	if drawable >= 0 then
		local nameOf = prop and GetPedCollectionNameFromProp or GetPedCollectionNameFromDrawable
		local indexOf = prop and GetPedCollectionLocalIndexFromProp or GetPedCollectionLocalIndexFromDrawable

		if nameOf and indexOf then
			collection = nameOf(ped, id, drawable) or ''
			index = indexOf(ped, id, drawable)
		end
	end

	return { category = category, id = id, data = { collection = collection, index = index, texture = math.max(texture, 0) } }
end

---@param def table data/clothing.lua item entry
---@return table[]
local function readGarment(ped, def)
	local parts = {}

	for _, id in ipairs(def.components or {}) do parts[#parts + 1] = readPart(ped, 'component', id) end
	for _, id in ipairs(def.props or {}) do parts[#parts + 1] = readPart(ped, 'prop', id) end

	return parts
end

---@return integer drawable that counts as "nothing worn"
local function nakedIndex(ped, id)
	return (config.naked[modelKey(GetEntityModel(ped))] or {})[id] or 0
end

---@param def table
---@return boolean
local function isWorn(ped, def)
	if def.components then
		local id = def.components[1]
		return GetPedDrawableVariation(ped, id) ~= nakedIndex(ped, id)
	end

	return GetPedPropIndex(ped, def.props[1]) ~= -1
end

local function notifyError(reason)
	if reason then lib.notify({ type = 'error', description = locale(reason) }) end
end

---@return boolean
local function canChange()
	return PlayerData.loaded and not PlayerData.dead and not LocalPlayer.state.invBusy and not lib.progressActive()
end

---@return boolean
local function playAnimation()
	return lib.progressCircle({
		duration = 1500,
		position = 'bottom',
		canCancel = true,
		disable = { combat = true, car = false, move = false },
		anim = { dict = 'clothingshirt', clip = 'try_shirt_positive_d' },
	})
end

---@param resource table tgiann-clothing exports
local function applyParts(resource, ped, parts)
	for _, part in ipairs(parts) do
		resource:SetPedClothing(ped, part.id, part.category == 'prop', part.data.collection, part.data.index, part.data.texture)
	end
end

---Item export of c_* and clothe_set (client.export = 'ox_inventory.useClothing'): puts the garment on;
---whatever it replaces comes back as an item.
exports('useClothing', function(_, slot)
	local resource = clothing()
	if not resource or not canChange() or type(slot) ~= 'table' then return end

	local metadata = slot.metadata or {}
	local ped = cache.ped

	if type(metadata.data) ~= 'table' or not tonumber(metadata.model) then return notifyError('clothing_not_worn') end
	if modelKey(tonumber(metadata.model)) ~= modelKey(GetEntityModel(ped)) then return notifyError('clothing_wrong_sex') end

	-- garments worn in the places the new one covers
	local covered = {}
	for _, part in ipairs(metadata.data) do covered[('%s%s'):format(part.category, part.id)] = true end

	local worn = {}

	for name, def in pairs(config.items) do
		local parts = readGarment(ped, def)

		for _, part in ipairs(parts) do
			if covered[part.category .. part.id] then
				worn[#worn + 1] = { item = name, parts = parts }
				break
			end
		end
	end

	if not playAnimation() then return end

	local success, response = lib.callback.await('ox_inventory:clothing:wear', false, slot.slot, worn)
	if not success then return notifyError(response) end

	applyParts(resource, ped, response)

	if slot.name == 'c_mask' then resource:ApplyMaskFaceReset() end

	resource:SaveSkin()
end)

---@param name string garment item
local function takeOff(name)
	local resource = clothing()
	if not resource or not canChange() then return end

	local def = config.items[name]
	local ped = cache.ped

	if not isWorn(ped, def) then return notifyError('clothing_not_worn') end
	if not playAnimation() then return end

	local parts = readGarment(ped, def)
	local success, reason = lib.callback.await('ox_inventory:clothing:takeOff', false, name, parts)
	if not success then return notifyError(reason) end

	local naked = {}

	for i, part in ipairs(parts) do
		local prop = part.category == 'prop'
		naked[i] = { category = part.category, id = part.id, data = { collection = '', index = prop and -1 or nakedIndex(ped, part.id), texture = 0 } }
	end

	applyParts(resource, ped, naked)
	resource:SaveSkin()
end

RegisterCommand(config.command, function()
	if not clothing() or not canChange() then return end

	local ped = cache.ped
	local options = {}
	local Items = require 'modules.items.client'

	for _, name in ipairs(config.order) do
		local def = config.items[name]

		if def and isWorn(ped, def) then
			options[#options + 1] = {
				title = Items[name]?.label or name,
				description = locale('clothing_take_off'),
				icon = 'shirt',
				onSelect = takeOff,
				args = name,
			}
		end
	end

	if #options == 0 then return notifyError('clothing_nothing_worn') end

	lib.registerContext({ id = 'ox_inventory:clothing', title = locale('clothing_menu'), options = options })
	lib.showContext('ox_inventory:clothing')
end, false)
