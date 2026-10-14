---Checks shared by store checkouts: can the player take the whole cart (weight and free slots)?
local Inventory = require 'modules.inventory.server'

local Cart = {}

---@param metadata? table
local function isEmpty(metadata)
	return not metadata or next(metadata) == nil
end

---Free slots the cart needs. Unique items take one slot per unit; items that get per-item
---metadata (spoiling food, templates) always start a new stack; plain stackable items join an
---existing stack of the same item.
---@param inv OxInventory
---@param lines { item: table, count: integer, metadata?: table, stacks?: integer }[] stacks: known number of new stacks
---@return integer
function Cart.slotsNeeded(inv, lines)
	local needed = 0

	for i = 1, #lines do
		local line = lines[i]
		local item = line.item

		if line.stacks then
			needed += line.stacks
		elseif not item.stack then
			needed += line.count
		elseif item.degrade or item.template or not isEmpty(line.metadata) then
			needed += 1
		else
			local stacked = false

			for _, slot in pairs(inv.items) do
				if slot.name == item.name and isEmpty(slot.metadata) then
					stacked = true
					break
				end
			end

			if not stacked then needed += 1 end
		end
	end

	return needed
end

---@param inv OxInventory
---@param lines { item: table, count: integer, metadata?: table }[]
---@return boolean
function Cart.canCarry(inv, lines)
	local weight = 0

	for i = 1, #lines do
		weight += (lines[i].item.weight or 0) * lines[i].count
	end

	if not Inventory.CanCarryWeight(inv, weight) then return false end

	local _, _, emptySlots = Inventory.GetItemSlots(inv, lines[1].item)

	return (emptySlots or 0) >= Cart.slotsNeeded(inv, lines)
end

return Cart
