if not lib then return end

local Inventory = require 'modules.inventory.server'

local config = lib.load('data.fridges') or {}
local patterns = config.patterns or {}
local coolers = config.coolers or {}
local registered = {}

for _, stash in pairs(lib.load('data.stashes') or {}) do
	if stash.fridge then registered[stash.name] = stash.fridge end
end

---Makes an inventory (e.g. a housing stash) slow down spoilage by `factor`; nil removes it.
---@param inventoryId string
---@param factor number?
local function registerFridge(inventoryId, factor)
	if factor and (type(factor) ~= 'number' or factor <= 0) then
		return TypeError('factor', 'positive number', type(factor))
	end

	registered[inventoryId] = factor
end

exports('registerFridge', registerFridge)

---@param inv OxInventory
---@param source number?
---@return number
local function getFactor(inv, source)
	if inv.type == 'container' then
		local playerInv = source and Inventory(source) --[[@as OxInventory?]]
		local containerItem = playerInv?.containerSlot and playerInv.items[playerInv.containerSlot]

		return containerItem and coolers[containerItem.name] or 1
	end

	if inv.type ~= 'stash' then return 1 end

	local id = tostring(inv.id)
	local baseId = inv.dbId or id:match('^[^:]+')

	if registered[id] then return registered[id] end
	if registered[baseId] then return registered[baseId] end

	for pattern, factor in pairs(patterns) do
		if id:match(pattern) then return factor end
	end

	return 1
end

---Rescales the expiry of a spoiling item to the rate of the inventory it is in.
---Percentage stays the same: remaining time and total lifetime are both scaled by the same ratio.
---@param inv OxInventory
---@param slotId number
---@param factor number
local function normalizeSlot(inv, slotId, factor)
	local slot = inv.items[slotId]
	if not slot then return end

	local metadata = slot.metadata
	local durability, degrade = metadata.durability, metadata.degrade

	-- only items with a timestamp-based durability spoil over time
	if type(durability) ~= 'number' or durability <= 100 or type(degrade) ~= 'number' then return end

	local current = metadata.cooled or 1
	if current == factor then return end

	local now = os.time()
	local ratio = factor / current
	local remaining = math.max(0, durability - now)

	metadata = table.clone(metadata)
	metadata.durability = now + math.floor(remaining * ratio)
	metadata.degrade = degrade * ratio
	metadata.cooled = factor ~= 1 and factor or nil

	Inventory.SetMetadata(inv, slotId, metadata)
end

---@param invId any
---@param slotId number?
---@param source number?
local function normalize(invId, slotId, source)
	if not slotId then return end

	local inv = Inventory(invId) --[[@as OxInventory?]]
	if not inv then return end

	normalizeSlot(inv, slotId, getFactor(inv, source))
end

-- Runs after the swap has been applied (hooks run before it), for both sides of the move.
exports.ox_inventory:registerHook('swapItems', function(payload)
	if payload.fromInventory == payload.toInventory then return end

	local fromSlot = type(payload.fromSlot) == 'table' and payload.fromSlot.slot or payload.fromSlot
	local toSlot = type(payload.toSlot) == 'table' and payload.toSlot.slot or payload.toSlot
	local fromInventory, toInventory, source = payload.fromInventory, payload.toInventory, payload.source

	-- dropping on the ground creates the drop after the hook; its id is generated up front
	if toInventory == 'newdrop' then toInventory = payload.dropId end

	SetTimeout(0, function()
		normalize(toInventory, toSlot, source)
		normalize(fromInventory, fromSlot, source)
	end)
end)
