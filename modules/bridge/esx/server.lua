local Inventory = require 'modules.inventory.server'
local Items = require 'modules.items.server'

AddEventHandler('esx:playerDropped', server.playerDropped)

local ESX

---Builds the group table from every configured ESX job key (e.g. job, job2).
---@param player table xPlayer
---@param override? table<string, table> job data that may not be set on the xPlayer yet
---@return table<string, number>
local function getJobGroups(player, override)
	local groups = {}

	for i = 1, #shared.esxjobs do
		local key = shared.esxjobs[i]
		local job = override and override[key] or player[key]

		if not job and player.get then
			job = player.get(key)
		end

		if type(job) == 'table' and job.name then
			local grade = tonumber(job.grade) or 0

			if not groups[job.name] or groups[job.name] < grade then
				groups[job.name] = grade
			end
		end
	end

	return groups
end

for i = 1, #shared.esxjobs do
	local key = shared.esxjobs[i]

	-- esx:setJob, esx:setJob2, ...
	AddEventHandler(('esx:set%s'):format(key:gsub('^%l', string.upper)), function(source, job)
		local inventory = Inventory(source)
		if not inventory or not ESX then return end

		local player = ESX.GetPlayerFromId(source)
		if not player then return end

		inventory.player.groups = getJobGroups(player, { [key] = job })
	end)
end

SetTimeout(500, function()
    lib.checkDependency('es_extended', '1.6.0', true)

	ESX = exports.es_extended:getSharedObject()
    local customInventory = ESX.GetConfig().CustomInventory

	if customInventory ~= nil and customInventory ~= "ox" then
        error('es_extended has not been configured to enable support for ox_inventory!\nEnsure Config.CustomInventory has been set to "ox" in your es_extended resource config.')
    end

	server.UseItem = ESX.UseItem
	server.GetPlayerFromId = ESX.GetPlayerFromId

	for _, player in pairs(ESX.Players) do
		server.setPlayerInventory(player, player?.inventory)
	end
end)

server.accounts.black_money = 0

---@diagnostic disable-next-line: duplicate-set-field
function server.setPlayerData(player)
	return {
		source = player.source,
		name = player.name,
		groups = getJobGroups(player),
		sex = player.sex or player.variables.sex,
		dateofbirth = player.dateofbirth or player.variables.dateofbirth,
	}
end

---@diagnostic disable-next-line: duplicate-set-field
function server.syncInventory(inv)
	local accounts = Inventory.GetAccountItemCounts(inv)

    if accounts then
        local player = server.GetPlayerFromId(inv.id)
        player.syncInventory(inv.weight, inv.maxWeight, inv.items, accounts)
    end
end

---@diagnostic disable-next-line: duplicate-set-field
function server.hasLicense(inv, name)
	return MySQL.scalar.await('SELECT 1 FROM `user_licenses` WHERE `type` = ? AND `owner` = ?', { name, inv.owner })
end

---@diagnostic disable-next-line: duplicate-set-field
function server.buyLicense(inv, license)
	if server.hasLicense(inv, license.name) then
		return false, 'already_have'
	elseif Inventory.GetItemCount(inv, 'money') < license.price then
		return false, 'can_not_afford'
	end

	Inventory.RemoveItem(inv, 'money', license.price)
	TriggerEvent('esx_license:addLicense', inv.id, license.name)

	return true, 'have_purchased'
end

--- Takes traditional item data and updates it to support ox_inventory, i.e.
--- ```
--- Old: {"cola":1, "burger":3}
--- New: [{"slot":1,"name":"cola","count":1}, {"slot":2,"name":"burger","count":3}]
---```
---@diagnostic disable-next-line: duplicate-set-field
function server.convertInventory(playerId, items)
	if type(items) == 'table' then
		local player = server.GetPlayerFromId(playerId)
		local returnData, totalWeight = table.create(#items, 0), 0
		local slot = 0

		if player then
			for name in pairs(server.accounts) do
				if not items[name] then
					local account = player.getAccount(name)

					if account.money then
						items[name] = account.money
					end
				end
			end
		end

		for name, count in pairs(items) do
			local item = Items(name)

			if item and count > 0 then
				local metadata = Items.Metadata(playerId, item, false, count)
				local weight = Inventory.SlotWeight(item, {count=count, metadata=metadata})
				totalWeight = totalWeight + weight
				slot += 1
				returnData[slot] = {name = item.name, label = item.label, weight = weight, slot = slot, count = count, description = item.description, metadata = metadata, stack = item.stack, close = item.close}
			end
		end

		return returnData, totalWeight
	end
end

---@diagnostic disable-next-line: duplicate-set-field
function server.isPlayerBoss(playerId, group)
	local xPlayer = ESX.GetPlayerFromId(playerId)
	if not xPlayer then return false end

	for i = 1, #shared.esxjobs do
		local key = shared.esxjobs[i]
		local job = xPlayer[key] or (xPlayer.get and xPlayer.get(key))

		if type(job) == 'table' and (not group or job.name == group) and job.grade_name == 'boss' then
			return true
		end
	end

	return false
end

MySQL.ready(function()
	MySQL.insert('INSERT IGNORE INTO `licenses` (`type`, `label`) VALUES (?, ?)', { 'weapon', 'Weapon License'})
end)
