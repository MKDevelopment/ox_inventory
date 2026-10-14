# Wallet design

## Goal

A `wallet` item for MyStoryRP that holds payment cards (tgg-banking), documents and cash.
Cash in a wallet the player carries counts as their ESX cash, so every script that charges cash
(ox shops, MyStory stores, mechanics, tgg-banking, ...) keeps working without changes.

## Decisions

- Cash is stored as a number on the wallet (`metadata.cash`), not as `money` items inside it.
  This is the single source of truth: no sum to keep in sync and no database load to pay.
- Cards and documents are real items inside the wallet, using the existing container system.
- Only `money` goes into wallets; `black_money` stays in the pocket.

## Wallet item

- `data/items.lua`: `wallet`, category `documents`, `stack = false`, small weight.
- `modules/items/containers.lua`: `setContainerProperties('wallet', ...)` with 10 slots and a
  whitelist built from every item whose `category` is `documents`, minus `wallet` itself.
- Item metadata: `cash` (integer, default 0) and the usual `container` id.

## Cash accounting (server, `modules/wallet/server.lua`)

"Wallets" means wallet items in the player's main inventory slots. A wallet inside a stash,
trunk, drop, another container or another player does not count for this player.

- `Wallet.getCash(inv)`: sum of `metadata.cash` of the player's wallets.
- Counting, for player inventories and the `money` item only (all other cases unchanged):
  - `Inventory.GetItemCount(inv, 'money')` and `Inventory.GetItem(inv, 'money', nil, true)` add `Wallet.getCash`.
  - `Inventory.Search(inv, 'count', 'money')` adds it as well.
  - `Inventory.GetAccountItemCounts(inv)` adds it, so `server.syncInventory` reports the total to ESX.
- Paying: `Inventory.RemoveItem(inv, 'money', count)` without `slot` or `metadata` removes loose
  money first, then takes the rest from wallets in slot order. It fails without changing
  anything when the total is too low. A call with `slot` or `metadata` keeps the original behaviour.
- `Inventory.SetItem(inv, 'money', count)` already works through the patched `GetItem`, `AddItem`
  and `RemoveItem`. Lowering cash takes it from the pocket and then the wallets; raising adds
  it to the pocket.
- `Inventory.AddItem(inv, 'money', ...)` is unchanged: new cash goes to the pocket.
- Every wallet change calls `Inventory.SetMetadata` (so the client slot and tooltip update) and
  `server.syncInventory`.

## Putting cash in and taking it out

- Dragging `money` onto a wallet slot in the player inventory moves the dragged amount into the
  wallet (a `swapItems` hook cancels the normal swap and does the transfer).
- Inside an open wallet the UI shows the cash amount with "Put in" and "Take out" buttons and an
  amount field. They call the server callbacks `ox_inventory:walletDeposit(slot, amount)` and
  `ox_inventory:walletWithdraw(slot, amount)`. The server checks that the slot holds a wallet in
  the caller's own inventory, that the amount is a positive integer within what is available,
  and that the player can carry the withdrawn cash.
- Logged with the existing inventory logging (`lib.logger`) like other money moves.

## Theft protection

`data/wallet.lua` holds the wallet settings:

```lua
return {
    slots = 10,
    -- who may take a wallet out of another player's inventory (robbing, /steal, searching):
    -- false = nobody, 'police' = only jobs in inventory:police (rcore_police searches), true = anyone
    steal = 'police',
}
```

A `swapItems` hook blocks moving a `wallet` out of a player inventory that is not the source's own
unless `steal` allows it, and tells the thief why (locale `wallet_cannot_steal`). The owner can
still drop, give or store their own wallet. Loose cash and other items are unaffected.

## Display

- Wallet tooltip: "Cash: $X" through the metadata display keys (`data/metadata.lua`).
- Folder rail and sorting: the wallet is in `documents`.
- Locales: all new strings in `locales/en.json` and `locales/pl.json`.

## Edge cases

- Dropping, giving, storing or having the wallet stolen moves its cash with it; the player's ESX
  cash drops right away because the next sync no longer counts that wallet.
- Several wallets: all count; paying takes from them in slot order.
- A wallet cannot go into another wallet (whitelist) and cannot stack, so metadata is never
  duplicated.
- Fractional amounts are rounded the same way as `RemoveItem` (`math.floor(count + 0.5)`).

## Testing

- Lua mock tests (scratchpad, same harness as the store and fridge tests):
  pay from pocket only; pocket plus wallet; several wallets; not enough cash (nothing changes);
  `SetItem` lowering and raising; `GetItemCount`, `Search` and account counts including wallets;
  a wallet outside the main inventory not counted; deposit and withdraw validation
  (foreign slot, negative or too large amounts, non-wallet slot).
- `bun run build`, `oxfmt --check`, Lua syntax check.
- Playwright screenshot of an open wallet with cards and the cash panel.

## Out of scope (next step)

- Card or cash payment prompt for MyStory's own systems: a server export that asks the player
  whether to pay by card or cash and charges the right account (cash through the wallet-aware
  `RemoveItem`, card through the stores bank adapter). Designed separately after the wallet ships.
- tgg-banking integration beyond holding its card items (cards keep working as tgg-banking items).
- Black money in wallets.
