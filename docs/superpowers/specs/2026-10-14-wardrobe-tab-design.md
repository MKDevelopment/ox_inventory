# Clothing tab design

## Goal

A permanent "Clothing" entry in the inventory's left folder rail. It shows the character live (game
camera on the player) with what they wear, and a pocket wardrobe for carried garments, so clothes
are managed in one place and never fill the main inventory.

## Decisions (from the brainstorm)

- Preview: the game camera turns to the player while the tab is open; the right side of the screen
  stays transparent so the real ped is visible. Drag on it to rotate, buttons to zoom (head, body,
  feet).
- Place: a folder in the left rail ("Clothing"), next to the item categories.
- Pocket wardrobe: 20 places, no weight, separate from the main inventory slots. Garments taken off
  and garments given by other resources go there; when it is full they go to the main inventory.

## Layout (clothing view)

Left panel (the player panel) switches its body when "Clothing" is selected:

- **Worn** — 13 equipment slots in a body layout (hat, glasses, mask, ears, necklace, torso, vest,
  decal, bag, pants, shoes, watch, bracelet), each showing the garment's item image when worn and an
  outline icon when nothing is worn. Hover shows the collection/drawable like a tooltip.
- **Wardrobe** — a 20-slot grid with the carried `c_*` / `clothe_set` items.
- Right side: no panel; transparent for the camera. Rotate by dragging there; zoom buttons and a
  "reset view" button float at the bottom.

Interactions:

- Drag a wardrobe garment onto its equipment slot (or double-click / Use) → wear. What it replaces
  returns to the wardrobe.
- Drag an equipment slot onto the wardrobe → take off into that wardrobe slot.
- Drag garments between the wardrobe and the main inventory works like any two inventories (to give,
  store or sell them).
- The tab is available when no other inventory is open; selecting it while a stash/trunk/drop is
  open closes that inventory first.

## Data and server

- Wardrobe = ox stash `wardrobe:<owner>` (20 slots, maxWeight 0 checks disabled via a large limit,
  owner-bound, not shown as a separate world stash). A `swapItems` hook allows only `c_*` and
  `clothe_set` into it.
- Opening the tab opens the wardrobe as the secondary inventory (server `openInventory` with the
  player's own wardrobe id only); the UI renders it inside the left panel instead of the right panel.
- `Inventory.AddItem` on a player inventory redirects `c_*` / `clothe_set` to the player's wardrobe
  when it has a free slot (garments bought in tgiann-clothing shops land in the wardrobe).
- Equipment data: the client sends `{ [item] = parts }` for the 13 garments from
  `GetPedSkinData` when the tab opens and after every change; worn = not naked (existing rules).
- Wear/take-off reuse the existing server callbacks (validated against the saved skin), extended with
  a `source inventory` (wardrobe or player) and a target for returned garments (wardrobe first, then
  main inventory).
- Robbery/search: the wardrobe is not part of the player inventory, so it is not visible to others;
  police searches only see the main inventory (as with worn clothes).

## Camera

- Client creates a scripted camera in front of the player (offset by the tab's zoom preset), points
  it at the ped's spine/head/feet, freezes player movement controls while the tab is open, and
  restores the gameplay camera when the tab closes or the inventory closes.
- Rotation: NUI sends `clothingRotate(deltaX)`; the client turns the ped heading (local only while
  the tab is open, restored on close).
- Screen blur (`inventory:screenblur`) is suspended while the tab is open, otherwise the ped is
  blurred.

## Error handling

- Without tgiann-clothing the folder is hidden.
- In a vehicle or while dead the camera is not used; the tab still lists worn garments and the
  wardrobe.

## Testing

- Lua mock tests: wardrobe whitelist hook, AddItem redirect (free slot, full wardrobe falls back to
  main), wear from wardrobe returns to wardrobe, take-off into a chosen wardrobe slot, opening
  someone else's wardrobe refused.
- Build, oxfmt, Lua syntax, manifest check; Playwright screenshot of the clothing view with mocked
  equipment and wardrobe.
- In game: camera position and rotation, blur, closing paths (Esc, death, vehicle).

## Out of scope

- Outfit presets/saving whole outfits (tgiann-clothing wardrobe stays for that).
- Hair, face and tattoos (tgiann-clothing menus).
