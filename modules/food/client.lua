if not lib then return end

local Items = require 'modules.items.shared'
local config = lib.load('data.food') or {}
local poison = config.poison or {}
local poisoned = false

local Food = {}

---@param metadata table
---@return boolean
function Food.isSpoiled(metadata)
	local durability = metadata?.durability
	if not metadata?.degrade or type(durability) ~= 'number' then return false end

	-- timestamps above 100 are expiry times; anything at or below 0 was already marked spoiled
	return durability > 100 and durability < GetCloudTimeAsInt() or durability <= 0
end

---@param metadata table
---@return number
local function qualityMultiplier(metadata)
	local quality = tonumber(metadata?.quality)
	if not quality or not config.quality then return 1.0 end

	quality = math.max(0, math.min(100, quality))
	return config.quality.min + (config.quality.max - config.quality.min) * quality / 100
end

local function poisonPlayer()
	if poisoned then return end
	poisoned = true

	lib.notify({ type = 'error', description = locale('food_poisoned') })

	CreateThread(function()
		local ped = cache.ped

		if poison.vomit then
			lib.requestAnimDict('oddjobs@taxi@tie')
			TaskPlayAnim(ped, 'oddjobs@taxi@tie', 'vomit_outside', 8.0, -8.0, 5000, 49, 0, false, false, false)
			RemoveAnimDict('oddjobs@taxi@tie')
		end

		if poison.screenEffect then AnimpostfxPlay(poison.screenEffect, 0, true) end

		local endsAt = GetGameTimer() + (poison.duration or 90) * 1000

		while GetGameTimer() < endsAt and not PlayerData.dead do
			Wait((poison.tick or 6) * 1000)

			ped = cache.ped
			local health = GetEntityHealth(ped)
			local minHealth = poison.minHealth or 130

			if health > minHealth then
				SetEntityHealth(ped, math.max(minHealth, health - (poison.damage or 3)))
			end
		end

		if poison.screenEffect then AnimpostfxStop(poison.screenEffect) end
		poisoned = false
	end)
end

---Current value of an esx_status status, or nil if it can not be read.
---@param name string
---@return number?
local function getStatusValue(name)
	local p = promise.new()

	TriggerEvent('esx_status:getStatus', name, function(status)
		p:resolve(status and status.val)
	end)

	SetTimeout(250, function()
		if p.state == 0 then p:resolve(nil) end
	end)

	return Citizen.Await(p)
end

---Limits each value so the status does not go past the tier cap (e.g. snacks only fill hunger to 25%).
---@param values table<string, number>
---@param itemName string?
---@return string? tierName set when the cap stopped the item from filling any status
local function applyTier(values, itemName)
	local tierName = itemName and Items[itemName]?.tier
	local tier = tierName and config.tiers?[tierName]

	if not tier then return end

	local max = config.statusMax or 1000000
	local blocked

	for name, value in pairs(values) do
		local capPercent = tier[name]

		if capPercent and value > 0 then
			local current = getStatusValue(name)

			if current then
				local cap = max * capPercent / 100
				values[name] = math.max(0, math.min(value, math.floor(cap - current)))
				if values[name] == 0 then blocked = tierName end
			end
		end
	end

	return blocked
end

---Applies an item's hunger/thirst values, scaled by quality and freshness and capped by its tier.
---@param status table<string, number>
---@param metadata table
---@param itemName string?
function Food.applyStatus(status, metadata, itemName)
	local spoiled = Food.isSpoiled(metadata)
	local multiplier = qualityMultiplier(metadata) * (spoiled and (poison.statusMultiplier or 0.3) or 1.0)
	local values = {}

	for name, value in pairs(status) do
		-- only scale what food gives; negative values (e.g. drunk, stress) stay as configured
		values[name] = value > 0 and math.floor(value * multiplier) or value
	end

	local blocked = applyTier(values, itemName)

	if blocked then
		lib.notify({ description = locale('food_tier_full', locale('tier_' .. blocked)) })
	end

	for name, value in pairs(values) do
		if value == 0 then values[name] = nil end
	end

	if next(values) then client.setPlayerStatus(values) end

	if spoiled and math.random() < (poison.chance or 0.85) then
		poisonPlayer()
	end
end

return Food
