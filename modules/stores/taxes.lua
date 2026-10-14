---Taxes included in store prices (vms_cityhall rates). Unowned shops pay the city at once; owned
---stores accrue the tax per period and settle it from their till when the period ends.
local config = (lib.load('data.stores') or {}).taxes or {}
local Items = Items or require 'modules.items.server'

local Taxes = {}
local rates = {}
local storage, getStore, saveCash

local DAY = 86400
local PERIODS = { weekly = 7, biweekly = 14 }

---@return table?
local function cityhall()
	return GetResourceState('vms_cityhall') == 'started' and exports.vms_cityhall or nil
end

---@param name string item name
---@return string path in vms_cityhall Config.Taxes
function Taxes.path(name)
	local item = Items(name)
	return config.items?[name] or (item and config.categories?[item.category]) or config.default or 'products.other'
end

---Tax percentage for an item; 0 without vms_cityhall or with taxes disabled.
---@param name string
---@return number
function Taxes.rate(name)
	if not config.enabled then return 0 end

	local resource = cityhall()
	if not resource then return 0 end

	local path = Taxes.path(name)

	if rates[path] == nil then
		local ok, _, _, percent = pcall(resource.getTaxAmount, resource, 100, path)
		rates[path] = ok and tonumber(percent) or 0
	end

	return rates[path]
end

---Tax contained in a gross (tax-inclusive) amount.
---@param gross integer
---@param percent number
---@return integer
function Taxes.included(gross, percent)
	if gross <= 0 or percent <= 0 then return 0 end
	return math.floor(gross * percent / (100 + percent) + 0.5)
end

---@param lines { name: string, total: integer }[]
---@return integer
function Taxes.forLines(lines)
	local tax = 0

	for i = 1, #lines do
		tax += Taxes.included(lines[i].total, Taxes.rate(lines[i].name))
	end

	return tax
end

---Start and end (unix seconds) of the period `now` falls in.
---@param now integer
---@return integer, integer
local function periodBounds(now)
	local days = PERIODS[config.period]

	if days then
		-- weeks start on Monday 00:00 UTC (1970-01-05 was a Monday)
		local length = days * DAY
		local start = now - ((now - 4 * DAY) % length)
		return start, start + length
	end

	local date = os.date('*t', now)
	local start = os.time({ year = date.year, month = date.month, day = 1, hour = 0 })
	local nextMonth = os.time({ year = date.year + (date.month == 12 and 1 or 0), month = date.month % 12 + 1, day = 1, hour = 0 })
	return start, nextMonth
end

---@param store table? MyStory store, nil for default ox shops
local function isOwned(store)
	return store ~= nil and (store.owner ~= nil or store.job ~= nil)
end

---Records the tax of one sale: unowned shops pay the city budget, owned stores accrue it.
---@param store table?
---@param sales integer gross amount of the sale
---@param tax integer tax included in it
function Taxes.collect(store, sales, tax)
	if tax <= 0 then return end

	if not isOwned(store) then
		local resource = cityhall()
		if resource then pcall(resource.addCompanyMoney, resource, tax, true) end
		return
	end

	local start, finish = periodBounds(os.time())
	storage.add(store.id, start, finish, sales, tax)
end

---Tax a store still owes (open period and arrears); the till cannot pay this out.
---@param storeId integer
---@return integer
function Taxes.owed(storeId)
	return storage.owed(storeId) or 0
end

---Settles every ended period from the store's till; what the till cannot cover stays overdue.
function Taxes.settle()
	local resource = cityhall()

	for _, row in ipairs(storage.due(os.time())) do
		local store = getStore(row.store)
		local due = row.tax - row.paid

		if store and due > 0 then
			local take = math.min(math.max(store.cash or 0, 0), due)
			local paid = row.paid + take
			local status = paid >= row.tax and 'settled' or 'overdue'

			-- the expected paid value guards against settling the same row twice
			if (take > 0 or status ~= row.status) and storage.update(row.id, paid, status, row.paid) == 1 then
				if take > 0 then
					store.cash -= take
					saveCash(store)
					if resource then pcall(resource.addCompanyMoney, resource, take, true) end
				end

				if Taxes.onSettled then Taxes.onSettled(store, row, take, status) end
			end
		elseif due <= 0 then
			storage.update(row.id, row.paid, 'settled', row.paid)
		end
	end
end

---Current period and past periods of a store for the manage panel.
---@param storeId integer
function Taxes.summary(storeId)
	local start, finish = periodBounds(os.time())
	local current = { start = start, finish = finish, sales = 0, tax = 0 }
	local history = {}

	for _, row in ipairs(storage.history(storeId)) do
		if row.period_start == start then
			current.sales, current.tax = row.sales, row.tax
		else
			history[#history + 1] = { start = row.period_start, finish = row.period_end, sales = row.sales, tax = row.tax, paid = row.paid, status = row.status }
		end
	end

	table.sort(history, function(a, b) return a.start > b.start end)

	return { current = current, history = history, owed = Taxes.owed(storeId), period = config.period or 'monthly' }
end

---@param options { storage: table, getStore: fun(id: integer): table?, saveCash: fun(store: table) }
function Taxes.init(options)
	storage, getStore, saveCash = options.storage, options.getStore, options.saveCash
end

---MySQL-backed storage used by the server.
function Taxes.mysqlStorage()
	MySQL.query.await([[
		CREATE TABLE IF NOT EXISTS `mystory_store_taxes` (
			`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
			`store` INT UNSIGNED NOT NULL,
			`period_start` INT UNSIGNED NOT NULL,
			`period_end` INT UNSIGNED NOT NULL,
			`sales` INT UNSIGNED NOT NULL DEFAULT 0,
			`tax` INT UNSIGNED NOT NULL DEFAULT 0,
			`paid` INT UNSIGNED NOT NULL DEFAULT 0,
			`status` VARCHAR(10) NOT NULL DEFAULT 'open',
			PRIMARY KEY (`id`),
			UNIQUE KEY `store_period` (`store`, `period_start`)
		)
	]])

	return {
		add = function(store, start, finish, sales, tax)
			MySQL.insert('INSERT INTO `mystory_store_taxes` (`store`, `period_start`, `period_end`, `sales`, `tax`) VALUES (?, ?, ?, ?, ?) ON DUPLICATE KEY UPDATE `sales` = `sales` + VALUES(`sales`), `tax` = `tax` + VALUES(`tax`)', {
				store, start, finish, sales, tax,
			})
		end,
		due = function(now)
			return MySQL.query.await('SELECT * FROM `mystory_store_taxes` WHERE (`status` = "open" AND `period_end` <= ?) OR `status` = "overdue"', { now }) or {}
		end,
		update = function(id, paid, status, expectedPaid)
			return MySQL.update.await('UPDATE `mystory_store_taxes` SET `paid` = ?, `status` = ? WHERE `id` = ? AND `paid` = ?', { paid, status, id, expectedPaid })
		end,
		owed = function(store)
			return tonumber(MySQL.scalar.await('SELECT COALESCE(SUM(`tax` - `paid`), 0) FROM `mystory_store_taxes` WHERE `store` = ? AND `status` <> "settled"', { store })) or 0
		end,
		history = function(store)
			return MySQL.query.await('SELECT * FROM `mystory_store_taxes` WHERE `store` = ? ORDER BY `period_start` DESC LIMIT 12', { store }) or {}
		end,
	}
end

return Taxes
