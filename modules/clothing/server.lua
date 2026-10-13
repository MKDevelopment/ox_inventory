if not lib then return end

if not GetConvarBool('inventory:clothingitems', false) then return end

local config = lib.load('data.clothing') --[[@as table]]

if type(config?.saveAppearance) ~= 'function' then
	return warn('inventory:clothingitems is enabled, but data/clothing.lua has no saveAppearance function. Clothing items are disabled to prevent item duplication.')
end

local Inventory = require 'modules.inventory.server'
local Utils = require 'modules.utils.server'

local categories, itemCategory = {}, {}

for i = 1, #config.categories do
	local category = config.categories[i]
	categories[category.name] = category
	itemCategory[category.item] = category
end

local pedSex = {
	[`mp_m_freemode_01`] = 'm',
	[`mp_f_freemode_01`] = 'f',
}

local cooldowns = {}

---@param source number
---@return boolean
local function onCooldown(source)
	local now = GetGameTimer()

	if cooldowns[source] and now - cooldowns[source] < 1500 then return true end

	cooldowns[source] = now
	return false
end

AddEventHandler('playerDropped', function()
	cooldowns[source] = nil
end)

---Validates the variations reported by the client against the category layout.
---@param list any
---@param ids number[]?
---@param minDrawable number
---@return boolean
local function isValidList(list, ids, minDrawable)
	if not ids then return list == nil end
	if type(list) ~= 'table' or #list ~= #ids then return false end

	for i = 1, #ids do
		local entry = list[i]

		if type(entry) ~= 'table' or entry[1] ~= ids[i] then return false end

		local drawable, texture = entry[2], entry[3]

		if math.type(drawable) ~= 'integer' or drawable < minDrawable or drawable > 1000 then return false end
		if math.type(texture) ~= 'integer' or texture < -1 or texture > 255 then return false end
	end

	return true
end

---Builds item metadata from what the client reports as currently worn; nil when nothing is worn.
---@param category table
---@param sex string
---@param worn any
---@return table? metadata, boolean? invalid
local function buildMetadata(category, sex, worn)
	if worn == nil then return end
	if type(worn) ~= 'table' then return nil, true end

	if not isValidList(worn.components, category.components, 0) or not isValidList(worn.props, category.props, -1) then
		return nil, true
	end

	-- the first component/prop decides whether anything is worn, e.g. an undershirt alone is not a "top"
	local first = worn.components and worn.components[1] or worn.props[1]
	local naked = worn.components and (config.naked[sex][first[1]] or 0) or -1

	if first[2] == naked then return end

	return {
		sex = sex,
		components = worn.components,
		props = worn.props,
		label = ('%s #%d'):format(category.label, first[2]),
		description = ('Model %d, wariant %d'):format(first[2], first[3]),
	}
end

---@param source number
---@return OxInventory?, string?
local function getPlayer(source)
	local inv = Inventory(source) --[[@as OxInventory?]]
	if not inv?.player or Player(source).state.invBusy then return end

	return inv, pedSex[GetEntityModel(GetPlayerPed(source))]
end

---Takes a category off; the client strips the ped once this returns true.
lib.callback.register('ox_inventory:clothing:takeOff', function(source, categoryName, worn)
	local category = categories[categoryName]
	if not category or onCooldown(source) then return false end

	local inv, sex = getPlayer(source)
	if not inv then return false end
	if not sex then return false, 'clothing_invalid_ped' end

	local metadata, invalid = buildMetadata(category, sex, worn)

	if invalid then
		Utils.LogExploit(source, 'clothing:takeOff', ('sent invalid clothing data for %s'):format(categoryName))
		return false
	end

	if not metadata then return false, 'clothing_not_worn' end

	if not Inventory.CanCarryItem(inv, category.item, 1, metadata) then
		return false, 'cannot_carry'
	end

	if not Inventory.AddItem(inv, category.item, 1, metadata) then return false, 'cannot_carry' end

	return true
end)

---Removes a clothing item so the client can put it on; whatever was worn before is given back as an item.
lib.callback.register('ox_inventory:clothing:wear', function(source, slotId, worn)
	if math.type(slotId) ~= 'integer' or onCooldown(source) then return false end

	local inv, sex = getPlayer(source)
	if not inv then return false end
	if not sex then return false, 'clothing_invalid_ped' end

	local slot = Inventory.GetSlot(inv, slotId)
	local category = slot and itemCategory[slot.name]
	if not category then return false end

	local metadata = slot.metadata

	if metadata.sex ~= sex then return false, 'clothing_wrong_sex' end
	if not metadata.components and not metadata.props then return false, 'clothing_not_worn' end

	local previous, invalid = buildMetadata(category, sex, worn)

	if invalid then
		Utils.LogExploit(source, 'clothing:wear', ('sent invalid clothing data for %s'):format(category.name))
		return false
	end

	if not Inventory.RemoveItem(inv, slot.name, 1, nil, slotId) then return false end

	if previous and not Inventory.AddItem(inv, category.item, 1, previous) then
		Inventory.AddItem(inv, slot.name, 1, metadata, slotId)
		return false, 'cannot_carry'
	end

	return true, metadata
end)
