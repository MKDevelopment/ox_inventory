---Wallet helpers shared by the inventory module and the wallet module.
---Cash lives on the wallet item (`metadata.cash`), so it counts as the player's cash without
---loading the wallet container; cards and documents are items inside the container.
local WalletCash = {}

local settings
local searchable

local function getSettings()
	if not settings then
		settings = lib.load('data.wallet') or {}
		searchable = {}

		for _, name in ipairs(settings.searchable or {}) do
			searchable[name] = true
		end
	end

	return settings
end

WalletCash.settings = getSettings

---@param name string
---@return boolean
function WalletCash.isSearchable(name)
	getSettings()
	return searchable[name] == true
end

---Wallet slots in a player's own inventory, in ascending slot order.
---@param inv OxInventory
---@return table[]
function WalletCash.wallets(inv)
	local wallets = {}

	if not inv or not inv.player then return wallets end

	for _, slotData in pairs(inv.items) do
		if slotData.name == 'wallet' then
			wallets[#wallets + 1] = slotData
		end
	end

	table.sort(wallets, function(a, b) return a.slot < b.slot end)

	return wallets
end

---Cash held in the wallets the player carries.
---@param inv OxInventory
---@return integer
function WalletCash.get(inv)
	local total = 0

	for _, wallet in ipairs(WalletCash.wallets(inv)) do
		total += math.floor(tonumber(wallet.metadata?.cash) or 0)
	end

	return total
end

---Takes `amount` from the wallets in slot order. The caller checks that they hold enough.
---@param inv OxInventory
---@param amount integer
---@return table<integer, integer> changes wallet slot -> new cash
function WalletCash.take(inv, amount)
	local changes = {}

	for _, wallet in ipairs(WalletCash.wallets(inv)) do
		if amount <= 0 then break end

		local cash = math.floor(tonumber(wallet.metadata?.cash) or 0)

		if cash > 0 then
			local taken = math.min(cash, amount)
			amount -= taken
			changes[wallet.slot] = cash - taken
		end
	end

	return changes
end

---Copies of the `name` items inside the player's wallets, each tagged with `wallet = <wallet slot>`.
---Only for searchable items (bank cards), so ordinary lookups never load wallet containers.
---@param inv OxInventory
---@param name string
---@param getContainer fun(wallet: table): OxInventory?
---@return table[]
function WalletCash.items(inv, name, getContainer)
	local found = {}

	if not WalletCash.isSearchable(name) then return found end

	for _, wallet in ipairs(WalletCash.wallets(inv)) do
		local container = wallet.metadata?.container and getContainer(wallet)

		if container then
			for _, slotData in pairs(container.items) do
				if slotData.name == name then
					local copy = table.clone(slotData)
					copy.wallet = wallet.slot
					found[#found + 1] = copy
				end
			end
		end
	end

	return found
end

return WalletCash
