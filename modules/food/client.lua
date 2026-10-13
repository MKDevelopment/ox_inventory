if not lib then return end

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

---Applies an item's hunger/thirst values, scaled by quality and freshness.
---@param status table<string, number>
---@param metadata table
function Food.applyStatus(status, metadata)
	local spoiled = Food.isSpoiled(metadata)
	local multiplier = qualityMultiplier(metadata) * (spoiled and (poison.statusMultiplier or 0.3) or 1.0)
	local values = {}

	for name, value in pairs(status) do
		-- only scale what food gives; negative values (e.g. drunk, stress) stay as configured
		values[name] = value > 0 and math.floor(value * multiplier) or value
	end

	client.setPlayerStatus(values)

	if spoiled and math.random() < (poison.chance or 0.85) then
		poisonPlayer()
	end
end

return Food
