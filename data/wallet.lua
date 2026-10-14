return {
	-- container size of the wallet item
	slots = 10,
	maxWeight = 500,

	-- items that inventory lookups also find inside the player's wallets, so scripts such as the
	-- tgg-banking ATM see a card kept in the wallet
	searchable = { 'debitcard_personal', 'debitcard_shared', 'debitcard_business' },

	-- who may take a wallet out of another player's inventory (robbing, /steal, searching):
	-- false = nobody, 'police' = only jobs in inventory:police, true = anyone
	steal = 'police',
}
