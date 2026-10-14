# VMS and tgiann-clothing Integrations Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Tax-inclusive store prices whose tax reaches vms_cityhall, VMS documents as proper items with licence checks, and tgiann-clothing garments handled by ox_inventory.

**Architecture:** A server `Taxes` module computes the tax included in each sale and either pays it to the City Hall budget or accrues it per store period; both checkouts call it after a successful charge. Documents are data plus a tooltip block and a licence check in the ox shop adapter. The clothing module is rewritten around the tgiann-clothing item format.

**Tech Stack:** Lua 5.4 (CfxLua), oxmysql, vms_cityhall / vms_documentsv2 / tgiann-clothing exports, React + TypeScript, Python + lupa mock tests.

**Spec:** `docs/superpowers/specs/2026-10-14-integrations-design.md`

## Global Constraints

- English code, user text in `locales/en.json` and `locales/pl.json`.
- Every external export call is guarded by `GetResourceState(name) == 'started'` and `pcall`.
- Every module a client file requires must match the `files` patterns in `fxmanifest.lua`.
- Tax maths: `tax = floor(gross * p / (100 + p) + 0.5)`; rates from `vms_cityhall:getTaxAmount(100, path)` (third return).
- Clothing metadata keeps the tgiann-clothing format (`data`, `model`, `clotheType`, `type = 'clothe'`).

## Review Focus

1. A period whose end passed while the server was off: settled once on start, not twice. Test `settle_idempotent`.
2. A withdrawal that would dip into tax owed: capped at `cash - owed`. Test `withdraw_respects_tax`.
3. Wearing a garment while the pocket is full and the replaced garment cannot be given back: nothing removed, nothing worn. Test `wear_full_inventory`.
4. A forged take-off claiming a part the ped does not wear (index equal to the naked drawable): refused. Test `takeoff_not_worn`.
5. A weapon licence in the wallet with a serial VMS no longer considers valid: product locked. Test `licence_wrong_serial`.

---

### Task 1: Taxes module
**Files:** Create `modules/stores/taxes.lua`; modify `data/stores.lua` (`taxes`). Test: `scratchpad/test_integrations.py` task `1`.
**Interfaces:** `Taxes.rate(itemName) -> number`; `Taxes.included(gross, percent) -> integer`; `Taxes.forLines(lines: {name, total}[]) -> integer`; `Taxes.collect(store?: Store, tax: integer)` (unowned → `addCompanyMoney(tax, true)`; owned → accrue to the open period); `Taxes.owed(storeId) -> integer`; `Taxes.settle()` (settles ended periods from `store.cash`); `Taxes.summary(storeId) -> { current, history }`.
- [ ] Tests: `rate_lookup` (food 33, beer alcohol 23, unknown other 23, no cityhall 0), `included_math` (133 → 33, 0 → 0), `unowned_to_budget`, `owned_accrues`, `settle_pays_and_carries` (till 20 of 33 → paid 20, overdue 13), `settle_idempotent`, `withdraw_respects_tax` (via `Taxes.owed`).
- [ ] FAIL → implement (table `mystory_store_taxes`, created on start) → PASS → syntax check → commit.

### Task 2: Wire taxes into checkouts and the manage panel
**Files:** `modules/stores/server.lua` (collect after checkout, withdraw cap, receipt line, `manageStore` action `taxes`), `modules/stores/shops.lua` (collect), `web/src/components/stores/StoreManage.tsx` + new `StoreTaxes.tsx`, locales.
- [ ] Update `test_store.py` and `test_stores2.py` for a `Taxes` mock; add `checkout_collects_tax`, `shop_tax_to_budget`.
- [ ] Build, Playwright screenshot of the Taxes tab → commit.

### Task 3: Documents
**Files:** `data/items.lua` (document items), `data/metadata.lua` (labels formerly in ms_inventory), `data/wallet.lua` (document items searchable), `web/src/components/inventory/SlotTooltip.tsx` (document block), `modules/stores/shops.lua` (`lockReason` with VMS licence), `data/stores.lua` (`licenseDocuments`, `requireDocumentItem`), locales.
- [ ] Tests: `licence_valid_in_wallet`, `licence_wrong_serial`, `licence_no_vms_fallback`, `licence_item_not_required`.
- [ ] FAIL → implement → PASS; Playwright tooltip of `id_card` and `driving_license` → commit.

### Task 4: Clothing (tgiann format)
**Files:** rewrite `modules/clothing/client.lua`, `modules/clothing/server.lua`, `data/clothing.lua`; `data/items.lua` (`c_*`, `clothe_set` export `ox_inventory.useClothing`; remove `clothing_*` items); locales; `setup/inv_setup.cfg` note.
**Interfaces:** callbacks `ox_inventory:clothing:wear(slot, worn: Part[]) -> boolean, string?`, `ox_inventory:clothing:takeOff(itemName, worn: Part[]) -> boolean, string?`; `Part = { category, id, data = { collection, index, texture } }`.
- [ ] Tests: `parts_validation`, `wear_swaps` (item removed, replaced garment returned with tgiann metadata), `wear_nothing_replaced`, `wear_wrong_model`, `wear_full_inventory`, `takeoff_ok`, `takeoff_not_worn`, `clothe_set_returns_per_category`.
- [ ] FAIL → implement → PASS → syntax + manifest check → commit.

### Task 5: Release
- [ ] All suites, build, oxfmt, Lua checks, manifest check; final review (fresh reviewer); fix pass; bump `MYSTORY_VERSION` to `1.2.0`; confirm the release.
