-- Food quality and spoiled food (works with esx_status hunger/thirst values from data/items.lua).
return {
	-- Status multiplier for metadata.quality 0 and 100 (linear in between). Items without quality use 1.0.
	quality = { min = 0.6, max = 1.15 },

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
