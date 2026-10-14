-- Player/job-run stores with a stock room and a cart. Admins manage them in game with /stores (see `command`).
return {
	command = 'stores',

	-- Shopkeeper interaction: 'auto' (tgiann-target when started, else ox_target), 'ox_target' or 'tgiann-target'.
	-- Without either, stores fall back to a marker and the E key.
	target = 'auto',
	-- Default ox shops (data/shops.lua) open in this store UI (cart, payment choice) instead of the slot grid.
	shopsInStoreUi = true,

	-- Ped used when a store has no model of its own (set per store in /stores).
	defaultPed = { model = 'mp_m_shopkeep_01', scenario = 'WORLD_HUMAN_STAND_IMPATIENT' },
	adminAce = 'group.admin',

	-- Payment options offered at checkout, built from what the player carries:
	-- cash = money in the pocket and wallets; personal / business = tgg-banking debit cards in the
	-- inventory or a wallet. Shared cards are never offered (tgg-banking cannot charge them).
	payments = { cash = true, personal = true, business = true },

	-- Metadata keys of tgg-banking cards (first key found wins)
	cardFields = {
		id = { 'cardId', 'id' },
		number = { 'cardNumber' },
		name = { 'displayName' },
	},

	-- A business card pays from the account of one of the holder's jobs whose tgg-banking account
	-- name equals the card's name. true: if no name matches, use the holder's only job account.
	businessCardFallback = false,

	-- Add card purchases to the account history in tgg-banking (AddTransaction).
	-- Turn off if personal card payments show up twice because tgg-banking already logs ESX bank changes.
	recordTransactions = true,

	interactDistance = 5.0,
	stockSlots = 60,
	stockWeight = 500000,

	-- Personal card payments: the player's ESX bank account (tgg-banking's personal account in ESX mode).
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
		-- refunds when items could not be handed over after paying
		add = function(source, amount)
			local player = exports.es_extended:getSharedObject().GetPlayerFromId(source)
			if player then player.addAccountMoney('bank', amount) end
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
