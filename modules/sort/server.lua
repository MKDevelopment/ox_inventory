if not lib then return end

local Inventory = require 'modules.inventory.server'
local Items = require 'modules.items.server'

-- slots 1-5 are the hotbar and are never moved
local FIRST_SLOT = 6

local categoryOrder = {}

for index, name in ipairs({ 'weapons', 'food', 'drinks', 'ingredients', 'medical', 'drugs', 'vehicle', 'tools', 'documents', 'valuables', 'materials', 'clothing', 'other' }) do
	categoryOrder[name] = index
end

---@param slot SlotWithItem
---@return string
local function getCategory(slot)
	local item = Items(slot.name)

	if item?.category and categoryOrder[item.category] then return item.category end
	if item and (item.weapon or item.ammo or item.component) then return 'weapons' end
	if slot.name:find('^clothing') then return 'clothing' end

	return 'other'
end

---@param slot SlotWithItem
local function getLabel(slot)
	return (slot.metadata?.label or slot.label or slot.name):lower()
end

local function byLabel(a, b)
	local labelA, labelB = getLabel(a), getLabel(b)
	if labelA ~= labelB then return labelA < labelB end
	return a.count > b.count
end

local comparators = {
	name = byLabel,
	weight = function(a, b)
		if a.weight ~= b.weight then return a.weight > b.weight end
		return byLabel(a, b)
	end,
	count = function(a, b)
		if a.count ~= b.count then return a.count > b.count end
		return byLabel(a, b)
	end,
	category = function(a, b)
		local catA, catB = categoryOrder[getCategory(a)], categoryOrder[getCategory(b)]
		if catA ~= catB then return catA < catB end
		return byLabel(a, b)
	end,
}

local cooldowns = {}

AddEventHandler('playerDropped', function()
	cooldowns[source] = nil
end)

---Reorders the player's own inventory (outside the hotbar) on the server.
lib.callback.register('ox_inventory:sortInventory', function(source, mode)
	local compare = comparators[mode]
	if not compare then return false end

	local now = GetGameTimer()
	if cooldowns[source] and now - cooldowns[source] < 1000 then return false end
	cooldowns[source] = now

	local inv = Inventory(source) --[[@as OxInventory?]]
	if not inv?.player or Player(source).state.invBusy then return false end

	-- an equipped weapon or an open container is tied to its slot
	if inv.weapon then return false, 'sort_weapon_equipped' end
	if inv.containerSlot then return false, 'sort_container_open' end

	local sorted, previous = {}, {}

	for slot = FIRST_SLOT, inv.slots do
		local item = inv.items[slot]

		if item then
			sorted[#sorted + 1] = item
			previous[slot] = item
		end
	end

	table.sort(sorted, compare)

	local updates = {}

	for slot = FIRST_SLOT, inv.slots do
		local item = sorted[slot - FIRST_SLOT + 1]

		if item ~= previous[slot] then
			if item then item.slot = slot end
			inv.items[slot] = item
			updates[#updates + 1] = { item = item or { slot = slot }, inventory = inv.id }
		end
	end

	if #updates > 0 then
		inv.changed = true
		inv:syncSlotsWithClients(updates, true)
	end

	return true
end)
