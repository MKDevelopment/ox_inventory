# Stores v2 design

## Goal

Every shop on MyStoryRP (MyStory stores managed with `/stores` and the default ox shops in
`data/shops.lua`) works the same way: a shopkeeper ped you interact with through the target
system, a cart with live totals, payment with what the player actually carries (cash in the
pocket and wallets, tgg-banking debit cards in the inventory or a wallet), and food that always
comes with production and expiry data.

## Decisions (from the brainstorm)

- Target: `data/stores.lua` `target = 'auto' | 'ox_target' | 'tgiann-target'`. tgiann-target
  exposes the ox_target API (same exports and `TargetOption`), so one integration covers both.
  `auto` uses tgiann-target when it is started, otherwise ox_target.
- Card payments: personal cards charge the player's ESX bank account (the tgg-banking personal
  account); business cards charge the business account with `RemoveSocietyMoney`; shared cards
  are not offered (tgg-banking has no export to charge them).
- Food expiry: defaults by tier and category in `data/food.lua`, overridden by an item's own
  `degrade`.
- Scope: MyStory stores and the default ox shops.
- The wallet's last task ships here: client-side lookups see cards in wallets, and "Use" works
  inside an open wallet.

## 1. Target bridge (`modules/target/client.lua`)

- `Target.addLocalEntity(entity, options)` and `Target.removeLocalEntity(entity, names)` call
  `exports['tgiann-target']` or `exports.ox_target` depending on `config.target`.
- `Target.available()` is false when neither is started; stores then fall back to the current
  marker + `E` interaction so nothing breaks on a server without a target resource.
- `init.lua`: `shared.target` also stays on when `tgiann-target` is started (today it is turned
  off when `ox_target` is not started, which a `provide` does not satisfy).

## 2. Shopkeeper peds (`modules/stores/peds.lua`, client)

- Each shop location has a ped: `{ model, coords = vec4 }`. The ped spawns with `lib.points`
  when the player is within 40 m and is deleted when they leave (no networked entities).
  It is frozen, invincible, ignores events and plays an optional `scenario`.
- Target options on the ped:
  - "Shop" (`ui_store_shop`): opens the store UI.
  - "Manage" (`ui_store_manage`): only for players who can manage the store (owner, job grade,
    admin); the server checks again when the tab is used.
- MyStory stores: `mystory_stores` gains `ped_model VARCHAR(64) NULL` and `heading FLOAT NOT NULL
  DEFAULT 0` (added with `ALTER TABLE ... ADD COLUMN IF NOT EXISTS`). `/stores` "Set position
  here" stores the admin's coords and heading; the model is a text field (default from
  `config.defaultPed`).
- Default ox shops: each shop type gets `ped = 'mp_m_shopkeep_01'` (or similar) and a `peds`
  list of `vec4` positions in `data/shops.lua`, replacing `targets` for the converted shops.
  Shops without `peds` keep their current behaviour.
- `config.defaultPed = { model = 'mp_m_shopkeep_01', scenario = 'WORLD_HUMAN_STAND_IMPATIENT' }`.

## 3. One store UI for every shop

- The default ox shops open in the MyStory store UI (`StoreApp`) instead of the slot grid.
- Server: `ox_inventory:openShop(type, index)` returns the same `StoreData` shape as MyStory
  stores (`id`, `label`, `products`, `payments`), with products from the shop config:
  `{ name, price, stock (count or 9999), metadata?, license?, grade? }`. Products the player may
  not buy (missing group grade or license) are returned with `locked = 'license' | 'grade'`
  and shown disabled.
- `ox_inventory:checkoutShop(type, index, cart, payment)` validates distance to the shop
  location, groups, grades and licenses, stock (`count`), carry weight, then charges and adds
  the items with the product's metadata.
- Weapons keep the ox serial/registration behaviour (`metadata.registered`, `serial`).

## 4. Cart with live totals (`StoreView`)

- Each line: item, quantity stepper and input, unit price, line total.
- Footer: total, the selected payment's available amount, and the balance left after paying.
- "Pay" is disabled when the cart is empty or the selected payment cannot cover the total.

## 5. Payment options (`modules/stores/payments.lua`, server)

