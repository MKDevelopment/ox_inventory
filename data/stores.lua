-- Player/job-run stores with a stock room and a cart. Admins manage them in game with /stores (see `command`).
return {
	command = 'stores',
	adminAce = 'group.admin',

	-- 'cash' uses the money item, 'bank' the ESX bank account
	paymentMethods = { 'cash', 'bank' },

	interactDistance = 5.0,
	stockSlots = 60,
	stockWeight = 500000,

	-- Bank adapter used by card payments. Replace both functions if MyStory runs its own banking script.
	bank = {
		---@return number
		getBalance = function(source)
			local player = exports.es_extended:getSharedObject().GetPlayerFromId(source)
			local account = player and player.getAccount('bank')
			return account and account.money or 0
		end,
		---@return boolean
		remove = function(source, amount, reason)
			local player = exports.es_extended:getSharedObject().GetPlayerFromId(source)
			if not player then return false end
			player.removeAccountMoney('bank', amount, reason)
			return true
		end,
	},

	-- Discord logging: set the webhook on the server only, e.g.  set inventory:storeswebhook "https://discord.com/api/webhooks/..."
	-- Purchases are logged from this amount up; withdrawals and admin changes are always logged.
	logThreshold = 5000,

	-- Give buyers a receipt item listing what they paid for.
	receipts = true,

	-- How many recent sales the manage tab shows.
	historyLimit = 50,

	-- Sales older than this are deleted on resource start (0 keeps everything).
	salesRetentionDays = 90,

	marker = { type = 29, colour = { 124, 92, 255 }, scale = { 0.5, 0.5, 0.5 } },
	defaultBlip = { sprite = 52, colour = 27, scale = 0.7 },
}
