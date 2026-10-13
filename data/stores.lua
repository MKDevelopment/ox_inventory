-- Player/job-run stores with a stock room and a cart. Manage them in game with /sklepy (admins).
return {
	command = 'sklepy',
	adminAce = 'group.admin',

	-- 'cash' uses the money item, 'bank' the ESX bank account
	paymentMethods = { 'cash', 'bank' },

	interactDistance = 5.0,
	stockSlots = 60,
	stockWeight = 500000,

	marker = { type = 29, colour = { 124, 92, 255 }, scale = { 0.5, 0.5, 0.5 } },
	defaultBlip = { sprite = 52, colour = 27, scale = 0.7 },
}
