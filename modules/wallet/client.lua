if not lib then return end

---@param action 'walletDeposit' | 'walletWithdraw'
local function register(action)
	RegisterNUICallback(action, function(data, cb)
		cb(lib.callback.await('ox_inventory:' .. action, false, data.slot, data.amount) == true)
	end)
end

register('walletDeposit')
register('walletWithdraw')
