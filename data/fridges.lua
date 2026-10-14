-- Fridges slow down food spoilage (items with `degrade`).
-- A factor of 4 means food lasts 4x longer while it is inside.
return {
	-- Inventories whose id matches one of these Lua patterns are fridges (e.g. housing stashes named "fridge_<house>").
	patterns = {
		['^fridge'] = 4,
	},

	-- Container items that act as portable fridges.
	coolers = {
		cooler = 3,
	},

	-- Stashes in data/stashes.lua can also set `fridge = <factor>`.
	-- Other resources can call exports.ox_inventory:registerFridge(inventoryId, factor).
}
