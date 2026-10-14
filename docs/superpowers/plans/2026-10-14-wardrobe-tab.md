# Clothing Tab Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** A "Clothing" folder in the inventory rail with equipment slots, a 20-place pocket wardrobe and a live camera on the character.

**Architecture:** The wardrobe is an owner-bound ox stash (`wardrobe:<owner>`) opened as the secondary inventory while the tab is open and rendered inside the left panel. Equipment slots are UI over the existing wear/take-off callbacks, which gain a source and target inventory. A client module drives the camera and ped rotation.

**Tech Stack:** Lua 5.4 (CfxLua), React + TypeScript (react-dnd), Python + lupa mock tests.

**Spec:** `docs/superpowers/specs/2026-10-14-wardrobe-tab-design.md`

## Global Constraints

- English code, user text in locales; client requires shipped by fxmanifest patterns.
- Wardrobe: stash name `wardrobe`, owner-bound, 20 slots, accepts only `c_*` and `clothe_set`.
- Wear and take-off keep the saved-skin checks.

## Review Focus

1. Opening another player's wardrobe by id (`wardrobe:<other>`): refused. Test `wardrobe_foreign_refused`.
2. A non-garment dragged into the wardrobe: refused. Test `wardrobe_whitelist`.
3. A garment added by a script when the wardrobe is full: lands in the main inventory. Test `redirect_full_falls_back`.
4. Wearing from the wardrobe: the item leaves the wardrobe, replaced garments enter it. Test `wear_from_wardrobe`.
5. Camera left on after closing the inventory by Esc, death or a vehicle: restored. In-game check.

---

### Task 1: Wardrobe server
**Files:** `modules/clothing/server.lua`, `modules/inventory/server.lua` (`AddItem` redirect hook point), `data/clothing.lua` (`wardrobe = { slots = 20 }`).
**Interfaces:** `Wardrobe.get(inv) -> OxInventory?` (`Inventory({ id = 'wardrobe', owner = inv.owner })`); callbacks `ox_inventory:clothing:wear(slot, worn, fromWardrobe: boolean)`, `ox_inventory:clothing:takeOff(item, parts, toSlot?: integer)`; `Inventory.redirectAdd` hook (`function(inv, item) -> OxInventory?`).
- [ ] Tests (scratchpad `test_integrations.py` task `wardrobe`): `wardrobe_whitelist`, `wardrobe_foreign_refused`, `redirect_to_wardrobe`, `redirect_full_falls_back`, `wear_from_wardrobe`, `takeoff_into_wardrobe_slot`. FAIL → implement → PASS → commit.

### Task 2: Client tab and camera
**Files:** `modules/clothing/client.lua`.
**Interfaces:** NUI callbacks `clothingOpen() -> { equipment, enabled }`, `clothingClose()`, `clothingRotate(dx)`, `clothingZoom(preset)`, `clothingWear(slot)`, `clothingTakeOff({ item, toSlot })`; NUI message `clothingEquipment` after every change.
- [ ] Implement; syntax + manifest checks; commit.

### Task 3: UI
**Files:** `web/src/helpers/category.ts` (folder `clothing` always listed when enabled), `web/src/components/mystory/PlayerPanel.tsx`, new `web/src/components/mystory/ClothingView.tsx`, `web/src/components/inventory/index.tsx` (hide the right panel in clothing view), `web/src/store/clothing.ts`, `index.scss`, locales.
- [ ] Build, oxfmt; Playwright screenshot with mocked equipment and wardrobe; commit.

### Task 4: Release
- [x] All suites, final review (fresh reviewer), fix pass, `MYSTORY_VERSION` 1.3.0.
