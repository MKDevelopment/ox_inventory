if not lib then return end

local Inventory = require 'modules.inventory.server'
local Items = require 'modules.items.server'

local config = lib.load('data.stores') or {}
local STOCK_PREFIX = 'storestock_'

---Whole number from NUI/JSON input (which may arrive as 5.0), or nil.
---@param value any
---@return integer?
local function toInt(value)
	value = tonumber(value)
	if value and value == math.floor(value) and value > -2^31 and value < 2^31 then return math.tointeger(value) end
end


local webhook = GetConvar('inventory:storeswebhook', '')

---@param title string
---@param description string
---@param colour number?
local function discordLog(title, description, colour)
	if webhook == '' then return end

	PerformHttpRequest(webhook, function() end, 'POST', json.encode({
		username = 'MyStory Sklepy',
		embeds = { { title = title, description = description, color = colour or 7101695, footer = { text = os.date('%d.%m.%Y %H:%M:%S') } } },
	}), { ['Content-Type'] = 'application/json' })
end

---@param source number
local function describePlayer(source)
	local inv = Inventory(source)
	return ('%s (ID %d, %s)'):format(inv and inv.label or GetPlayerName(source), source, inv and inv.owner or '?')
end

---@class StoreItem
---@field price number
---@field enabled boolean

---@class Store
---@field id number
---@field label string
---@field type 'infinite' | 'stock'
---@field coords vector3
---@field blip number?
---@field owner string? identifier of the owning character
---@field job string? job that runs the store
---@field grade number minimum job grade that may manage it
---@field cash number
---@field items table<string, StoreItem>

---@type table<number, Store>
local Stores = {}

MySQL.ready(function()
	MySQL.query.await([[
		CREATE TABLE IF NOT EXISTS `mystory_stores` (
			`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
			`label` VARCHAR(64) NOT NULL,
			`type` VARCHAR(16) NOT NULL DEFAULT 'stock',
			`coords` VARCHAR(128) NOT NULL,
			`blip` INT NULL DEFAULT NULL,
			`owner` VARCHAR(64) NULL DEFAULT NULL,
			`job` VARCHAR(32) NULL DEFAULT NULL,
			`grade` INT NOT NULL DEFAULT 0,
			`cash` INT UNSIGNED NOT NULL DEFAULT 0,
			PRIMARY KEY (`id`)
		)
	]])

	MySQL.query.await([[
		CREATE TABLE IF NOT EXISTS `mystory_store_items` (
			`store` INT UNSIGNED NOT NULL,
			`item` VARCHAR(64) NOT NULL,
			`price` INT UNSIGNED NOT NULL,
			`enabled` TINYINT(1) NOT NULL DEFAULT 1,
			PRIMARY KEY (`store`, `item`)
		)
	]])

	MySQL.query.await([[
		CREATE TABLE IF NOT EXISTS `mystory_store_sales` (
			`id` INT UNSIGNED NOT NULL AUTO_INCREMENT,
			`store` INT UNSIGNED NOT NULL,
			`buyer` VARCHAR(64) NULL DEFAULT NULL,
			`buyer_name` VARCHAR(64) NULL DEFAULT NULL,
			`items` TEXT NOT NULL,
			`total` INT UNSIGNED NOT NULL,
			`method` VARCHAR(8) NOT NULL,
			`created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
			PRIMARY KEY (`id`),
			KEY `store_created` (`store`, `created_at`)
		)
	]])

	if (config.salesRetentionDays or 90) > 0 then
		MySQL.update.await('DELETE FROM `mystory_store_sales` WHERE `created_at` < NOW() - INTERVAL ? DAY', { config.salesRetentionDays or 90 })
	end

	for _, row in ipairs(MySQL.query.await('SELECT * FROM `mystory_stores`') or {}) do
		local coords = json.decode(row.coords)

		Stores[row.id] = {
			id = row.id,
			label = row.label,
			type = row.type == 'infinite' and 'infinite' or 'stock',
			coords = vec3(coords.x, coords.y, coords.z),
			blip = row.blip,
			owner = row.owner,
			job = row.job,
			grade = row.grade,
			cash = row.cash,
			items = {},
		}
	end

	for _, row in ipairs(MySQL.query.await('SELECT * FROM `mystory_store_items`') or {}) do
		local store = Stores[row.store]

		if store and Items(row.item) then
			store.items[row.item] = { price = row.price, enabled = row.enabled == 1 }
		end
	end

	for _, store in pairs(Stores) do
		if store.type == 'stock' then
			exports.ox_inventory:RegisterStash(STOCK_PREFIX .. store.id, ('%s (magazyn)'):format(store.label), config.stockSlots or 60, config.stockWeight or 500000, nil, nil, store.coords)
		end
	end

	TriggerClientEvent('ox_inventory:storesUpdated', -1)
end)

