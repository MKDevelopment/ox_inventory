if not lib then return end

local config = lib.load('data.stores') or {}
local Target = require 'modules.target.client'
local Utils = require 'modules.utils.client'
local points, blips = {}, {}
local storeOpen = false

---@param point CPoint
local function removePed(point)
	if not point.entity then return end

	Target.removeLocalEntity(point.entity)
	Utils.DeleteEntity(point.entity)
	point.entity = nil
end

local function clearPoints()
	for _, point in pairs(points) do
		removePed(point)
		point:remove()
	end
	for _, blip in pairs(blips) do RemoveBlip(blip) end

	table.wipe(points)
	table.wipe(blips)
end

local function closeStoreUi()
	if not storeOpen then return end

	storeOpen = false
	SetNuiFocus(false, false)
	SendNUIMessage({ action = 'closeStore' })
end

---@param id number
---@param tab? 'manage'
local function openStore(id, tab)
	if storeOpen or not PlayerData.loaded or PlayerData.dead or LocalPlayer.state.invBusy then return end

	client.closeInventory()

	local data = lib.callback.await('ox_inventory:openStore', false, id)
	if not data then return end

	data.tab = tab
	storeOpen = true
	SetNuiFocus(true, true)
	SendNUIMessage({ action = 'openStore', data = data })
end

-- default ox shops (data/shops.lua) open here instead of the slot grid
client.shopsInStoreUi = config.shopsInStoreUi ~= false

---@param shopType string
---@param id? number
local function openShopStore(shopType, id)
	if storeOpen or not PlayerData.loaded or PlayerData.dead or LocalPlayer.state.invBusy then return end

	client.closeInventory()

	local data = lib.callback.await('ox_inventory:openShopStore', false, shopType, id)
	if not data then return lib.notify({ type = 'error', description = locale('store_too_far') }) end

	storeOpen = true
	SetNuiFocus(true, true)
	SendNUIMessage({ action = 'openStore', data = data })
end

AddEventHandler('ox_inventory:openShopStore', openShopStore)

---Spawns the shopkeeper when the player comes close (local entity, nothing networked).
---@param point CPoint
local function spawnPed(point)
	if point.entity then return end

	local pedConfig = config.defaultPed or {}
	local fallback = pedConfig.model or 'mp_m_shopkeep_01'

	-- a mistyped model in /stores must not break the store: fall back to the default ped
	local ok, model = pcall(lib.requestModel, point.store.ped or fallback)
	if not ok or not model then ok, model = pcall(lib.requestModel, fallback) end
	if not ok or not model then return end

	local coords = point.coords
	local entity = CreatePed(0, model, coords.x, coords.y, coords.z - 1.0, point.store.heading or 0.0, false, true)

	SetModelAsNoLongerNeeded(model)
	FreezeEntityPosition(entity, true)
	SetEntityInvincible(entity, true)
	SetBlockingOfNonTemporaryEvents(entity, true)

	if pedConfig.scenario then TaskStartScenarioInPlace(entity, pedConfig.scenario, 0, true) end

	local store = point.store
	local options = {
		{
			name = 'mystory_store_shop',
			icon = 'fas fa-shopping-basket',
			label = locale('store_target_shop'),
			distance = 2.5,
			onSelect = function() openStore(store.id) end,
		},
	}

	if store.manage then
		options[2] = {
			name = 'mystory_store_manage',
			icon = 'fas fa-clipboard-list',
			label = locale('store_target_manage'),
			distance = 2.5,
			onSelect = function() openStore(store.id, 'manage') end,
		}
	end

	Target.addLocalEntity(entity, options)
	point.entity = entity
end

