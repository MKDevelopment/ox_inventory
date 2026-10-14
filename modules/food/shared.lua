---Spoilage and metadata defaults for food, drinks and ingredients that do not set their own
---(see `spoilage` and `template` in data/food.lua). Pure, so items/shared.lua can use it on both sides.
local Defaults = {}

---@param data table item definition from data/items.lua
---@param config table data/food.lua
function Defaults.apply(data, config)
	local spoilage = config.spoilage
	local category = data.category

	if not spoilage or not category or not spoilage.categories?[category] then return end

	if data.degrade == nil then
		data.degrade = data.tier and spoilage.tiers?[data.tier] or spoilage.categories[category]
	end

	if data.template == nil and config.template then
		data.template = config.template
	end
end

return Defaults
