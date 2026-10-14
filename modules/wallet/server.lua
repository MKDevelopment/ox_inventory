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

-- dragging cash onto a wallet puts it inside
exports.ox_inventory:registerHook('swapItems', function(payload)
	local toSlot = payload.toSlot

	if payload.fromInventory ~= payload.source or payload.toInventory ~= payload.source then return end
	if type(toSlot) ~= 'table' or toSlot.name ~= 'wallet' then return end

	local source, slot, count = payload.source, toSlot.slot, payload.count

	SetTimeout(0, function() deposit(source, slot, count) end)

	return false
end, { itemFilter = { money = true } })

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
