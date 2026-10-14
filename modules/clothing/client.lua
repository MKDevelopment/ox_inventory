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

---A part as tgiann-clothing currently has it (the same data it saves, which the server checks against).
---@return table?
local function skinPart(skin, category, id)
	local list = skin and (category == 'prop' and skin.props or skin.components)
	local entry = list and (list[tostring(id)] or list[id])

	if type(entry) ~= 'table' then return end

	return {
		category = category,
		id = id,
		data = { collection = entry.collection or '', index = math.tointeger(tonumber(entry.index)) or 0, texture = math.tointeger(tonumber(entry.texture)) or 0 },
	}
end

---@param def table data/clothing.lua item entry
---@return table[]
local function readGarment(ped, def)
	local parts = {}
	local resource = clothing()
	local ok, skin = false, nil

	if resource then ok, skin = pcall(resource.GetPedSkinData, resource, ped) end
	if not ok or type(skin) ~= 'table' then skin = nil end

	for _, id in ipairs(def.components or {}) do parts[#parts + 1] = skinPart(skin, 'component', id) or readPart(ped, 'component', id) end
	for _, id in ipairs(def.props or {}) do parts[#parts + 1] = skinPart(skin, 'prop', id) or readPart(ped, 'prop', id) end

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

---Puts a garment on; whatever it replaces comes back as an item.
---@param slot table garment slot data (pocket or wardrobe)
---@param fromWardrobe? boolean
---@return boolean
local function wearGarment(slot, fromWardrobe)
	local resource = clothing()
	if not resource or not canChange() or type(slot) ~= 'table' then return false end

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

	local success, response = lib.callback.await('ox_inventory:clothing:wear', false, slot.slot, worn, fromWardrobe == true)
	if not success then notifyError(response) return false end

	applyParts(resource, ped, response)

	if slot.name == 'c_mask' then resource:ApplyMaskFaceReset() end

	resource:SaveSkin()
	return true
end

---@param name string garment item
---@param toSlot? integer wardrobe slot to take it off into
---@return boolean
local function takeOff(name, toSlot)
	local resource = clothing()
	if not resource or not canChange() then return false end

	local def = config.items[name]
	local ped = cache.ped

	if not isWorn(ped, def) then notifyError('clothing_not_worn') return false end
	if not playAnimation() then return false end

	local parts = readGarment(ped, def)
	local success, reason = lib.callback.await('ox_inventory:clothing:takeOff', false, name, parts, toSlot)
	if not success then notifyError(reason) return false end

	local naked = {}

	for i, part in ipairs(parts) do
		local prop = part.category == 'prop'
		naked[i] = { category = part.category, id = part.id, data = { collection = '', index = prop and -1 or nakedIndex(ped, part.id), texture = 0 } }
	end

	applyParts(resource, ped, naked)
	resource:SaveSkin()
	return true
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

-- Clothing tab: live camera on the character, equipment slots and the pocket wardrobe

local Utils = require 'modules.utils.client'

local ZOOM = {
	head = { distance = 0.9, height = 0.65, fov = 32 },
	body = { distance = 2.4, height = 0.15, fov = 42 },
	feet = { distance = 1.3, height = -0.75, fov = 36 },
}

local cam, savedHeading

---@return table[] the 13 garments with what is worn
local function equipment()
	local ped = cache.ped
	local list = {}

	for _, name in ipairs(config.order) do
		local def = config.items[name]
		if def then list[#list + 1] = { item = name, worn = isWorn(ped, def), parts = readGarment(ped, def) } end
	end

	return list
end

local function sendEquipment()
	SendNUIMessage({ action = 'clothingEquipment', data = equipment() })
end

---Item export of c_* and clothe_set (client.export = 'ox_inventory.useClothing').
exports('useClothing', function(_, slot)
	if wearGarment(slot) and LocalPlayer.state.invOpen then sendEquipment() end
end)

---Camera in front of the player, aimed past them so the ped stands on the right half of the screen.
local function placeCamera(preset)
	local ped = cache.ped
	local zoom = ZOOM[preset] or ZOOM.body
	local position = GetOffsetFromEntityInWorldCoords(ped, 0.0, zoom.distance, zoom.height)
	local target = GetOffsetFromEntityInWorldCoords(ped, zoom.distance * 0.32, 0.0, zoom.height)

	if not cam then
		cam = CreateCamWithParams('DEFAULT_SCRIPTED_CAMERA', position.x, position.y, position.z, 0.0, 0.0, 0.0, zoom.fov, false, 0)
		SetCamActive(cam, true)
		RenderScriptCams(true, true, 400, true, true)
	else
		SetCamCoord(cam, position.x, position.y, position.z)
		SetCamFov(cam, zoom.fov)
	end

	PointCamAtCoord(cam, target.x, target.y, target.z)
end

local function stopCamera()
	if not cam then return end

	RenderScriptCams(false, true, 400, true, true)
	DestroyCam(cam, false)
	cam = nil

	if savedHeading then
		SetEntityHeading(cache.ped, savedHeading)
		savedHeading = nil
	end
end

---@return boolean
local function startCamera()
	local ped = cache.ped
	if cam or IsPedInAnyVehicle(ped, false) or IsEntityDead(ped) then return cam ~= nil end

	savedHeading = GetEntityHeading(ped)
	placeCamera('body')

	-- keep the player still while the camera is on; give the camera back when the inventory closes
	CreateThread(function()
		while cam do
			if not LocalPlayer.state.invOpen or IsEntityDead(cache.ped) or IsPedInAnyVehicle(cache.ped, false) then
				stopCamera()
				break
			end

			DisableControlAction(0, 30, true)
			DisableControlAction(0, 31, true)
			DisableControlAction(0, 21, true)
			DisableControlAction(0, 22, true)
			DisableControlAction(0, 24, true)
			DisableControlAction(0, 25, true)
			Wait(0)
		end
	end)

	return true
end

RegisterNUICallback('clothingOpen', function(_, cb)
	if not clothing() then return cb({ enabled = false }) end

	lib.callback.await('ox_inventory:clothing:openWardrobe', false)
	Utils.blurOut()
	cb({ enabled = true, camera = startCamera(), equipment = equipment() })
end)

RegisterNUICallback('clothingClose', function(_, cb)
	cb(1)
	stopCamera()
	lib.callback.await('ox_inventory:clothing:closeWardrobe', false)
	TriggerEvent('ox_inventory:resetSecondary')
	if client.screenblur and LocalPlayer.state.invOpen then Utils.blurIn() end
end)

RegisterNUICallback('clothingRotate', function(delta, cb)
	cb(1)
	local dx = tonumber(delta)
	if cam and dx then SetEntityHeading(cache.ped, GetEntityHeading(cache.ped) + math.max(-45, math.min(45, dx * 0.4))) end
end)

RegisterNUICallback('clothingZoom', function(preset, cb)
	cb(1)
	if cam and ZOOM[preset] then placeCamera(preset) end
end)

RegisterNUICallback('clothingWear', function(data, cb)
	cb(1)
	if type(data) == 'table' and wearGarment(data.item, data.fromWardrobe == true) then sendEquipment() end
end)

RegisterNUICallback('clothingTakeOff', function(data, cb)
	cb(1)
	if type(data) == 'table' and config.items[data.item] and takeOff(data.item, tonumber(data.toSlot)) then sendEquipment() end
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == cache.resource then stopCamera() end
end)
