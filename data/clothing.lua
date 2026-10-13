-- Clothing as items (enable with `setr inventory:clothingitems true`).
-- Each category maps to an item. Taking a category off creates that item with the ped's current
-- drawables in its metadata; using the item puts it back on (swapping out whatever was worn).
return {
	-- Command that opens the "take off" menu.
	command = 'ubrania',

	-- Drawables treated as "nothing worn" per freemode ped. Verify these against your clothing packs (/skin).
	-- Components not listed default to drawable 0. Props are always empty when the index is -1.
	naked = {
		m = { [1] = 0, [3] = 15, [4] = 61, [5] = 0, [6] = 34, [7] = 0, [8] = 15, [9] = 0, [11] = 15 },
		f = { [1] = 0, [3] = 15, [4] = 17, [5] = 0, [6] = 35, [7] = 0, [8] = 14, [9] = 0, [11] = 15 },
	},

	-- Order defines the order in the menu.
	categories = {
		{ name = 'top', item = 'clothing_top', label = 'Góra', components = { 11, 8, 3 } },
		{ name = 'pants', item = 'clothing_pants', label = 'Spodnie', components = { 4 } },
		{ name = 'shoes', item = 'clothing_shoes', label = 'Buty', components = { 6 } },
		{ name = 'mask', item = 'clothing_mask', label = 'Maska', components = { 1 } },
		{ name = 'accessory', item = 'clothing_accessory', label = 'Akcesoria', components = { 7 } },
		{ name = 'vest', item = 'clothing_vest', label = 'Kamizelka', components = { 9 } },
		{ name = 'bag', item = 'clothing_bag', label = 'Torba', components = { 5 } },
		{ name = 'hat', item = 'clothing_hat', label = 'Czapka', props = { 0 } },
		{ name = 'glasses', item = 'clothing_glasses', label = 'Okulary', props = { 1 } },
		{ name = 'ears', item = 'clothing_ears', label = 'Kolczyki', props = { 2 } },
		{ name = 'watch', item = 'clothing_watch', label = 'Zegarek', props = { 6 } },
		{ name = 'bracelet', item = 'clothing_bracelet', label = 'Bransoletka', props = { 7 } },
	},

	---Persists the ped's current appearance in the clothing resource. Runs on the client after every change.
	---REQUIRED: without it the clothing resource restores the old outfit on relog, which lets players
	---take the same clothes off again (item duplication). Fill this in with the tgiann-clothing save export.
	---@type fun(ped: number)?
	saveAppearance = nil,
}