- `Payments.list(source) -> PaymentOption[]`, computed when a store opens and after each checkout:
  - `{ id = 'cash', kind = 'cash', balance }`: pocket + wallets (`Inventory.GetItemCount(inv, 'money')`).
    Shown only when the balance is above 0.
  - one option per `debitcard_personal` / `debitcard_business` found in the pocket or a wallet
    (`Inventory.GetSlotsWithItem`, which includes wallet cards):
    `{ id = 'card:<cardId>', kind = 'personal' | 'business', label = metadata.displayName,
    last4, balance, disabled? }`. `disabled` is `'frozen'` (card or account frozen/terminated)
    or `'no_access'` (business card whose account cannot be resolved).
- Card fields are read from metadata keys listed in `config.cardFields`
  (`id = { 'cardId', 'id' }`, `number = { 'cardNumber' }`, `name = { 'displayName' }`) because
  tgg-banking does not document them.
- Business card account: among the player's ESX jobs (`shared.esxjobs`),
  `exports['tgg-banking']:GetSocietyAccount(job)` whose `name` equals the card's display name;
  if none matches and exactly one job has a society account, that one. Otherwise `no_access`.
- `Payments.charge(source, optionId, amount, reason) -> boolean, string?` re-resolves the option
  from the player's current items (the card must still be carried), checks frozen state and
  balance, then:
  - cash: `Inventory.RemoveItem(inv, 'money', amount)` (pocket, then wallets);
  - personal: ESX `removeAccountMoney('bank', amount, reason)`;
  - business: `RemoveSocietyMoney(society, amount)`.
  - Cards then record `AddTransaction(nil, iban, 'store_purchase', amount, reason, nil, cardId, title)`.
- `data/stores.lua` `paymentMethods` is replaced by `payments = { cash = true, personal = true,
  business = true }` and `config.cardFields`; the old `bank` adapter stays as the personal-card
  charge.

## 6. Food data (`modules/food/server.lua`, `data/food.lua`)

- `data/food.lua` `spoilage` (minutes):
  `tiers = { restaurant = 2880, fastfood = 1440, snack = 20160, restaurantdrink = 1440,
  hotdrink = 1440, junkdrink = 43200 }`, `categories = { food = 4320, drinks = 43200,
  ingredients = 10080 }`.
- On item registration (server and client item lists), an item in those categories without
  `degrade` gets `degrade` from its tier, else its category.
- A `createItem` hook fills `produced` (date), `batch` and `quality` for food, drinks and
  ingredients when not set (the existing template logic in `modules/metadata`).
- Tooltip: "Best before: dd.mm.yyyy hh:mm" and "Eat within: 1 d 6 h" computed on the client from
  `metadata.durability` for items with `degrade`.

## 7. Wallet completion

- Client lookups (`Search`, `GetItemCount`, `GetSlotWithItem`, `GetSlotsWithItem`) include
  searchable items in carried wallets. The server sends `ox_inventory:walletItems` (copies of the
  searchable items, tagged with `wallet`) when the player loads and whenever a wallet or a wallet
  container changes; the client keeps them in `PlayerData.walletItems`.
- "Use" on an item in an open wallet: callback `ox_inventory:walletTakeOut(containerSlot)` moves it
  to the first free pocket slot and the client then runs `useSlot` on it.

## Error handling

- Every server callback re-checks distance (shop location or store coords), permissions, stock,
  funds and carry weight; the client state is never trusted.
- tgg-banking calls are wrapped in `pcall`; when tgg-banking is not started, card options are
  simply not offered.
- A failed charge leaves stock and inventory untouched; a failed item add after a successful
  charge refunds the payment the same way the current checkout does.

## Testing

- Lua mock tests (scratchpad, lupa): payment option listing (cash only, cards in pocket and
  wallet, shared card hidden, frozen card disabled, business card resolution), charge paths
  (cash, personal, business, card removed between listing and paying, insufficient funds),
  ox shop checkout validation (license, grade, distance, stock), food degrade defaults and
  metadata, wallet client lookups and take-out.
- `bun run build`, `oxfmt --check`, Lua syntax check.
- Playwright screenshots: store with cart and payment options; tooltip with expiry.
- In game (by the server team): target on peds in modern and old tgiann-target modes, card
  payments against tgg-banking.

## Out of scope

- PIN entry for cards (tgg-banking exports do not offer it).
- Shared-account card payments.
- Changing tgg-banking's ATM behaviour.
