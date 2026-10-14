if not lib then return end

local Wallet = {}

---Searchable items (bank cards) in the player's wallets, sent by the server.
---@type table<string, table[]>
local walletItems = {}

RegisterNetEvent('ox_inventory:walletItems', function(items)
	walletItems = items or {}
end)

CreateThread(function()
	while not PlayerData.loaded do Wait(500) end
	walletItems = lib.callback.await('ox_inventory:getWalletItems', false) or {}
end)

---@param name string
---@return table[]
function Wallet.items(name)
	return walletItems[name] or {}
end

---Cash on the wallets in the player's inventory.
---@return integer
function Wallet.cash()
	local total = 0

	for _, slot in pairs(PlayerData.inventory or {}) do
		if slot.name == 'wallet' then
			total += math.floor(tonumber(slot.metadata?.cash) or 0)
		end
	end

	return total
end

---What wallets add to a lookup of `name`.
---@param name string
---@param metadata? table
---@param strict? boolean
---@return integer
function Wallet.count(name, metadata, strict)
	if name == 'money' then return metadata and 0 or Wallet.cash() end

	local count = 0
	local tablematch = strict and table.matches or table.contains

	for _, slot in ipairs(Wallet.items(name)) do
		if not metadata or tablematch(slot.metadata, metadata) then
			count += slot.count
		end
	end

	return count
end

---@param action 'walletDeposit' | 'walletWithdraw'
local function register(action)
	RegisterNUICallback(action, function(data, cb)
		cb(lib.callback.await('ox_inventory:' .. action, false, data.slot, data.amount) == true)
	end)
end

register('walletDeposit')
register('walletWithdraw')

-- using an item inside an open wallet takes it out to the pocket first
RegisterNUICallback('walletUse', function(slot, cb)
	cb(1)

	local pocketSlot = lib.callback.await('ox_inventory:walletTakeOut', false, slot)

	if pocketSlot then
		-- wait for the moved item to reach the client inventory
		local timeout = GetGameTimer() + 2000

		while not PlayerData.inventory[pocketSlot] and GetGameTimer() < timeout do Wait(0) end

		exports[shared.resource]:useSlot(pocketSlot)
	end
end)

return Wallet
