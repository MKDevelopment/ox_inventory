---Default ox shops (data/shops.lua) in the MyStory store UI: products with a cart and the same
---payment options as MyStory stores. Licences, job grades, stock and distance are checked here.
if not lib then return end

local Inventory = require 'modules.inventory.server'
local Items = require 'modules.items.server'
local Payments = require 'modules.stores.payments'
local Cart = require 'modules.stores.cart'
local Taxes = require 'modules.stores.taxes'

local MAX_DISTANCE = 10.0
local checkoutCooldown = {}

AddEventHandler('playerDropped', function()
	checkoutCooldown[source] = nil
end)

---Whole number from NUI/JSON input (which may arrive as 5.0), or nil.
local function toInt(value)
	value = tonumber(value)
	if value and value == math.floor(value) and value > -2 ^ 31 and value < 2 ^ 31 then return math.tointeger(value) end
end

---@param grade number | number[]
---@param rank number?
local function hasGrade(grade, rank)
	if not rank then return false end

	if type(grade) == 'table' then
		for i = 1, #grade do
			if grade[i] == rank then return true end
		end

		return false
	end

	return rank >= grade
end

---The shop and the player's inventory, if the player may use it from where they stand.
---@return table? shop, OxInventory? inv, number? rank, string? error
local function getShop(source, shopType, id)
	local shop = type(shopType) == 'string' and server.getShop(shopType, toInt(id))
	local inv = Inventory(source) --[[@as OxInventory?]]

	if not shop or not inv?.player then return end

	local rank

	if shop.groups then
		local group, grade = server.hasGroup(inv, shop.groups)
		if not group then return end
		rank = grade
	end

	if shop.coords and #(GetEntityCoords(GetPlayerPed(source)) - shop.coords) > MAX_DISTANCE then
		return nil, nil, nil, 'store_too_far'
	end

	return shop, inv, rank
end

---Why a shop slot cannot be bought by this player, if it cannot.
---@return string?
local function lockReason(inv, slot, rank)
	if slot.license and server.hasLicense and not server.hasLicense(inv, slot.license) then return 'license' end
	if slot.grade and not hasGrade(slot.grade, rank) then return 'grade' end
end

lib.callback.register('ox_inventory:openShopStore', function(source, shopType, id)
	local shop, inv, rank = getShop(source, shopType, id)
	if not shop then return end

	local products = {}

	for index, slot in pairs(shop.items) do
		if Items(slot.name) then
			products[#products + 1] = {
				key = tostring(index),
				name = slot.name,
				price = slot.price or 0,
				stock = slot.count or 9999,
				currency = slot.currency ~= 'money' and slot.currency or nil,
				locked = lockReason(inv, slot, rank),
			}
		end
	end

	table.sort(products, function(a, b) return tonumber(a.key) < tonumber(b.key) end)

	return {
		id = 0,
		shop = { type = shopType, id = toInt(id) },
		label = shop.label,
		products = products,
		payments = Payments.list(source),
	}
end)

local LOCK_ERRORS = { license = 'item_unlicensed', grade = 'stash_lowgrade' }

---Buys the whole cart or nothing. Lines priced in another item (e.g. black_money) are paid with it.
lib.callback.register('ox_inventory:checkoutShop', function(source, shopType, id, cart, paymentId)
	if type(cart) ~= 'table' then return false end

	local shop, inv, rank, err = getShop(source, shopType, id)
	if not shop then return false, err end

	local now = GetGameTimer()
	if checkoutCooldown[source] and now - checkoutCooldown[source] < 1000 then return false end
	checkoutCooldown[source] = now

	if Player(source).state.invBusy then return false end

	-- one line per shop slot, even if the cart names a slot twice ('1' and 1)
	local counts = {}

	for key, value in pairs(cart) do
		local index, count = toInt(key), toInt(value)
		local slot = index and shop.items[index]

		if not slot or not Items(slot.name) or not count or count < 1 or count > 1000 then return false, 'store_cart_invalid' end

		counts[index] = (counts[index] or 0) + count
		if counts[index] > 1000 then return false, 'store_cart_invalid' end
	end

	local lines = {}

	-- licence checks may wait on the database, so they run before stock is reserved
	for index, count in pairs(counts) do
		local slot = shop.items[index]
		local locked = lockReason(inv, slot, rank)

		if locked then return false, LOCK_ERRORS[locked] end

		lines[#lines + 1] = { slot = slot, item = Items(slot.name), count = count, metadata = slot.metadata }
	end

	if #lines == 0 then return false end

	local moneyTotal, currencies = 0, {}

	for i = 1, #lines do
		local line = lines[i]
		if line.slot.count and line.slot.count < line.count then return false, 'store_out_of_stock' end

		local price = (line.slot.price or 0) * line.count
		local currency = line.slot.currency or 'money'

		if currency == 'money' then
			moneyTotal += price
		else
			currencies[currency] = (currencies[currency] or 0) + price
		end
	end

	for currency, amount in pairs(currencies) do
		if Inventory.GetItemCount(inv, currency) < amount then return false, 'store_cannot_afford' end
	end

	if not Cart.canCarry(inv, lines) then return false, 'cannot_carry' end

	-- reserve limited stock before paying, give it back if the payment fails
	for i = 1, #lines do
		local slot = lines[i].slot
		if slot.count then slot.count -= lines[i].count end
	end

	local option

	if moneyTotal > 0 then
		local paid, result = Payments.charge(source, paymentId, moneyTotal, locale('store_bank_reason', shop.label))

		if not paid then
			for i = 1, #lines do
				local slot = lines[i].slot
				if slot.count then slot.count += lines[i].count end
			end

			return false, result
		end

		option = result
	end

	for currency, amount in pairs(currencies) do
		Inventory.RemoveItem(inv, currency, amount)
	end

	local refundMoney, refundItems = 0, {}

	for i = 1, #lines do
		local line = lines[i]

		-- AddItem creates the metadata (weapon serials, food dates) and one slot per unique item
		if not Inventory.AddItem(inv, line.item.name, line.count, line.metadata and table.clone(line.metadata) or nil) then
			local price = (line.slot.price or 0) * line.count
			local currency = line.slot.currency or 'money'

			if line.slot.count then line.slot.count += line.count end
			line.refunded = true

			if currency == 'money' then
				refundMoney += price
			else
				refundItems[currency] = (refundItems[currency] or 0) + price
			end
		end
	end

	if refundMoney > 0 and option then Payments.refund(source, option, refundMoney) end

	for currency, amount in pairs(refundItems) do
		Inventory.AddItem(inv, currency, amount)
	end

	local paidTotal = moneyTotal - refundMoney
	local taxLines = {}

	for i = 1, #lines do
		local line = lines[i]

		if not line.refunded and (line.slot.currency or 'money') == 'money' then
			taxLines[#taxLines + 1] = { name = line.item.name, total = (line.slot.price or 0) * line.count }
		end
	end

	-- default shops have no owner: the tax included in the price goes to the City Hall budget
	Taxes.collect(nil, paidTotal, Taxes.forLines(taxLines))

	if server.loglevel > 0 and paidTotal >= 500 then
		lib.logger(inv.owner, 'buyItem', ('"%s" paid %d in %s'):format(inv.label, paidTotal, shop.label), ('shop:%s'):format(shop.label))
	end

	return true, paidTotal
end)
