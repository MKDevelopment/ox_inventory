---Payment options built from what the player carries: cash (pocket and wallets) and tgg-banking
---debit cards (pocket and wallets). Used by every store checkout.
local Inventory = require 'modules.inventory.server'

local config = lib.load('data.stores') or {}
local allowed = config.payments or { cash = true, personal = true, business = true }
local fields = config.cardFields or { id = { 'cardId', 'id' }, number = { 'cardNumber' }, name = { 'displayName' } }

-- shared cards are not offered: tgg-banking has no export to charge a shared account
local CARD_KINDS = { debitcard_personal = 'personal', debitcard_business = 'business' }

local Payments = {}

---@class PaymentOption
---@field id string 'cash' or 'card:<cardId>'
---@field kind 'cash' | 'personal' | 'business'
---@field label? string
---@field last4? string
---@field balance integer
---@field disabled? 'frozen' | 'no_access'
---@field cardId? number private
---@field iban? number private
---@field society? string private

---@return table?
local function banking()
	return GetResourceState('tgg-banking') == 'started' and exports['tgg-banking'] or nil
end

---Calls a tgg-banking export; nil when the resource is missing or the call fails.
local function bank(fn, ...)
	local resource = banking()
	if not resource then return end

	local ok, result = pcall(resource[fn], resource, ...)

	if ok then return result end
end

---@param metadata table
---@param keys string[]
local function readField(metadata, keys)
	for i = 1, #keys do
		local value = metadata[keys[i]]
		if value ~= nil then return value end
	end
end

---The business account a card pays from: one of the player's jobs whose tgg-banking account
---carries the card's name, or the only job with an account.
---@return table? account, string? society
local function businessAccount(source, cardName)
	local player = server.GetPlayerFromId(source)
	if not player then return end

	local found, foundSociety, count = nil, nil, 0

	for _, key in ipairs(shared.esxjobs or { 'job' }) do
		local job = player[key] or (player.get and player.get(key))
		local account = type(job) == 'table' and job.name and bank('GetSocietyAccount', job.name)

		if account then
			if cardName and account.name == cardName then return account, job.name end

			count += 1
			found, foundSociety = account, job.name
		end
	end

	if count == 1 then return found, foundSociety end
end

---@param source number
---@param slot table card slot data
---@return PaymentOption?
local function cardOption(source, slot, kind)
	local metadata = slot.metadata or {}
	local cardId = tonumber(readField(metadata, fields.id))
	if not cardId then return end

	local number = tostring(readField(metadata, fields.number) or '')
	local name = readField(metadata, fields.name)

	---@type PaymentOption
	local option = {
		id = ('card:%d'):format(cardId),
		kind = kind,
		label = name,
		last4 = number:gsub('%D', ''):sub(-4),
		balance = 0,
		cardId = cardId,
	}

	if kind == 'personal' then
		local account = bank('GetPersonalAccountByPlayerId', source)
		local ok, balance = pcall(config.bank.getBalance, source)

		option.iban = account?.iban
		option.balance = math.floor(ok and tonumber(balance) or 0)
	else
		local account, society = businessAccount(source, name)

		if not account then
			option.disabled = 'no_access'
		else
			option.iban, option.society = account.iban, society
			option.balance = math.floor(tonumber(account.balance) or 0)
		end
	end

	if bank('IsCardFrozen', cardId) or bank('IsCardTerminated', cardId) or (option.iban and bank('IsAccountFrozen', option.iban)) then
		option.disabled = 'frozen'
	end

	return option
end

---Every option with its private fields (card id, account), resolved from the player's items now.
---@param source number
---@return PaymentOption[]
local function resolveAll(source)
	local options = {}
	local inv = Inventory(source)

	if not inv then return options end

	if allowed.cash ~= false then
		local cash = Inventory.GetItemCount(inv, 'money') or 0

		if cash > 0 then
			options[#options + 1] = { id = 'cash', kind = 'cash', balance = cash }
		end
	end

	if not banking() then return options end

	local seen = {}

	for itemName, kind in pairs(CARD_KINDS) do
		if allowed[kind] ~= false then
			for _, slot in ipairs(Inventory.GetSlotsWithItem(inv, itemName) or {}) do
				local option = cardOption(source, slot, kind)

				if option and not seen[option.id] then
					seen[option.id] = true
					options[#options + 1] = option
				end
			end
		end
	end

	table.sort(options, function(a, b)
		if (a.kind == 'cash') ~= (b.kind == 'cash') then return a.kind == 'cash' end
		return a.id < b.id
	end)

	return options
end

---@param source number
---@param id string
---@return PaymentOption?
function Payments.resolve(source, id)
	for _, option in ipairs(resolveAll(source)) do
		if option.id == id then return option end
	end
end

---Options for the store UI (without account details).
---@param source number
---@return PaymentOption[]
function Payments.list(source)
	local options = resolveAll(source)

	for i = 1, #options do
		local option = options[i]
		options[i] = {
			id = option.id,
			kind = option.kind,
			label = option.label,
			last4 = option.last4,
			balance = option.balance,
			disabled = option.disabled,
		}
	end

	return options
end

---Takes `amount` with the chosen option, re-checked against what the player carries right now.
---@param source number
---@param id string
---@param amount integer
---@param reason string shown in the bank history
---@return boolean, string?
function Payments.charge(source, id, amount, reason)
	local option = type(id) == 'string' and Payments.resolve(source, id)

	if not option then return false, 'store_payment_invalid' end
	if option.disabled then return false, 'store_card_' .. option.disabled end
	if option.balance < amount then return false, 'store_cannot_afford' end

	if option.kind == 'cash' then
		return Inventory.RemoveItem(source, 'money', amount) and true or false, 'store_cannot_afford'
	end

	local ok

	if option.kind == 'personal' then
		local success, result = pcall(config.bank.remove, source, amount, reason)
		ok = success and result
	else
		ok = bank('RemoveSocietyMoney', option.society, amount) == true
	end

	if not ok then return false, 'store_cannot_afford' end

	if config.recordTransactions ~= false and option.iban then
		bank('AddTransaction', nil, option.iban, 'purchase', amount, reason, nil, option.cardId, reason)
	end

	return true
end

return Payments
