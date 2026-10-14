-- tgiann-clothing garments as items (c_* and clothe_set, metadata in the tgiann-clothing format).
-- Using a garment puts it on and returns what was worn in its place as an item; /clothing takes
-- garments off into items. Appearance changes go through tgiann-clothing (SetPedClothing + SaveSkin).
return {
	-- Command that opens the "take off" menu.
	command = 'clothing',

	-- Pocket wardrobe in the Clothing tab: carried garments, no weight, outside the main slots.
	wardrobe = { slots = 20 },

	-- Garment photos from tgiann-clothing-images (e.g. female_c_bag_10_3.webp), built from the garment's
	-- first part. Placeholders: {gender} (male/female), {item} (c_bag, ...), {category} (component/prop),
	-- {id}, {collection}, {index}, {texture}. nil shows the item image; a missing photo falls back to it.
	image = 'https://cfx-nui-tgiann-clothing-images/images/{gender}_{item}_{index}_{texture}.webp',

	-- Item used for whole outfits; it may contain any parts.
	set = 'clothe_set',

	-- Parts of each garment item: component ids or prop ids (see tgiann-clothing docs).
	items = {
		c_torso = { components = { 11, 8, 3 } },
		c_pants = { components = { 4 } },
		c_shoes = { components = { 6 } },
		c_mask = { components = { 1 } },
		c_bag = { components = { 5 } },
		c_necklace = { components = { 7 } },
		c_bproof = { components = { 9 } },
		c_decal = { components = { 10 } },
		c_helmet = { props = { 0 } },
		c_glasses = { props = { 1 } },
		c_ear = { props = { 2 } },
		c_watch = { props = { 6 } },
		c_bracelet = { props = { 7 } },
	},

	-- Menu order for /clothing.
	order = { 'c_helmet', 'c_glasses', 'c_mask', 'c_ear', 'c_necklace', 'c_torso', 'c_bproof', 'c_decal', 'c_bag', 'c_pants', 'c_shoes', 'c_watch', 'c_bracelet' },

	-- Drawables treated as "nothing worn" (base game collection), per freemode model hash.
	-- Components not listed count as nothing worn at drawable 0. Props are empty at index -1.
	naked = {
		[1885233650] = { [1] = 0, [3] = 15, [4] = 61, [5] = 0, [6] = 34, [7] = 0, [8] = 15, [9] = 0, [10] = 0, [11] = 15 },  -- mp_m_freemode_01
		[2627665880] = { [1] = 0, [3] = 15, [4] = 17, [5] = 0, [6] = 35, [7] = 0, [8] = 14, [9] = 0, [10] = 0, [11] = 15 },  -- mp_f_freemode_01
	},
}