---Public data sent to every client to place markers and blips.
local function getPoints()
	local points = {}

	for id, store in pairs(Stores) do
		points[#points + 1] = { id = id, label = store.label, coords = store.coords, blip = store.blip }
	end

	return points
end

lib.callback.register('ox_inventory:getStores', function()
	return getPoints()
end)

local function broadcastPoints()
	TriggerClientEvent('ox_inventory:storesUpdated', -1)
end

---@param source number
local function isAdmin(source)
	return IsPlayerAceAllowed(source, config.adminAce or 'group.admin')
end

---@param source number
---@param store Store
---@return boolean
local function canManage(source, store)
	if isAdmin(source) then return true end

	local inv = Inventory(source) --[[@as OxInventory?]]
	if not inv?.player then return false end

	if store.owner and store.owner == inv.owner then return true end

	if store.job then
		local grade = inv.player.groups[store.job]
		if grade and grade >= store.grade then return true end
	end

	return false
end

---@param source number
---@param store Store
local function isNear(source, store)
	local ped = GetPlayerPed(source)
	return ped ~= 0 and #(GetEntityCoords(ped) - store.coords) <= (config.interactDistance or 5.0)
end

-- Only managers may open a stock room, whichever way the open request arrives.
exports.ox_inventory:registerHook('openInventory', function(payload)
	local id = tonumber(tostring(payload.inventoryId):match('^' .. STOCK_PREFIX .. '(%d+)$'))
	local store = id and Stores[id]

	if store and not canManage(payload.source, store) then return false end
end, { inventoryFilter = { '^' .. STOCK_PREFIX } })

---Stock of every item in one pass over the stock room (instead of one pass per product).
---@param store Store
---@return table<string, number>
local function getAllStock(store)
	local counts = {}
	if store.type == 'infinite' then return setmetatable(counts, { __index = function() return 9999 end }) end

	local inv = Inventory(STOCK_PREFIX .. store.id)

	for _, slot in pairs(inv and inv.items or {}) do
		counts[slot.name] = (counts[slot.name] or 0) + slot.count
	end

	return setmetatable(counts, { __index = function() return 0 end })
end

---Everything a customer (and a manager) sees when opening the store.
lib.callback.register('ox_inventory:openStore', function(source, id)
	local store = Stores[toInt(id)]
	if not store or not isNear(source, store) then return end

	local products = {}
	local stockCounts = getAllStock(store)

	for name, entry in pairs(store.items) do
		if entry.enabled then
			local stock = stockCounts[name]

			products[#products + 1] = { name = name, price = entry.price, stock = stock }
		end
	end

	table.sort(products, function(a, b) return a.name < b.name end)

	local manage = canManage(source, store)
	local management

	if manage then
		management = { cash = store.cash, type = store.type, items = {} }

		for name, entry in pairs(store.items) do
			management.items[#management.items + 1] = {
				name = name,
				price = entry.price,
				enabled = entry.enabled,
				stock = stockCounts[name],
			}
		end

		table.sort(management.items, function(a, b) return a.name < b.name end)
	end

	return {
		id = store.id,
		label = store.label,
		products = products,
		management = management,
		methods = config.paymentMethods or { 'cash', 'bank' },
	}
end)

---@param source number
---@param method string
---@return number
local function getFunds(source, method)
	if method == 'cash' then
		return Inventory.GetItemCount(source, 'money') or 0
	end

	local ok, balance = pcall(config.bank.getBalance, source)
	return ok and tonumber(balance) or 0
end

---@param source number
---@param method string
---@param amount number
---@param reason string
---@return boolean
local function charge(source, method, amount, reason)
	if method == 'cash' then
		return Inventory.RemoveItem(source, 'money', amount) and true or false
	end

	local ok, removed = pcall(config.bank.remove, source, amount, reason)
	return ok and removed == true
end

local checkoutCooldown = {}

AddEventHandler('playerDropped', function()
	checkoutCooldown[source] = nil
end)

---Buys every line in the cart at once, or nothing.
lib.callback.register('ox_inventory:checkoutStore', function(source, id, cart, method)
	local store = Stores[toInt(id)]
	if not store or type(cart) ~= 'table' or (method ~= 'cash' and method ~= 'bank') then return false end
	if not lib.table.contains(config.paymentMethods or { 'cash', 'bank' }, method) then return false end
	if not isNear(source, store) then return false, 'store_too_far' end

	local now = GetGameTimer()
	if checkoutCooldown[source] and now - checkoutCooldown[source] < 1000 then return false end
	checkoutCooldown[source] = now

	local inv = Inventory(source) --[[@as OxInventory?]]
	if not inv?.player or Player(source).state.invBusy then return false end

	local lines, total, totalWeight = {}, 0, 0
	local stockCounts = getAllStock(store)

	for name, count in pairs(cart) do
		count = toInt(count)

		local entry = type(name) == 'string' and store.items[name]
		local item = entry and Items(name)

		if not entry or not entry.enabled or not item or not count or count < 1 or count > 1000 then
			return false, 'store_cart_invalid'
		end

		if stockCounts[name] < count then return false, 'store_out_of_stock' end

		lines[#lines + 1] = { name = name, count = count, item = item }
		total += entry.price * count
		totalWeight += (item.weight or 0) * count
	end

	if #lines == 0 then return false end
	if getFunds(source, method) < total then return false, 'store_cannot_afford' end
	if not Inventory.CanCarryWeight(inv, totalWeight) then return false, 'cannot_carry' end

	for i = 1, #lines do
		if not Inventory.CanCarryItem(inv, lines[i].item, lines[i].count) then return false, 'cannot_carry' end
	end

	if not charge(source, method, total, ('Zakupy: %s'):format(store.label)) then return false, 'store_cannot_afford' end

	for i = 1, #lines do
		local line = lines[i]

		if store.type == 'infinite' then
			Inventory.AddItem(inv, line.name, line.count)
		else
			-- move the real items (with their metadata, e.g. freshness) out of the stock room
			local stockId = STOCK_PREFIX .. store.id
			local remaining = line.count

			for _, slot in pairs(Inventory.GetSlotsWithItem(stockId, line.name) or {}) do
				local take = math.min(remaining, slot.count)

				if Inventory.RemoveItem(stockId, line.name, take, slot.metadata, slot.slot) then
					Inventory.AddItem(inv, line.name, take, slot.metadata)
					remaining -= take
				end

				if remaining <= 0 then break end
			end
		end
	end

	if store.owner or store.job then
		store.cash += total
		MySQL.update('UPDATE `mystory_stores` SET `cash` = ? WHERE `id` = ?', { store.cash, store.id })
	end

	lib.logger(inv.owner, 'storeCheckout', ('"%s" paid %d (%s) in store %d (%s)'):format(inv.label, total, method, store.id, store.label))

	local summary = {}

	for i = 1, #lines do
		local line = lines[i]
		summary[i] = { name = line.name, count = line.count, price = store.items[line.name].price }
	end

	MySQL.insert('INSERT INTO `mystory_store_sales` (`store`, `buyer`, `buyer_name`, `items`, `total`, `method`) VALUES (?, ?, ?, ?, ?, ?)', {
		store.id, inv.owner, inv.label, json.encode(summary), total, method,
	})

	if config.receipts ~= false and Items('receipt') then
		local rows = {}

		for i = 1, #summary do
			local line = summary[i]
			rows[i] = ('%dx %s, $%d'):format(line.count, Items(line.name).label, line.price * line.count)
		end

		local receipt = {
			label = ('Paragon: %s'):format(store.label),
			description = ('%s  \n%s  \n**Razem: $%d** (%s)'):format(os.date('%d.%m.%Y %H:%M'), table.concat(rows, '  \n'), total, method == 'cash' and 'gotówka' or 'karta'),
			store = store.label,
			total = total,
		}

		if Inventory.CanCarryItem(inv, 'receipt', 1, receipt) then
			Inventory.AddItem(inv, 'receipt', 1, receipt)
		end
	end

	if total >= (config.logThreshold or 5000) then
		discordLog('Zakup', ('%s zapłacił **$%d** (%s) w sklepie #%d %s'):format(describePlayer(source), total, method, store.id, store.label))
	end

	return true, total
end)

---Manager actions: prices, assortment, cash withdrawal and the stock room.
lib.callback.register('ox_inventory:manageStore', function(source, id, action, data)
	local store = Stores[toInt(id)]
	if not store or not canManage(source, store) or not isNear(source, store) then return false end

	if action == 'setItem' then
		local name, price = data?.name, toInt(data?.price)

		if type(name) ~= 'string' or not Items(name) or not price or price < 0 or price > 10000000 then
			return false
		end

		local enabled = data.enabled ~= false
		store.items[name] = { price = price, enabled = enabled }

		MySQL.insert('INSERT INTO `mystory_store_items` (`store`, `item`, `price`, `enabled`) VALUES (?, ?, ?, ?) ON DUPLICATE KEY UPDATE `price` = VALUES(`price`), `enabled` = VALUES(`enabled`)', { store.id, name, price, enabled })

		return true
	elseif action == 'removeItem' then
		if type(data?.name) ~= 'string' then return false end

		store.items[data.name] = nil
		MySQL.update('DELETE FROM `mystory_store_items` WHERE `store` = ? AND `item` = ?', { store.id, data.name })

		return true
	elseif action == 'withdraw' then
		local amount = store.cash
		if amount <= 0 then return false end

		local inv = Inventory(source)
		if not Inventory.CanCarryItem(inv, 'money', amount) then return false, 'cannot_carry' end

		store.cash = 0
		Inventory.AddItem(inv, 'money', amount)
		MySQL.update('UPDATE `mystory_stores` SET `cash` = 0 WHERE `id` = ?', { store.id })
		lib.logger(inv.owner, 'storeWithdraw', ('withdrew %d from store %d (%s)'):format(amount, store.id, store.label))
		discordLog('Wypłata z kasy', ('%s wypłacił **$%d** ze sklepu #%d %s'):format(describePlayer(source), amount, store.id, store.label), 16098115)

		return true, amount
	elseif action == 'history' then
		local sales = MySQL.query.await('SELECT `buyer_name`, `items`, `total`, `method`, UNIX_TIMESTAMP(`created_at`) AS `time` FROM `mystory_store_sales` WHERE `store` = ? ORDER BY `id` DESC LIMIT ?', {
			store.id, config.historyLimit or 50,
		}) or {}

		local revenue = MySQL.single.await([[
			SELECT
				COALESCE(SUM(CASE WHEN `created_at` >= CURDATE() THEN `total` END), 0) AS `today`,
				COALESCE(SUM(CASE WHEN `created_at` >= NOW() - INTERVAL 7 DAY THEN `total` END), 0) AS `week`
			FROM `mystory_store_sales` WHERE `store` = ? AND `created_at` >= NOW() - INTERVAL 7 DAY
		]], { store.id }) or {}

		for i = 1, #sales do
			sales[i].items = json.decode(sales[i].items)
		end

		return true, { sales = sales, today = tonumber(revenue.today) or 0, week = tonumber(revenue.week) or 0 }
	elseif action == 'openStock' then
		if store.type ~= 'stock' then return false end

		return exports.ox_inventory:forceOpenInventory(source, 'stash', STOCK_PREFIX .. store.id) ~= nil
	end

	return false
end)

---@param source number
---@param data table
---@return table?
local function readStoreFields(source, data)
	if type(data) ~= 'table' or type(data.label) ~= 'string' then return end

	local label = data.label:gsub('[%c<>]', ''):sub(1, 64)
	if label == '' then return end

	local owner

	if data.ownerId then
		local ownerInv = Inventory(tonumber(data.ownerId))
		if not ownerInv?.player then return end
		owner = ownerInv.owner
	end

	return {
		label = label,
		type = data.type == 'infinite' and 'infinite' or 'stock',
		blip = toInt(data.blip),
		owner = owner,
		job = type(data.job) == 'string' and data.job ~= '' and data.job:sub(1, 32) or nil,
		grade = toInt(data.grade) or 0,
	}
end

---Admin panel: list, create at the admin's position, edit, move and delete stores.
lib.callback.register('ox_inventory:adminStores', function(source, action, data)
	if not isAdmin(source) then return false end

	if action == 'list' then
		local list = {}

		for id, store in pairs(Stores) do
			local count = 0
			for _ in pairs(store.items) do count += 1 end

			list[#list + 1] = {
				id = id,
				label = store.label,
				type = store.type,
				owner = store.owner,
				job = store.job,
				grade = store.grade,
				blip = store.blip,
				cash = store.cash,
				items = count,
				distance = #(GetEntityCoords(GetPlayerPed(source)) - store.coords),
			}
		end

		table.sort(list, function(a, b) return a.id < b.id end)
		return list
	elseif action == 'create' then
		local fields = readStoreFields(source, data)
		if not fields then return false end

		local coords = GetEntityCoords(GetPlayerPed(source))
		local id = MySQL.insert.await('INSERT INTO `mystory_stores` (`label`, `type`, `coords`, `blip`, `owner`, `job`, `grade`) VALUES (?, ?, ?, ?, ?, ?, ?)', {
			fields.label, fields.type, json.encode({ x = coords.x, y = coords.y, z = coords.z }), fields.blip, fields.owner, fields.job, fields.grade,
		})

		if not id then return false end

		Stores[id] = {
			id = id,
			label = fields.label,
			type = fields.type,
			coords = coords,
			blip = fields.blip,
			owner = fields.owner,
			job = fields.job,
			grade = fields.grade,
			cash = 0,
			items = {},
		}

		if fields.type == 'stock' then
			exports.ox_inventory:RegisterStash(STOCK_PREFIX .. id, ('%s (magazyn)'):format(fields.label), config.stockSlots or 60, config.stockWeight or 500000, nil, nil, coords)
		end

		broadcastPoints()
		discordLog('Nowy sklep', ('%s utworzył sklep #%d %s'):format(describePlayer(source), id, fields.label), 5763719)
		return true, id
	end

	local store = Stores[toInt(data?.id)]
	if not store then return false end

	if action == 'update' then
		local fields = readStoreFields(source, data)
		if not fields then return false end

		-- keep the current owner unless a new one is given or it is explicitly cleared
		if not data.ownerId and not data.clearOwner then fields.owner = store.owner end

		for k, v in pairs(fields) do store[k] = v end

		if store.type == 'stock' then
			exports.ox_inventory:RegisterStash(STOCK_PREFIX .. store.id, ('%s (magazyn)'):format(store.label), config.stockSlots or 60, config.stockWeight or 500000, nil, nil, store.coords)
		end

		MySQL.update('UPDATE `mystory_stores` SET `label` = ?, `type` = ?, `blip` = ?, `owner` = ?, `job` = ?, `grade` = ? WHERE `id` = ?', {
			store.label, store.type, store.blip, store.owner, store.job, store.grade, store.id,
		})

		broadcastPoints()
		discordLog('Edycja sklepu', ('%s zmienił sklep #%d %s (typ %s, praca %s %d+, właściciel %s)'):format(describePlayer(source), store.id, store.label, store.type, store.job or '-', store.grade, store.owner or '-'))
		return true
	elseif action == 'move' then
		store.coords = GetEntityCoords(GetPlayerPed(source))
		MySQL.update('UPDATE `mystory_stores` SET `coords` = ? WHERE `id` = ?', { json.encode({ x = store.coords.x, y = store.coords.y, z = store.coords.z }), store.id })

		if store.type == 'stock' then
			exports.ox_inventory:RegisterStash(STOCK_PREFIX .. store.id, ('%s (magazyn)'):format(store.label), config.stockSlots or 60, config.stockWeight or 500000, nil, nil, store.coords)
		end

		broadcastPoints()
		return true
	elseif action == 'delete' then
		discordLog('Usunięcie sklepu', ('%s usunął sklep #%d %s (w kasie $%d)'):format(describePlayer(source), store.id, store.label, store.cash), 15548997)
		Stores[store.id] = nil
		MySQL.update('DELETE FROM `mystory_stores` WHERE `id` = ?', { store.id })
		MySQL.update('DELETE FROM `mystory_store_items` WHERE `store` = ?', { store.id })

		broadcastPoints()
		return true
	end

	return false
end)
