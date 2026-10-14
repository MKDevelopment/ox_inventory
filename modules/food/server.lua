if not lib then return end

local config = lib.load('data.food') or {}
local notEdible = {}

for _, name in ipairs(config.notEdible or {}) do
	notEdible[name] = true
end

local Food = {}

---Whether a spoiled item may still be used (eaten) instead of being blocked.
---@param item OxServerItem
---@return boolean
function Food.canEatSpoiled(item)
	return config.spoiledEdible == true and item.degrade ~= nil and not notEdible[item.name]
end

return Food
