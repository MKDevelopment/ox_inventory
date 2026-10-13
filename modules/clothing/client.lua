if not lib then return end

if not GetConvarBool('inventory:clothingitems', false) then return end

local config = lib.load('data.clothing') --[[@as table]]

-- the server prints a warning and refuses every request in this case
if type(config?.saveAppearance) ~= 'function' then return end

local categories, itemCategory = {}, {}

for i = 1, #config.categories do
	local category = config.categories[i]
	categories[i] = category
	itemCategory[category.item] = category
end

local pedSex = {
	[`mp_m_freemode_01`] = 'm',
	[`mp_f_freemode_01`] = 'f',
}

---@param ped number
---@param category table
---@return table
local function readWorn(ped, category)
	local worn = {}

	if category.components then
		worn.components = {}

		for i = 1, #category.components do
			local id = category.components[i]
			worn.components[i] = { id, GetPedDrawableVariation(ped, id), GetPedTextureVariation(ped, id) }
		end
	end

	if category.props then
		worn.props = {}

		for i = 1, #category.props do
			local id = category.props[i]
			worn.props[i] = { id, GetPedPropIndex(ped, id), GetPedPropTextureIndex(ped, id) }
		end
	end

	return worn
end

---@param ped number
---@param sex string
---@param category table
---@return boolean
local function isWorn(ped, sex, category)
	if category.components then
		local id = category.components[1]
		return GetPedDrawableVariation(ped, id) ~= (config.naked[sex][id] or 0)
	end

	return GetPedPropIndex(ped, category.props[1]) ~= -1
end

---@param ped number
---@param components table?
---@param props table?
local function apply(ped, components, props)
	if components then
		for i = 1, #components do
			local entry = components[i]
			SetPedComponentVariation(ped, entry[1], entry[2], entry[3], 0)
		end
	end

	if props then
		for i = 1, #props do
			local entry = props[i]

			if entry[2] == -1 then
				ClearPedProp(ped, entry[1])
			else
				SetPedPropIndex(ped, entry[1], entry[2], entry[3], true)
			end
		end
	end
end

---@param ped number
---@param sex string
---@param category table
local function strip(ped, sex, category)
	if category.components then
		for i = 1, #category.components do
			local id = category.components[i]
			SetPedComponentVariation(ped, id, config.naked[sex][id] or 0, 0, 0)
		end
	end

	if category.props then
		for i = 1, #category.props do
			ClearPedProp(ped, category.props[i])
		end
	end
end

---@param ped number
local function save(ped)
	local success, err = pcall(config.saveAppearance, ped)

	if not success then
		warn(('failed to save appearance after a clothing change: %s'):format(err))
	end
end

---@param reason string?
local function notifyError(reason)
	if reason then
		lib.notify({ type = 'error', description = locale(reason) })
	end
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

---Item export for every clothing item in data/clothing.lua (client.export = 'ox_inventory.wearClothing').
exports('wearClothing', function(_, slot)
	local category = itemCategory[slot.name]
	if not category or not canChange() then return end

	local ped = cache.ped
	local sex = pedSex[GetEntityModel(ped)]

	if not sex then return notifyError('clothing_invalid_ped') end
	if slot.metadata.sex ~= sex then return notifyError('clothing_wrong_sex') end

	local components = slot.metadata.components

	if components then
		for i = 1, #components do
			local entry = components[i]

			if not IsPedComponentVariationValid(ped, entry[1], entry[2], entry[3]) then
				return notifyError('clothing_wrong_sex')
			end
		end
	end

	if not playAnimation() then return end

	local success, response = lib.callback.await('ox_inventory:clothing:wear', false, slot.slot, readWorn(ped, category))

	if not success then return notifyError(response) end

	apply(ped, response.components, response.props)
	save(ped)
end)

---@param category table
local function takeOff(category)
	if not canChange() then return end

	local ped = cache.ped
	local sex = pedSex[GetEntityModel(ped)]

	if not sex then return notifyError('clothing_invalid_ped') end
	if not isWorn(ped, sex, category) then return notifyError('clothing_not_worn') end

	if not playAnimation() then return end

	local success, reason = lib.callback.await('ox_inventory:clothing:takeOff', false, category.name, readWorn(ped, category))

	if not success then return notifyError(reason) end

	strip(ped, sex, category)
	save(ped)
end

RegisterCommand(config.command, function()
	if not canChange() then return end

	local ped = cache.ped
	local sex = pedSex[GetEntityModel(ped)]

	if not sex then return notifyError('clothing_invalid_ped') end

	local options = {}

	for i = 1, #categories do
		local category = categories[i]

		if isWorn(ped, sex, category) then
			options[#options + 1] = {
				title = category.label,
				description = locale('clothing_take_off'),
				icon = 'shirt',
				onSelect = takeOff,
				args = category,
			}
		end
	end

	if #options == 0 then return notifyError('clothing_nothing_worn') end

	lib.registerContext({ id = 'ox_inventory:clothing', title = locale('clothing_menu'), options = options })
	lib.showContext('ox_inventory:clothing')
end, false)
