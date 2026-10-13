return {
	-- Metadata keys shown in the item tooltip, in this order.
	display = {
		{ quality = 'Jakość' },
		{ producer = 'Producent' },
		{ produced = 'Data produkcji' },
		{ batch = 'Partia' },
		{ note = 'Notatka' },
	},

	-- Players can rename items and attach a note from the context menu.
	editing = {
		labelLength = 32,
		noteLength = 120,
		cooldown = 2000,
		-- items that can never be renamed or annotated (documents, money, ...)
		deny = { 'money', 'black_money', 'identification', 'mastercard' },
	},
}

--[[ Metadata templates live on the item itself in data/items.lua, e.g.

	['burger'] = {
		template = {
			quality = { 60, 100 },     -- random integer in range
			producer = 'Burger Shot',  -- fixed value
			produced = 'date',         -- creation date (dd.mm.yyyy)
			batch = 'serial',          -- random batch code
		},
	},

Template values only fill keys that are not already set by whoever creates the item. ]]