local function createPoints()
	clearPoints()

	local stores = lib.callback.await('ox_inventory:getStores', false) or {}
	local marker = config.marker or {}
	local distance = config.interactDistance or 5.0

	for _, store in ipairs(stores) do
		local coords = vec3(store.coords.x, store.coords.y, store.coords.z)

		if store.blip ~= 0 then
			local blipConfig = config.defaultBlip or {}
			local blip = AddBlipForCoord(coords.x, coords.y, coords.z)

			SetBlipSprite(blip, store.blip or blipConfig.sprite or 52)
			SetBlipColour(blip, blipConfig.colour or 27)
			SetBlipScale(blip, blipConfig.scale or 0.7)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName('STRING')
			AddTextComponentSubstringPlayerName(store.label)
			EndTextCommandSetBlipName(blip)

			blips[#blips + 1] = blip
		end

		if Target.available() then
			points[#points + 1] = lib.points.new({
				coords = coords,
				distance = 40,
				store = store,
				onEnter = spawnPed,
				onExit = removePed,
			})

			goto continue
		end

		points[#points + 1] = lib.points.new({
			coords = coords,
			distance = 15,
			nearby = function(self)
				local colour, scale = marker.colour or { 124, 92, 255 }, marker.scale or { 0.5, 0.5, 0.5 }

				---@diagnostic disable-next-line: param-type-mismatch
				DrawMarker(marker.type or 29, self.coords.x, self.coords.y, self.coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scale[1], scale[2], scale[3], colour[1], colour[2], colour[3], 200, false, true, 2, false, nil, nil, false)

				if self.currentDistance <= distance and not storeOpen then
					if not self.textShown then
						self.textShown = true
						lib.showTextUI(locale('store_open', store.label))
					end

					if IsControlJustReleased(0, 38) then openStore(store.id) end
				elseif self.textShown then
					self.textShown = false
					lib.hideTextUI()
				end
			end,
			onExit = function(self)
				if self.textShown then
					self.textShown = false
					lib.hideTextUI()
				end
			end,
		})

		::continue::
	end
end

RegisterNetEvent('ox_inventory:storesUpdated', function()
	if source == '' then return end
	if PlayerData.loaded then createPoints() end
end)

-- the Manage option depends on the player's jobs
for _, key in ipairs(shared.esxjobs or { 'job' }) do
	RegisterNetEvent(('esx:set%s'):format(key:gsub('^%l', string.upper)), function()
		if PlayerData.loaded then SetTimeout(500, createPoints) end
	end)
end

CreateThread(function()
	while not PlayerData.loaded do Wait(500) end
	createPoints()
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == cache.resource then clearPoints() end
end)

RegisterNUICallback('storeClose', function(_, cb)
	cb(1)
	closeStoreUi()
end)

RegisterNUICallback('storeCheckout', function(data, cb)
	local shop = data.shop
	local success, result

	if shop then
		success, result = lib.callback.await('ox_inventory:checkoutShop', false, shop.type, shop.id, data.cart, data.payment)
	else
		success, result = lib.callback.await('ox_inventory:checkoutStore', false, data.id, data.cart, data.payment)
	end

	if success then
		lib.notify({ type = 'success', description = locale('store_paid', result) })
	elseif result then
		lib.notify({ type = 'error', description = locale(result) })
	end

	cb({
		success = success,
		store = shop and lib.callback.await('ox_inventory:openShopStore', false, shop.type, shop.id)
			or lib.callback.await('ox_inventory:openStore', false, data.id),
	})
end)

RegisterNUICallback('storeManage', function(data, cb)
	if data.action == 'openStock' then
		cb(1)
		closeStoreUi()
		return lib.callback.await('ox_inventory:manageStore', false, data.id, 'openStock')
	end

	local success, result = lib.callback.await('ox_inventory:manageStore', false, data.id, data.action, data.data)

	if data.action == 'withdraw' then
		if success then
			lib.notify({ type = 'success', description = locale('store_withdrawn', result) })
		elseif result then
			lib.notify({ type = 'error', description = locale(result) })
		end
	end

	if data.action == 'history' then return cb({ success = success, result = result }) end

	cb({ success = success, result = result, store = lib.callback.await('ox_inventory:openStore', false, data.id) })
end)

RegisterCommand(config.command or 'stores', function()
	if storeOpen or not PlayerData.loaded then return end

	local list = lib.callback.await('ox_inventory:adminStores', false, 'list')
	if not list then return end

	client.closeInventory()
	storeOpen = true
	SetNuiFocus(true, true)
	SendNUIMessage({ action = 'openStoreAdmin', data = list })
end, false)

RegisterNUICallback('storeAdmin', function(data, cb)
	local success, result = lib.callback.await('ox_inventory:adminStores', false, data.action, data.data)

	cb({ success = success, result = result, list = lib.callback.await('ox_inventory:adminStores', false, 'list') })
end)
