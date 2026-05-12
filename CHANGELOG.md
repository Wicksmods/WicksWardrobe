# Changelog

## 0.2.0 - 2026-05-12

- Pressing Escape now closes the panel.

## 0.1.9 - 2026-05-12

- Fix: model preview was naked due to SLOT_VISIBLE being declared after buildPanel in the file. Moved declaration above buildPanel so the upvalue is captured correctly.
- Fix: bottom-left L-bracket now anchors to the bot bar frame so it renders above the background instead of being obscured.

## 0.1.8 - 2026-05-12

- Items list and model preview now filter to visually renderable slots only (Head, Shoulder, Back, Chest, Hands, Legs, Feet, weapons). Neck, rings, trinkets, wrist, and waist are excluded.

## 0.1.7 - 2026-05-12

- Items list now populates with the actual BIS phase or custom list items when opened from BIS Tracker, including weapon slots (MainHand, OffHand, Relic/Idol/Totem/Libram).
- Items are displayed in a logical slot order matching the BIS Tracker layout.

## 0.1.6 - 2026-05-12

- ShowWithContext now accepts spec and phase so opening from BIS Tracker's BIS tab previews the correct phase gear rather than defaulting to the first Wardrobe set.

## 0.1.5 - 2026-05-12

- Opening Wardrobe from BIS Tracker now auto-previews the set on the model. BIS tab previews the current set; custom list tab previews the list's items.
- Removed the SetUnit("player") call on every panel open so the model no longer resets to current gear when Wardrobe is re-opened.

## 0.1.4 - 2026-05-12

- When opened from BIS Tracker's custom list tab, Wardrobe now immediately previews the custom list items on the model instead of showing an empty set.

## 0.1.3 - 2026-05-12

- Redesigned layout: Class, Spec, and Set selectors are now compact dropdowns in a bottom bar. Items list and model viewer take the full panel height.
- Auto-clamps to the right of Wick's BIS Tracker when both panels are open. Reverts to saved position when BIS Tracker closes.

## 0.1.2 - 2026-05-12

- Added `ShowWithContext(class, setName)` API so Wick's BIS Tracker can open Wardrobe directly to the current class and list.

## 0.1.1 - 2026-05-12

- Wardrobe no longer reopens automatically on login or reload. Open it manually via /wwd or the minimap button.

## 0.1.0 — 2026-05-12

Initial release.

- Browse all 9 classes across Classic T1/T2/T3, TBC T4/T5/T6, and all four PvP seasons (Gladiator's / Merciless / Vengeful / Brutal)
- Per-class spec selector for targeted browsing
- Item list with icons, mouseover tooltips showing full stats, and click-to-toggle individual slot previews
- Inline DressUpModel character preview — drag to rotate, Undress, Current Gear reset
- Preview Set applies the full set at once
- From BIS button imports directly from Wick's BIS Tracker custom lists and phase BIS sets
- All item IDs verified against AtlasLoot Classic data
- Minimap button with saved position
- Resizable, draggable panel with saved position
