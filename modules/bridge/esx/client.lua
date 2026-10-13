local ESX = setmetatable({}, {
	__index = function(self, index)
		local obj = exports.es_extended:getSharedObject()
		self.SetPlayerData = obj.SetPlayerData
		self.PlayerLoaded = obj.PlayerLoaded
		self.GetPlayerData = obj.GetPlayerData
		return self[index]
	end
})

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerData(key, value)
	PlayerData[key] = value
	ESX.SetPlayerData(key, value)
end

---@diagnostic disable-next-line: duplicate-set-field
function client.setPlayerStatus(values)
	for name, value in pairs(values) do
		if value > 0 then TriggerEvent('esx_status:add', name, value) else TriggerEvent('esx_status:remove', name, -value) end
	end
end

RegisterNetEvent('esx:onPlayerLogout', client.onLogout)

local jobKeys = {}

for i = 1, #shared.esxjobs do
	jobKeys[shared.esxjobs[i]] = true
end

---Rebuilds groups from every configured ESX job key (e.g. job, job2).
---@param key string
---@param job table
local function updateJobGroups(key, job)
	if not PlayerData.loaded then return end

	local esxData = ESX.GetPlayerData() or {}
	local groups = {}

	for i = 1, #shared.esxjobs do
		local jobKey = shared.esxjobs[i]
		local data = jobKey == key and job or esxData[jobKey]

		if type(data) == 'table' and data.name then
			local grade = tonumber(data.grade) or 0

			if not groups[data.name] or groups[data.name] < grade then
				groups[data.name] = grade
			end
		end
	end

	PlayerData.groups = groups
	OnPlayerData('groups', groups)
end

AddEventHandler('esx:setPlayerData', function(key, value)
	if not PlayerData.loaded or GetInvokingResource() ~= 'es_extended' then return end

	if jobKeys[key] then
		return updateJobGroups(key, value)
	end

	PlayerData[key] = value
	OnPlayerData(key, value)
end)

-- Some job2 implementations only send esx:setJob2 to the client without calling ESX.SetPlayerData.
for key in pairs(jobKeys) do
	if key ~= 'job' then
		RegisterNetEvent(('esx:set%s'):format(key:gsub('^%l', string.upper)), function(job)
			if type(job) ~= 'table' then return end
			updateJobGroups(key, job)
		end)
	end
end

local Weapon = require 'modules.weapon.client'

RegisterNetEvent('esx_policejob:handcuff', function()
	PlayerData.cuffed = not PlayerData.cuffed
	client.player:setr('invBusy', PlayerData.cuffed)

	if not PlayerData.cuffed then return end

	Weapon.Disarm()
end)

RegisterNetEvent('esx_policejob:unrestrain', function()
	PlayerData.cuffed = false
	client.player:setr('invBusy', false)
end)

-- rcore_police does not use the esx_policejob events, so poll its cuff state instead.
CreateThread(function()
	local cuffed = false

	while true do
		Wait(500)

		if PlayerData.loaded and GetResourceState('rcore_police') == 'started' then
			local success, result = pcall(function()
				return exports.rcore_police:IsPlayerCuffed()
			end)
			local isCuffed = success and result == true

			if isCuffed ~= cuffed then
				cuffed = isCuffed
				PlayerData.cuffed = isCuffed
				client.player:setr('invBusy', isCuffed)

				if isCuffed then
					client.closeInventory()
					Weapon.Disarm()
				end
			elseif isCuffed and not LocalPlayer.state.invBusy then
				-- something else (e.g. finishing an item use) cleared invBusy while still cuffed
				client.player:setr('invBusy', true)
			end
		end
	end
end)
