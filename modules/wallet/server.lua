if not lib then return end

local Inventory = require 'modules.inventory.server'
local WalletCash = require 'modules.wallet.cash'

---@param source number
---@param message string
local function notify(source, message)
	TriggerClientEvent('ox_lib:notify', source, { type = 'error', description = locale(message) })
end

---JSON numbers arrive as floats; accept only whole positive amounts.
---@param value any
---@return integer?
local function toAmount(value)
	local number = tonumber(value)

	if number and number > 0 and number == math.floor(number) and number < 2 ^ 31 then
		return math.tointeger(number)
	end
end

---@param source number
---@param slot any
---@return OxInventory?, table?
local function getWallet(source, slot)
	local inv = Inventory(source) --[[@as OxInventory?]]
	local wallet = inv and inv.player and inv.items[tonumber(slot)]

	if wallet and wallet.name == 'wallet' then
		return inv, wallet
	end
end

---@param inv OxInventory
---@param wallet table
---@param cash integer
local function setCash(inv, wallet, cash)
	local metadata = table.clone(wallet.metadata)
	metadata.cash = cash
	Inventory.SetMetadata(inv, wallet.slot, metadata)
end

---Moves loose cash into the wallet in `slot`.
---@return boolean, string?
local function deposit(source, slot, value)
	local inv, wallet = getWallet(source, slot)
	if not inv or not wallet then return false, 'invalid_wallet' end

	local amount = toAmount(value)
	if not amount then
		notify(source, 'wallet_invalid_amount')
		return false, 'invalid_amount'
	end

	local _, pocket = Inventory.GetItemSlots(inv, 'money')

	if (pocket or 0) < amount then
		notify(source, 'wallet_not_enough')
		return false, 'not_enough'
	end

	-- the pocket covers the amount, so RemoveItem never touches the wallets here
	if not Inventory.RemoveItem(inv, 'money', amount) then return false, 'not_enough' end

	local cash = math.floor(tonumber(wallet.metadata.cash) or 0) + amount
	setCash(inv, wallet, cash)
	lib.logger(inv.owner, 'wallet', ('"%s" put %s cash into their wallet (now %s)'):format(inv.label, amount, cash))

	return true
end

---Takes cash out of the wallet in `slot` into the pocket.
---@return boolean, string?
local function withdraw(source, slot, value)
	local inv, wallet = getWallet(source, slot)
	if not inv or not wallet then return false, 'invalid_wallet' end

	local amount = toAmount(value)
	if not amount then
		notify(source, 'wallet_invalid_amount')
		return false, 'invalid_amount'
	end

	local cash = math.floor(tonumber(wallet.metadata.cash) or 0)

	if cash < amount then
		notify(source, 'wallet_not_enough')
		return false, 'not_enough'
	end

	if not Inventory.CanCarryItem(inv, 'money', amount) then
		notify(source, 'wallet_cannot_carry')
		return false, 'cannot_carry'
	end

	setCash(inv, wallet, cash - amount)

	if not Inventory.AddItem(inv, 'money', amount) then
		setCash(inv, wallet, cash)
		notify(source, 'wallet_cannot_carry')
		return false, 'cannot_carry'
	end

	lib.logger(inv.owner, 'wallet', ('"%s" took %s cash out of their wallet (now %s)'):format(inv.label, amount, cash - amount))

	return true
end

lib.callback.register('ox_inventory:walletDeposit', deposit)
lib.callback.register('ox_inventory:walletWithdraw', withdraw)

---Searchable items (bank cards) in the player's wallets, by name, for client-side lookups.
---@param source number
---@return table<string, table[]>
local function getWalletItems(source)
	local inv = Inventory(source) --[[@as OxInventory?]]
	local items = {}

	if not inv then return items end

	for _, name in ipairs(WalletCash.settings().searchable or {}) do
		local found = Inventory.GetWalletItems(inv, name)

		if #found > 0 then items[name] = found end
	end

	return items
end

local pending = {}

---Sends the player's wallet cards to their client (batched to one push per tick).
---@param source number
local function pushWalletItems(source)
	if pending[source] then return end

	pending[source] = true

	SetTimeout(0, function()
		pending[source] = nil
		TriggerClientEvent('ox_inventory:walletItems', source, getWalletItems(source))
	end)
end

lib.callback.register('ox_inventory:getWalletItems', getWalletItems)

---Moves an item out of the open wallet into the pocket so it can be used.
---@return integer? pocket slot
lib.callback.register('ox_inventory:walletTakeOut', function(source, containerSlot)
	local inv = Inventory(source) --[[@as OxInventory?]]
	local wallet = inv and inv.containerSlot and inv.items[inv.containerSlot]

	if not wallet or wallet.name ~= 'wallet' or inv.open ~= wallet.metadata.container then return end

	local container = Inventory(wallet.metadata.container) --[[@as OxInventory?]]
	local item = container and container.items[tonumber(containerSlot)]

	if not item then return end

	local slot = Inventory.GetEmptySlot(inv)

	if not slot or not Inventory.CanCarryItem(inv, item.name, item.count, item.metadata) then
		notify(source, 'wallet_pocket_full')
		return
	end

	local name, count, metadata = item.name, item.count, item.metadata

	if not Inventory.RemoveItem(container, name, count, metadata, item.slot) then return end

	Inventory.AddItem(inv, name, count, metadata, slot)
	pushWalletItems(source)

	return slot
end)

-- dragging cash onto a wallet puts it inside
exports.ox_inventory:registerHook('swapItems', function(payload)
	local toSlot = payload.toSlot

	if payload.fromInventory ~= payload.source or payload.toInventory ~= payload.source then return end
	if type(toSlot) ~= 'table' or toSlot.name ~= 'wallet' then return end

	local source, slot, count = payload.source, toSlot.slot, payload.count

	SetTimeout(0, function() deposit(source, slot, count) end)

	return false
end, { itemFilter = { money = true } })

-- keep the client's copy of wallet cards current when wallets or their contents move
exports.ox_inventory:registerHook('swapItems', function(payload)
	local moved = type(payload.fromSlot) == 'table' and payload.fromSlot.name

	if payload.fromType == 'container' or payload.toType == 'container' or moved == 'wallet' then
		for _, id in ipairs({ payload.source, payload.fromInventory, payload.toInventory }) do
			if type(id) == 'number' then pushWalletItems(id) end
		end
	end
end)

-- taking a wallet out of someone else's inventory (robbing, /steal, searching)
exports.ox_inventory:registerHook('swapItems', function(payload)
	if payload.fromType ~= 'player' or payload.fromInventory == payload.source then return end

	local steal = WalletCash.settings().steal

	if steal == true then return end

	if steal == 'police' then
		local inv = Inventory(payload.source) --[[@as OxInventory?]]

		if inv and server.hasGroup(inv, shared.police) then return end
	end

	notify(payload.source, 'wallet_cannot_steal')

	return false
end, { itemFilter = { wallet = true } })
