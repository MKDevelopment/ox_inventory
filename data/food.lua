-- Food quality and spoiled food (works with esx_status hunger/thirst values from data/items.lua).
return {
	-- Status multiplier for metadata.quality 0 and 100 (linear in between). Items without quality use 1.0.
	quality = { min = 0.6, max = 1.15 },

	-- Food and drink tiers: how full a status can get from this kind of item (percent of the bar).
	-- Snacks can not fill you up past 25%, fast food past 50%; a proper meal in a restaurant fills to 100%.
	-- Set `tier = 'snack'` (etc.) on an item in data/items.lua. Items without a tier are not capped.
	tiers = {
		snack = { hunger = 25 },
		fastfood = { hunger = 50 },
		restaurant = { hunger = 100 },
		junkdrink = { thirst = 25 },
		hotdrink = { thirst = 50 },
		restaurantdrink = { thirst = 100 },
	},

	-- esx_status Config.StatusMax
	statusMax = 1000000,

	-- Spoiled items with `degrade` can still be eaten, at a cost, instead of being blocked.
	spoiledEdible = true,
	-- items with `degrade` that must stay blocked once spoiled
	notEdible = {},

	poison = {
		chance = 0.85,          -- chance that eating spoiled food poisons you
		statusMultiplier = 0.3, -- spoiled food only gives this share of its hunger/thirst
		duration = 90,          -- seconds
		tick = 6,               -- seconds between health losses
		damage = 3,             -- health lost per tick
		minHealth = 130,        -- never takes the player below this (200 is full, 100 is down)
		vomit = true,
		screenEffect = 'DrugsDrivingIn',
	},
}
