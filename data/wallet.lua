return {
	-- container size of the wallet item
	slots = 10,
	maxWeight = 500,

	-- items that inventory lookups also find inside the player's wallets, so scripts such as the
	-- tgg-banking ATM see a card kept in the wallet
	searchable = {
		'debitcard_personal', 'debitcard_shared', 'debitcard_business',
		-- vms_documentsv2 documents, so licence checks and police see a document kept in the wallet
		'id_card', 'driving_license', 'boat_license', 'flying_license', 'weapon_license',
		'police_badge', 'sheriff_badge', 'fib_badge',
	},

	-- who may take a wallet out of another player's inventory (robbing, /steal, searching):
	-- false = nobody, 'police' = only jobs in inventory:police, true = anyone
	steal = 'police',
}
