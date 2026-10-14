# vms_cityhall, vms_documentsv2 and tgiann-clothing integration design

## Goal

ox_inventory on MyStoryRP works with the server's own systems instead of beside them: store
prices include the city's taxes and the tax reaches City Hall, VMS documents are proper inventory
items (wallet, readable tooltip, use = show, licence checks in shops), and tgiann-clothing
garments (`c_*`, `clothe_set`) are handled by ox_inventory itself.

## Decisions (from the brainstorm)

- Prices shown to customers are gross: the tax is included in the price.
- Unowned shops (default ox shops, MyStory stores without owner or job) pay the tax to the City Hall
  budget at the moment of sale. Owned MyStory stores accumulate it and settle per period; the period
  (`weekly`, `biweekly`, `monthly`) is a config switch.
- Documents: VMS item names, readable tooltip, use opens the document through VMS, and the weapon
  shop checks a valid VMS `weapon_license`.
- Clothing: ox_inventory handles `c_*` and `clothe_set` (format of tgiann-clothing items). My
  separate `clothing_*` system is removed. `ms_inventory` keeps handling car keys
  (`ms_inventory.useKey`) and stays running.

## 1. Taxes (`modules/stores/taxes.lua`, server)

Config in `data/stores.lua`:

```lua
taxes = {
    enabled = true,
    period = 'weekly',            -- 'weekly' | 'biweekly' | 'monthly' (owned stores)
    default = 'products.other',   -- vms_cityhall Config.Taxes path
    categories = { food = 'products.food', ingredients = 'products.food', drinks = 'products.drinks' },
    items = {                     -- per-item overrides
        beer = 'products.alcohol', vodka = 'products.alcohol', whiskey = 'products.alcohol', wine = 'products.alcohol',
        phone = 'products.electronics', radio = 'products.electronics', laptop = 'products.electronics', tablet = 'products.electronics',
        jerrycan = 'products.fuel',
    },
},
```

- `Taxes.rate(itemName) -> percent`: from `exports.vms_cityhall:getTaxAmount(100, path)` (third
  return), cached per path; 0 when vms_cityhall is not started or `enabled` is false.
- `Taxes.included(gross, percent) -> integer`: `math.floor(gross * percent / (100 + percent) + 0.5)`.
- Every checkout computes the tax per line (`price * count`, the item's rate) and the total.
- Unowned: `exports.vms_cityhall:addCompanyMoney(tax, true)` right after a successful charge.
- Owned (`owner` or `job` set): table `mystory_store_taxes`
  (`id`, `store`, `period_start`, `period_end`, `sales`, `tax`, `paid`, `status` = open/settled/overdue).
  Each sale adds to the store's open period (created on demand from `period`). A timer (on start and
  every 10 minutes) settles periods whose end has passed: take `min(store.cash, tax + arrears)` from
  the till, `addCompanyMoney(paid, true)`, mark settled or overdue (rest carried as arrears), Discord log.
- Till withdrawals are limited to `cash - (open tax + arrears)`.
- Manage tab "Taxes": current period (sales, tax, ends at) and the last periods (paid, overdue).
- Receipt adds "incl. tax $X".

## 2. Documents (vms_documentsv2)

- Items (`data/items.lua`, documents section, `stack = false`, `weight = 5`, `close = true`, no
  client export so ESX usable items registered by VMS run): `id_card` (exists),
  `driving_license`, `boat_license`, `flying_license`, `weapon_license`, `police_badge`,
  `sheriff_badge`, `fib_badge`. `driver_license` stays.
- "Use" needs no code: VMS registers them with `ESX.RegisterUsableItem`; using from a wallet takes
  the item to the pocket first (existing).
- Tooltip: for items with `metadata.document_id`, a document block: name (`firstName lastName`),
  date of birth, SSN, licences (non-empty of `drive_a/b/c`, `practical_plane/helicopter/boat`),
  grade (`jobGrade`), badge (`badgeNumber`), serial (`document_id`). Labels from locales.
- Shop licence check: `data/stores.lua` `licenseDocuments = { weapon = 'weapon_license' }` and
  `requireDocumentItem = true`. For a product with `license = 'weapon'`, when vms_documentsv2 is
  started: `exports.vms_documentsv2:isAnyDocumentValid(identifier, 'weapon_license')` must return a
  serial, and with `requireDocumentItem` the player must carry (pocket or wallet) a
  `weapon_license` whose `metadata.document_id` equals it. Otherwise the ESX licence check stays.
- Document items become wallet-searchable, so a licence in the wallet counts.
- Metadata labels currently registered by ms_inventory (`cardId = 'ID karty SIM'`, ...) move to
  `data/metadata.lua` with neutral labels (`cardId` = "Card ID"), shared by bank and SIM cards.

## 3. Clothing (tgiann-clothing items)

Item format (unchanged, as tgiann-clothing writes it):
`metadata = { version, data = { { category = 'component'|'prop', id, data = { collection, index, texture } } }, model, clotheType, type = 'clothe', dirtTime }`.

`data/clothing.lua` maps item names to parts:
`c_torso = { components = { 11, 8, 3 } }`, `c_pants = { 4 }`, `c_shoes = { 6 }`, `c_mask = { 1 }`,
`c_bag = { 5 }`, `c_necklace = { 7 }`, `c_bproof = { 9 }`, `c_decal = { 10 }`,
`c_helmet = { props = { 0 } }`, `c_glasses = { 1 }`, `c_ear = { 2 }`, `c_watch = { 6 }`,
`c_bracelet = { 7 }`; `clothe_set` = any parts; plus the "nothing worn" drawables per model.

- Wear (item export `ox_inventory.useClothing`, replacing `ms_inventory.useClothing`): validates the
  metadata like ms_inventory does (model match, part ids, types), applies each part with
  `exports['tgiann-clothing']:SetPedClothing`, `ApplyMaskFaceReset` for masks, then `SaveSkin`.
- Take off: `/clothing` menu (existing command) lists the worn categories; taking one off reads the
  parts from the ped (drawable, texture and collection natives) into a `c_*` item and puts on
  "nothing", then `SaveSkin`. The server creates the item only from a validated part list and only
  for a category the player is actually wearing.
- Removed: `clothing_*` items and the old `modules/clothing` logic built on them.

**Open choice (see review question):** whether wearing keeps the item (as ms_inventory does now) or
moves it onto the body (item removed, the garment it replaces comes back as an item).

## Error handling

- Missing vms_cityhall / vms_documentsv2 / tgiann-clothing: the feature is skipped, never errors
  (`GetResourceState(...) == 'started'` and `pcall` around exports).
- Tax settlement is idempotent per period row (`status` checked in the same UPDATE).

## Testing

- Lua mock tests: tax rate lookup and included-tax maths (33% of 133 = 33), unowned budget transfer,
  owned period accrual and settlement with short till and arrears, withdrawal limit; document licence
  check (valid serial + item in wallet, wrong serial, no VMS fallback); clothing part validation,
  take-off item metadata, swap behaviour per the open choice.
- Build, oxfmt, Lua syntax, client-file manifest check (every client `require` is shipped).
- Playwright: tooltip of an ID card and a driving licence; Taxes tab.

## Out of scope

- Keys (`ms_inventory.useKey`, `ms_carkey`) stay in ms_inventory.
- City Hall business declarations (`addCompanyTaxAmount`) for jobs: owned stores settle through
  their own periods instead.
