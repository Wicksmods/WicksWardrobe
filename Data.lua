-- Wick's Wardrobe
-- Data.lua: curated item database.
-- Classic T1/T2/T3 IDs verified against AtlasLootClassic/Data/ItemSet.lua.
-- Pre-raid IDs verified against AtlasLootClassic_DungeonsAndRaids/data.lua.
-- TBC T4-T6 IDs verified against wowhead.com/tbc item pages.
-- PvP S1-S4 IDs verified against AtlasLootClassic/Data/ItemSet.lua.

local ADDON, ns = ...
local WW = WicksWardrobe

WW.DATA = {}

-- Build a proper item hyperlink so DressUpModel:TryOn() accepts it.
local function S(set, slot, name, id)
    local link = ("|Hitem:%d:0:0:0:0:0:0:0|h[%s]|h"):format(id, name)
    return { set = set, slot = slot, name = name, id = id, link = link }
end

-- ============================================================
-- DRUID
-- ============================================================
WW.DATA["DRUID"] = {
    -- Pre-Raid: Wildheart Raiment (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Wildheart",   "Head",     "Wildheart Cowl",                16720),
    S("Pre-Raid - Wildheart",   "Shoulder", "Wildheart Spaulders",           16718),
    S("Pre-Raid - Wildheart",   "Chest",    "Wildheart Vest",                16706),
    S("Pre-Raid - Wildheart",   "Hands",    "Wildheart Gloves",              16717),
    S("Pre-Raid - Wildheart",   "Legs",     "Wildheart Kilt",                16719),
    S("Pre-Raid - Wildheart",   "Feet",     "Wildheart Boots",               16715),
    S("Pre-Raid - Wildheart",   "Waist",    "Wildheart Belt",                16716),
    S("Pre-Raid - Wildheart",   "Wrist",    "Wildheart Bracers",             16714),

    -- Classic T1: Cenarion Raiment (MC) — verified
    S("T1 - Cenarion",          "Head",     "Cenarion Helm",                 16834),
    S("T1 - Cenarion",          "Shoulder", "Cenarion Spaulders",            16836),
    S("T1 - Cenarion",          "Chest",    "Cenarion Vestments",            16833),
    S("T1 - Cenarion",          "Hands",    "Cenarion Gloves",               16831),
    S("T1 - Cenarion",          "Legs",     "Cenarion Leggings",             16835),
    S("T1 - Cenarion",          "Feet",     "Cenarion Boots",                16829),
    S("T1 - Cenarion",          "Waist",    "Cenarion Belt",                 16828),
    S("T1 - Cenarion",          "Wrist",    "Cenarion Bracers",              16830),

    -- Classic T2: Stormrage Raiment (BWL) — verified
    S("T2 - Stormrage",         "Head",     "Stormrage Cover",               16900),
    S("T2 - Stormrage",         "Shoulder", "Stormrage Pauldrons",           16902),
    S("T2 - Stormrage",         "Chest",    "Stormrage Chestguard",          16897),
    S("T2 - Stormrage",         "Hands",    "Stormrage Handguards",          16899),
    S("T2 - Stormrage",         "Legs",     "Stormrage Legguards",           16901),
    S("T2 - Stormrage",         "Feet",     "Stormrage Boots",               16898),
    S("T2 - Stormrage",         "Waist",    "Stormrage Belt",                16903),
    S("T2 - Stormrage",         "Wrist",    "Stormrage Bracers",             16904),

    -- Classic T3: Dreamwalker Raiment (Naxx)
    S("T3 - Dreamwalker",       "Head",     "Dreamwalker Headpiece",         22494),
    S("T3 - Dreamwalker",       "Shoulder", "Dreamwalker Spaulders",         22493),
    S("T3 - Dreamwalker",       "Chest",    "Dreamwalker Tunic",             22491),
    S("T3 - Dreamwalker",       "Hands",    "Dreamwalker Handguards",        22489),
    S("T3 - Dreamwalker",       "Legs",     "Dreamwalker Legguards",         22492),
    S("T3 - Dreamwalker",       "Feet",     "Dreamwalker Boots",             22495),
    S("T3 - Dreamwalker",       "Waist",    "Dreamwalker Girdle",            22490),
    S("T3 - Dreamwalker",       "Wrist",    "Dreamwalker Wristguards",       22488),

    -- TBC T4: Malorne (Kara/Gruul/Mag)
    S("T4 - Malorne",           "Head",     "Stag-Helm of Malorne",          29098),
    S("T4 - Malorne",           "Shoulder", "Mantle of Malorne",             29100),
    S("T4 - Malorne",           "Chest",    "Breastplate of Malorne",        29096),
    S("T4 - Malorne",           "Hands",    "Gauntlets of Malorne",          29097),
    S("T4 - Malorne",           "Legs",     "Greaves of Malorne",            29099),

    -- TBC T5: Nordrassil (SSC/TK)
    S("T5 - Nordrassil",        "Head",     "Nordrassil Headdress",          30228),
    S("T5 - Nordrassil",        "Shoulder", "Nordrassil Feral-Mantle",       30230),
    S("T5 - Nordrassil",        "Chest",    "Nordrassil Chestplate",         30222),
    S("T5 - Nordrassil",        "Hands",    "Nordrassil Handgrips",          30223),
    S("T5 - Nordrassil",        "Legs",     "Nordrassil Feral-Kilt",         30229),

    -- TBC T6: Thunderheart (Hyjal/BT/SWP)
    S("T6 - Thunderheart",      "Head",     "Thunderheart Helmet",           31037),
    S("T6 - Thunderheart",      "Shoulder", "Thunderheart Spaulders",        31047),
    S("T6 - Thunderheart",      "Chest",    "Thunderheart Tunic",            31041),
    S("T6 - Thunderheart",      "Hands",    "Thunderheart Gloves",           31032),
    S("T6 - Thunderheart",      "Legs",     "Thunderheart Legguards",        31045),
    S("T6 - Thunderheart",      "Waist",    "Thunderheart Belt",             34554),
    S("T6 - Thunderheart",      "Wrist",    "Thunderheart Bracers",          34445),
    S("T6 - Thunderheart",      "Feet",     "Thunderheart Boots",            34571),

    -- PvP S1: Gladiator's Sanctuary [set 584] — AtlasLoot ItemSet.lua
    S("Gladiator's - Sanctuary",     "Head",     "Gladiator's Sanctuary Helm",        28127),
    S("Gladiator's - Sanctuary",     "Shoulder", "Gladiator's Sanctuary Spaulders",   28129),
    S("Gladiator's - Sanctuary",     "Chest",    "Gladiator's Sanctuary Tunic",       28130),
    S("Gladiator's - Sanctuary",     "Hands",    "Gladiator's Sanctuary Gloves",      28126),
    S("Gladiator's - Sanctuary",     "Legs",     "Gladiator's Sanctuary Legguards",   28128),

    -- PvP S2: Merciless Gladiator's Sanctuary [set 711]
    S("Merciless - Sanctuary",     "Head",     "Merciless Gladiator's Sanctuary Helm",      31971),
    S("Merciless - Sanctuary",     "Shoulder", "Merciless Gladiator's Sanctuary Spaulders", 31972),
    S("Merciless - Sanctuary",     "Chest",    "Merciless Gladiator's Sanctuary Tunic",     31968),
    S("Merciless - Sanctuary",     "Hands",    "Merciless Gladiator's Sanctuary Gloves",    31967),
    S("Merciless - Sanctuary",     "Legs",     "Merciless Gladiator's Sanctuary Legguards", 31969),

    -- PvP S3: Vengeful Gladiator's Sanctuary [set 721]
    S("Vengeful - Sanctuary",     "Head",     "Vengeful Gladiator's Sanctuary Helm",       33674),
    S("Vengeful - Sanctuary",     "Shoulder", "Vengeful Gladiator's Sanctuary Spaulders",  33675),
    S("Vengeful - Sanctuary",     "Chest",    "Vengeful Gladiator's Sanctuary Tunic",      33672),
    S("Vengeful - Sanctuary",     "Hands",    "Vengeful Gladiator's Sanctuary Gloves",     33671),
    S("Vengeful - Sanctuary",     "Legs",     "Vengeful Gladiator's Sanctuary Legguards",  33673),

    -- PvP S4: Brutal Gladiator's Sanctuary [set 2000584]
    S("Brutal - Sanctuary",     "Head",     "Brutal Gladiator's Sanctuary Helm",         35001),
    S("Brutal - Sanctuary",     "Shoulder", "Brutal Gladiator's Sanctuary Spaulders",    35002),
    S("Brutal - Sanctuary",     "Chest",    "Brutal Gladiator's Sanctuary Tunic",        34999),
    S("Brutal - Sanctuary",     "Hands",    "Brutal Gladiator's Sanctuary Gloves",       34998),
    S("Brutal - Sanctuary",     "Legs",     "Brutal Gladiator's Sanctuary Legguards",    35000),
}

-- ============================================================
-- HUNTER
-- ============================================================
WW.DATA["HUNTER"] = {
    -- Pre-Raid: Beaststalker's Armor (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Beaststalker", "Head",    "Beaststalker's Cap",            16677),
    S("Pre-Raid - Beaststalker", "Shoulder","Beaststalker's Mantle",         16679),
    S("Pre-Raid - Beaststalker", "Chest",   "Beaststalker's Tunic",          16674),
    S("Pre-Raid - Beaststalker", "Hands",   "Beaststalker's Gloves",         16676),
    S("Pre-Raid - Beaststalker", "Legs",    "Beaststalker's Pants",          16678),
    S("Pre-Raid - Beaststalker", "Feet",    "Beaststalker's Boots",          16675),
    S("Pre-Raid - Beaststalker", "Waist",   "Beaststalker's Belt",           16680),
    S("Pre-Raid - Beaststalker", "Wrist",   "Beaststalker's Bindings",       16681),

    -- Classic T1: Giantstalker's Armor (MC) — IDs from AtlasLoot ItemSet.lua
    S("T1 - Giantstalker",      "Head",     "Giantstalker's Helmet",         16846),
    S("T1 - Giantstalker",      "Shoulder", "Giantstalker's Epaulets",       16848),
    S("T1 - Giantstalker",      "Chest",    "Giantstalker's Breastplate",    16845),
    S("T1 - Giantstalker",      "Hands",    "Giantstalker's Gloves",         16852),
    S("T1 - Giantstalker",      "Legs",     "Giantstalker's Leggings",       16847),
    S("T1 - Giantstalker",      "Feet",     "Giantstalker's Boots",          16849),
    S("T1 - Giantstalker",      "Waist",    "Giantstalker's Belt",           16851),
    S("T1 - Giantstalker",      "Wrist",    "Giantstalker's Bracers",        16850),

    -- Classic T2: Dragonstalker's Armor (BWL) — verified
    S("T2 - Dragonstalker",     "Head",     "Dragonstalker's Helm",          16939),
    S("T2 - Dragonstalker",     "Shoulder", "Dragonstalker's Spaulders",     16937),
    S("T2 - Dragonstalker",     "Chest",    "Dragonstalker's Breastplate",   16942),
    S("T2 - Dragonstalker",     "Hands",    "Dragonstalker's Gauntlets",     16940),
    S("T2 - Dragonstalker",     "Legs",     "Dragonstalker's Legguards",     16938),
    S("T2 - Dragonstalker",     "Feet",     "Dragonstalker's Greaves",       16941),
    S("T2 - Dragonstalker",     "Waist",    "Dragonstalker's Belt",          16936),
    S("T2 - Dragonstalker",     "Wrist",    "Dragonstalker's Bracers",       16935),

    -- Classic T3: Cryptstalker Armor (Naxx)
    S("T3 - Cryptstalker",      "Head",     "Cryptstalker Headpiece",        22438),
    S("T3 - Cryptstalker",      "Shoulder", "Cryptstalker Spaulders",        22439),
    S("T3 - Cryptstalker",      "Chest",    "Cryptstalker Tunic",            22436),
    S("T3 - Cryptstalker",      "Hands",    "Cryptstalker Handguards",       22441),
    S("T3 - Cryptstalker",      "Legs",     "Cryptstalker Legguards",        22437),
    S("T3 - Cryptstalker",      "Feet",     "Cryptstalker Boots",            22440),
    S("T3 - Cryptstalker",      "Waist",    "Cryptstalker Girdle",           22442),
    S("T3 - Cryptstalker",      "Wrist",    "Cryptstalker Wristguards",      22443),

    -- TBC T4: Beast Lord (Kara/Gruul/Mag)
    S("T4 - Beast Lord",        "Head",     "Beast Lord Helm",               28275),
    S("T4 - Beast Lord",        "Shoulder", "Beast Lord Mantle",             27801),
    S("T4 - Beast Lord",        "Chest",    "Beast Lord Cuirass",            28228),
    S("T4 - Beast Lord",        "Hands",    "Beast Lord Handguards",         27474),
    S("T4 - Beast Lord",        "Legs",     "Beast Lord Leggings",           27874),

    -- TBC T5: Rift Stalker (SSC/TK)
    S("T5 - Rift Stalker",      "Head",     "Rift Stalker Helm",             30141),
    S("T5 - Rift Stalker",      "Shoulder", "Rift Stalker Mantle",           30143),
    S("T5 - Rift Stalker",      "Chest",    "Rift Stalker Hauberk",          30139),
    S("T5 - Rift Stalker",      "Hands",    "Rift Stalker Gauntlets",        30140),
    S("T5 - Rift Stalker",      "Legs",     "Rift Stalker Leggings",         30142),

    -- TBC T6: Gronnstalker's (Hyjal/BT/SWP)
    S("T6 - Gronnstalker's",    "Head",     "Gronnstalker's Helmet",         31003),
    S("T6 - Gronnstalker's",    "Shoulder", "Gronnstalker's Spaulders",      31006),
    S("T6 - Gronnstalker's",    "Chest",    "Gronnstalker's Chestguard",     31004),
    S("T6 - Gronnstalker's",    "Hands",    "Gronnstalker's Gloves",         31001),
    S("T6 - Gronnstalker's",    "Legs",     "Gronnstalker's Leggings",       31005),
    S("T6 - Gronnstalker's",    "Waist",    "Gronnstalker's Belt",           34549),
    S("T6 - Gronnstalker's",    "Wrist",    "Gronnstalker's Bracers",        34443),
    S("T6 - Gronnstalker's",    "Feet",     "Gronnstalker's Boots",          34570),

    -- PvP S1: Gladiator's Pursuit [set 586] — AtlasLoot ItemSet.lua
    S("Gladiator's - Pursuit",       "Head",     "Gladiator's Pursuit Helm",          28333),
    S("Gladiator's - Pursuit",       "Shoulder", "Gladiator's Pursuit Spaulders",     28334),
    S("Gladiator's - Pursuit",       "Chest",    "Gladiator's Pursuit Tunic",         28331),
    S("Gladiator's - Pursuit",       "Hands",    "Gladiator's Pursuit Gauntlets",     28335),
    S("Gladiator's - Pursuit",       "Legs",     "Gladiator's Pursuit Legguards",     28332),

    -- PvP S2: Merciless Gladiator's Pursuit [set 706]
    S("Merciless - Pursuit",       "Head",     "Merciless Gladiator's Pursuit Helm",      31964),
    S("Merciless - Pursuit",       "Shoulder", "Merciless Gladiator's Pursuit Spaulders", 31960),
    S("Merciless - Pursuit",       "Chest",    "Merciless Gladiator's Pursuit Tunic",     31962),
    S("Merciless - Pursuit",       "Hands",    "Merciless Gladiator's Pursuit Gauntlets", 31961),
    S("Merciless - Pursuit",       "Legs",     "Merciless Gladiator's Pursuit Legguards", 31963),

    -- PvP S3: Vengeful Gladiator's Pursuit [set 723]
    S("Vengeful - Pursuit",       "Head",     "Vengeful Gladiator's Pursuit Helm",       33668),
    S("Vengeful - Pursuit",       "Shoulder", "Vengeful Gladiator's Pursuit Spaulders",  33664),
    S("Vengeful - Pursuit",       "Chest",    "Vengeful Gladiator's Pursuit Tunic",      33666),
    S("Vengeful - Pursuit",       "Hands",    "Vengeful Gladiator's Pursuit Gauntlets",  33665),
    S("Vengeful - Pursuit",       "Legs",     "Vengeful Gladiator's Pursuit Legguards",  33667),

    -- PvP S4: Brutal Gladiator's Pursuit [set 2000586]
    S("Brutal - Pursuit",       "Head",     "Brutal Gladiator's Pursuit Helm",         34994),
    S("Brutal - Pursuit",       "Shoulder", "Brutal Gladiator's Pursuit Spaulders",    34990),
    S("Brutal - Pursuit",       "Chest",    "Brutal Gladiator's Pursuit Tunic",        34992),
    S("Brutal - Pursuit",       "Hands",    "Brutal Gladiator's Pursuit Gauntlets",    34991),
    S("Brutal - Pursuit",       "Legs",     "Brutal Gladiator's Pursuit Legguards",    34993),
}

-- ============================================================
-- MAGE
-- ============================================================
WW.DATA["MAGE"] = {
    -- Pre-Raid: Magister's Regalia (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Magister's",  "Head",     "Magister's Crown",              16686),
    S("Pre-Raid - Magister's",  "Shoulder", "Magister's Mantle",             16689),
    S("Pre-Raid - Magister's",  "Chest",    "Magister's Robes",              16688),
    S("Pre-Raid - Magister's",  "Hands",    "Magister's Gloves",             16684),
    S("Pre-Raid - Magister's",  "Legs",     "Magister's Leggings",           16687),
    S("Pre-Raid - Magister's",  "Feet",     "Magister's Boots",              16682),
    S("Pre-Raid - Magister's",  "Waist",    "Magister's Belt",               16685),
    S("Pre-Raid - Magister's",  "Wrist",    "Magister's Bindings",           16683),

    -- Classic T1: Arcanist Regalia (MC) — verified
    S("T1 - Arcanist",          "Head",     "Arcanist Crown",                16795),
    S("T1 - Arcanist",          "Shoulder", "Arcanist Mantle",               16797),
    S("T1 - Arcanist",          "Chest",    "Arcanist Robes",                16798),
    S("T1 - Arcanist",          "Hands",    "Arcanist Gloves",               16801),
    S("T1 - Arcanist",          "Legs",     "Arcanist Leggings",             16796),
    S("T1 - Arcanist",          "Feet",     "Arcanist Boots",                16800),
    S("T1 - Arcanist",          "Waist",    "Arcanist Belt",                 16802),
    S("T1 - Arcanist",          "Wrist",    "Arcanist Bindings",             16799),

    -- Classic T2: Netherwind Regalia (BWL) — verified
    S("T2 - Netherwind",        "Head",     "Netherwind Crown",              16914),
    S("T2 - Netherwind",        "Shoulder", "Netherwind Mantle",             16917),
    S("T2 - Netherwind",        "Chest",    "Netherwind Robes",              16916),
    S("T2 - Netherwind",        "Hands",    "Netherwind Gloves",             16913),
    S("T2 - Netherwind",        "Legs",     "Netherwind Pants",              16915),
    S("T2 - Netherwind",        "Feet",     "Netherwind Boots",              16912),
    S("T2 - Netherwind",        "Waist",    "Netherwind Belt",               16818),
    S("T2 - Netherwind",        "Wrist",    "Netherwind Bindings",           16918),

    -- Classic T3: Frostfire Regalia (Naxx)
    S("T3 - Frostfire",         "Head",     "Frostfire Circlet",             22498),
    S("T3 - Frostfire",         "Shoulder", "Frostfire Shoulderpads",        22499),
    S("T3 - Frostfire",         "Chest",    "Frostfire Robe",                22496),
    S("T3 - Frostfire",         "Hands",    "Frostfire Gloves",              22501),
    S("T3 - Frostfire",         "Legs",     "Frostfire Leggings",            22497),
    S("T3 - Frostfire",         "Feet",     "Frostfire Sandals",             22500),
    S("T3 - Frostfire",         "Waist",    "Frostfire Belt",                22502),
    S("T3 - Frostfire",         "Wrist",    "Frostfire Bindings",            22503),

    -- TBC T4: Aldor Regalia (Kara/Gruul/Mag)
    S("T4 - Aldor Regalia",     "Head",     "Collar of the Aldor",           29076),
    S("T4 - Aldor Regalia",     "Shoulder", "Pauldrons of the Aldor",        29079),
    S("T4 - Aldor Regalia",     "Chest",    "Vestments of the Aldor",        29077),
    S("T4 - Aldor Regalia",     "Hands",    "Gloves of the Aldor",           29080),
    S("T4 - Aldor Regalia",     "Legs",     "Legwraps of the Aldor",         29078),

    -- TBC T5: Tirisfal (SSC/TK)
    S("T5 - Tirisfal",          "Head",     "Cowl of Tirisfal",              30206),
    S("T5 - Tirisfal",          "Shoulder", "Mantle of Tirisfal",            30210),
    S("T5 - Tirisfal",          "Chest",    "Robes of Tirisfal",             30196),
    S("T5 - Tirisfal",          "Hands",    "Gloves of Tirisfal",            30205),
    S("T5 - Tirisfal",          "Legs",     "Leggings of Tirisfal",          30207),

    -- TBC T6: Tempest (Hyjal/BT/SWP)
    S("T6 - Tempest",           "Head",     "Cowl of the Tempest",           31056),
    S("T6 - Tempest",           "Shoulder", "Mantle of the Tempest",         31059),
    S("T6 - Tempest",           "Chest",    "Robes of the Tempest",          31057),
    S("T6 - Tempest",           "Hands",    "Gloves of the Tempest",         31055),
    S("T6 - Tempest",           "Legs",     "Leggings of the Tempest",       31058),
    S("T6 - Tempest",           "Waist",    "Belt of the Tempest",           34557),
    S("T6 - Tempest",           "Wrist",    "Bracers of the Tempest",        34447),
    S("T6 - Tempest",           "Feet",     "Boots of the Tempest",          34574),

    -- PvP S1: Gladiator's Regalia [set 579] — AtlasLoot ItemSet.lua
    S("Gladiator's - Regalia",       "Head",     "Gladiator's Regalia Hood",          25854),
    S("Gladiator's - Regalia",       "Shoulder", "Gladiator's Regalia Amice",         25856),
    S("Gladiator's - Regalia",       "Chest",    "Gladiator's Regalia Robe",          25855),
    S("Gladiator's - Regalia",       "Hands",    "Gladiator's Regalia Handguards",    25857),
    S("Gladiator's - Regalia",       "Legs",     "Gladiator's Regalia Leggings",      25858),

    -- PvP S2: Merciless Gladiator's Regalia [set 710]
    S("Merciless - Regalia",       "Head",     "Merciless Gladiator's Regalia Hood",      32047),
    S("Merciless - Regalia",       "Shoulder", "Merciless Gladiator's Regalia Amice",     32050),
    S("Merciless - Regalia",       "Chest",    "Merciless Gladiator's Regalia Robe",      32048),
    S("Merciless - Regalia",       "Hands",    "Merciless Gladiator's Regalia Handguards",32049),
    S("Merciless - Regalia",       "Legs",     "Merciless Gladiator's Regalia Leggings",  32051),

    -- PvP S3: Vengeful Gladiator's Regalia [set 724]
    S("Vengeful - Regalia",       "Head",     "Vengeful Gladiator's Regalia Hood",       33757),
    S("Vengeful - Regalia",       "Shoulder", "Vengeful Gladiator's Regalia Amice",      33760),
    S("Vengeful - Regalia",       "Chest",    "Vengeful Gladiator's Regalia Robe",       33758),
    S("Vengeful - Regalia",       "Hands",    "Vengeful Gladiator's Regalia Handguards", 33759),
    S("Vengeful - Regalia",       "Legs",     "Vengeful Gladiator's Regalia Leggings",   33761),

    -- PvP S4: Brutal Gladiator's Regalia [set 2000579]
    S("Brutal - Regalia",       "Head",     "Brutal Gladiator's Regalia Hood",         35096),
    S("Brutal - Regalia",       "Shoulder", "Brutal Gladiator's Regalia Amice",        35099),
    S("Brutal - Regalia",       "Chest",    "Brutal Gladiator's Regalia Robe",         35097),
    S("Brutal - Regalia",       "Hands",    "Brutal Gladiator's Regalia Handguards",   35098),
    S("Brutal - Regalia",       "Legs",     "Brutal Gladiator's Regalia Leggings",     35100),
}

-- ============================================================
-- PALADIN
-- ============================================================
WW.DATA["PALADIN"] = {
    -- Pre-Raid: Lightforge Armor (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Lightforge",  "Head",     "Lightforge Helm",               16727),
    S("Pre-Raid - Lightforge",  "Shoulder", "Lightforge Spaulders",          16729),
    S("Pre-Raid - Lightforge",  "Chest",    "Lightforge Breastplate",        16726),
    S("Pre-Raid - Lightforge",  "Hands",    "Lightforge Gauntlets",          16724),
    S("Pre-Raid - Lightforge",  "Legs",     "Lightforge Legplates",          16728),
    S("Pre-Raid - Lightforge",  "Feet",     "Lightforge Boots",              16725),
    S("Pre-Raid - Lightforge",  "Waist",    "Lightforge Belt",               16723),
    S("Pre-Raid - Lightforge",  "Wrist",    "Lightforge Bracers",            16722),

    -- Classic T1: Lawbringer Armor (MC) — partially verified
    S("T1 - Lawbringer",        "Head",     "Lawbringer Helm",               16854),
    S("T1 - Lawbringer",        "Shoulder", "Lawbringer Spaulders",          16858),
    S("T1 - Lawbringer",        "Chest",    "Lawbringer Chestguard",         16853),
    S("T1 - Lawbringer",        "Hands",    "Lawbringer Gauntlets",          16859),
    S("T1 - Lawbringer",        "Legs",     "Lawbringer Legplates",          16860),
    S("T1 - Lawbringer",        "Feet",     "Lawbringer Boots",              16856),
    S("T1 - Lawbringer",        "Waist",    "Lawbringer Belt",               16855),
    S("T1 - Lawbringer",        "Wrist",    "Lawbringer Bracers",            16857),

    -- Classic T2: Judgement Armor (BWL) — verified
    S("T2 - Judgement",         "Head",     "Judgement Crown",               16955),
    S("T2 - Judgement",         "Shoulder", "Judgement Spaulders",           16953),
    S("T2 - Judgement",         "Chest",    "Judgement Breastplate",         16958),
    S("T2 - Judgement",         "Hands",    "Judgement Gauntlets",           16956),
    S("T2 - Judgement",         "Legs",     "Judgement Legplates",           16954),
    S("T2 - Judgement",         "Feet",     "Judgement Sabatons",            16957),
    S("T2 - Judgement",         "Waist",    "Judgement Belt",                16952),
    S("T2 - Judgement",         "Wrist",    "Judgement Bindings",            16951),

    -- Classic T3: Redemption Armor (Naxx)
    S("T3 - Redemption",        "Head",     "Redemption Headpiece",          22428),
    S("T3 - Redemption",        "Shoulder", "Redemption Spaulders",          22429),
    S("T3 - Redemption",        "Chest",    "Redemption Tunic",              22425),
    S("T3 - Redemption",        "Hands",    "Redemption Handguards",         22426),
    S("T3 - Redemption",        "Legs",     "Redemption Legguards",          22427),
    S("T3 - Redemption",        "Feet",     "Redemption Boots",              22430),
    S("T3 - Redemption",        "Waist",    "Redemption Girdle",             22431),
    S("T3 - Redemption",        "Wrist",    "Redemption Wristguards",        22424),

    -- TBC T4: Justicar (Kara/Gruul/Mag)
    S("T4 - Justicar",          "Head",     "Justicar Faceguard",            29068),
    S("T4 - Justicar",          "Shoulder", "Justicar Shoulderguards",       29070),
    S("T4 - Justicar",          "Chest",    "Justicar Chestguard",           29066),
    S("T4 - Justicar",          "Hands",    "Justicar Handguards",           29067),
    S("T4 - Justicar",          "Legs",     "Justicar Legguards",            29069),

    -- TBC T5: Crystalforge (SSC/TK)
    S("T5 - Crystalforge",      "Head",     "Crystalforge Greathelm",        30136),
    S("T5 - Crystalforge",      "Shoulder", "Crystalforge Pauldrons",        30138),
    S("T5 - Crystalforge",      "Chest",    "Crystalforge Chestpiece",       30134),
    S("T5 - Crystalforge",      "Hands",    "Crystalforge Gloves",           30135),
    S("T5 - Crystalforge",      "Legs",     "Crystalforge Leggings",         30137),

    -- TBC T6: Lightbringer (Hyjal/BT/SWP)
    S("T6 - Lightbringer",      "Head",     "Lightbringer Faceguard",        30987),
    S("T6 - Lightbringer",      "Shoulder", "Lightbringer Shoulderguards",   30998),
    S("T6 - Lightbringer",      "Chest",    "Lightbringer Chestguard",       30991),
    S("T6 - Lightbringer",      "Hands",    "Lightbringer Handguards",       30985),
    S("T6 - Lightbringer",      "Legs",     "Lightbringer Legguards",        30995),
    S("T6 - Lightbringer",      "Waist",    "Lightbringer Waistguard",       34488),
    S("T6 - Lightbringer",      "Wrist",    "Lightbringer Wristguards",      34433),
    S("T6 - Lightbringer",      "Feet",     "Lightbringer Stompers",         34560),

    -- PvP S1: Gladiator's Aegis [set 582] — AtlasLoot ItemSet.lua
    S("Gladiator's - Aegis",         "Head",     "Gladiator's Aegis Helm",            27706),
    S("Gladiator's - Aegis",         "Shoulder", "Gladiator's Aegis Spaulders",       27702),
    S("Gladiator's - Aegis",         "Chest",    "Gladiator's Aegis Chestguard",      27704),
    S("Gladiator's - Aegis",         "Hands",    "Gladiator's Aegis Gauntlets",       27703),
    S("Gladiator's - Aegis",         "Legs",     "Gladiator's Aegis Legguards",       27705),

    -- PvP S2: Merciless Gladiator's Aegis [set 700]
    S("Merciless - Aegis",         "Head",     "Merciless Gladiator's Aegis Helm",      31996),
    S("Merciless - Aegis",         "Shoulder", "Merciless Gladiator's Aegis Spaulders", 31992),
    S("Merciless - Aegis",         "Chest",    "Merciless Gladiator's Aegis Chestguard",31997),
    S("Merciless - Aegis",         "Hands",    "Merciless Gladiator's Aegis Gauntlets", 31993),
    S("Merciless - Aegis",         "Legs",     "Merciless Gladiator's Aegis Legguards", 31995),

    -- PvP S3: Vengeful Gladiator's Aegis [set 727]
    S("Vengeful - Aegis",         "Head",     "Vengeful Gladiator's Aegis Helm",       33699),
    S("Vengeful - Aegis",         "Shoulder", "Vengeful Gladiator's Aegis Spaulders",  33695),
    S("Vengeful - Aegis",         "Chest",    "Vengeful Gladiator's Aegis Chestguard", 33697),
    S("Vengeful - Aegis",         "Hands",    "Vengeful Gladiator's Aegis Gauntlets",  33696),
    S("Vengeful - Aegis",         "Legs",     "Vengeful Gladiator's Aegis Legguards",  33698),

    -- PvP S4: Brutal Gladiator's Aegis [set 2000582]
    S("Brutal - Aegis",         "Head",     "Brutal Gladiator's Aegis Helm",         35031),
    S("Brutal - Aegis",         "Shoulder", "Brutal Gladiator's Aegis Spaulders",    35027),
    S("Brutal - Aegis",         "Chest",    "Brutal Gladiator's Aegis Chestguard",   35029),
    S("Brutal - Aegis",         "Hands",    "Brutal Gladiator's Aegis Gauntlets",    35028),
    S("Brutal - Aegis",         "Legs",     "Brutal Gladiator's Aegis Legguards",    35030),
}

-- ============================================================
-- PRIEST
-- ============================================================
WW.DATA["PRIEST"] = {
    -- Pre-Raid: Devout Regalia (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Devout",      "Head",     "Devout Crown",                  16693),
    S("Pre-Raid - Devout",      "Shoulder", "Devout Mantle",                 16695),
    S("Pre-Raid - Devout",      "Chest",    "Devout Robe",                   16690),
    S("Pre-Raid - Devout",      "Hands",    "Devout Gloves",                 16692),
    S("Pre-Raid - Devout",      "Legs",     "Devout Skirt",                  16694),
    S("Pre-Raid - Devout",      "Feet",     "Devout Sandals",                16691),
    S("Pre-Raid - Devout",      "Waist",    "Devout Belt",                   16696),
    S("Pre-Raid - Devout",      "Wrist",    "Devout Bracers",                16697),

    -- Classic T1: Vestments of Prophecy (MC) — verified
    S("T1 - Prophecy",          "Head",     "Circlet of Prophecy",           16813),
    S("T1 - Prophecy",          "Shoulder", "Mantle of Prophecy",            16816),
    S("T1 - Prophecy",          "Chest",    "Robes of Prophecy",             16815),
    S("T1 - Prophecy",          "Hands",    "Gloves of Prophecy",            16812),
    S("T1 - Prophecy",          "Legs",     "Pants of Prophecy",             16814),
    S("T1 - Prophecy",          "Feet",     "Boots of Prophecy",             16811),
    S("T1 - Prophecy",          "Waist",    "Sash of Prophecy",              16817),
    S("T1 - Prophecy",          "Wrist",    "Vambraces of Prophecy",         16819),

    -- Classic T2: Transcendence (BWL) — verified
    S("T2 - Transcendence",     "Head",     "Halo of Transcendence",         16921),
    S("T2 - Transcendence",     "Shoulder", "Pauldrons of Transcendence",    16924),
    S("T2 - Transcendence",     "Chest",    "Robes of Transcendence",        16923),
    S("T2 - Transcendence",     "Hands",    "Handguards of Transcendence",   16920),
    S("T2 - Transcendence",     "Legs",     "Leggings of Transcendence",     16922),
    S("T2 - Transcendence",     "Feet",     "Boots of Transcendence",        16919),
    S("T2 - Transcendence",     "Waist",    "Belt of Transcendence",         16925),
    S("T2 - Transcendence",     "Wrist",    "Bindings of Transcendence",     16926),

    -- Classic T3: Vestments of Faith (Naxx)
    S("T3 - Faith",             "Head",     "Circlet of Faith",              22514),
    S("T3 - Faith",             "Shoulder", "Shoulderpads of Faith",         22515),
    S("T3 - Faith",             "Chest",    "Robe of Faith",                 22512),
    S("T3 - Faith",             "Hands",    "Gloves of Faith",               22517),
    S("T3 - Faith",             "Legs",     "Leggings of Faith",             22513),
    S("T3 - Faith",             "Feet",     "Sandals of Faith",              22516),
    S("T3 - Faith",             "Waist",    "Belt of Faith",                 22518),
    S("T3 - Faith",             "Wrist",    "Bindings of Faith",             22519),

    -- TBC T4: Avatar Raiment (Kara/Gruul/Mag)
    S("T4 - Avatar Raiment",    "Head",     "Cowl of the Avatar",            30152),
    S("T4 - Avatar Raiment",    "Shoulder", "Mantle of the Avatar",          30154),
    S("T4 - Avatar Raiment",    "Chest",    "Vestments of the Avatar",       30150),
    S("T4 - Avatar Raiment",    "Hands",    "Gloves of the Avatar",          30151),
    S("T4 - Avatar Raiment",    "Legs",     "Breeches of the Avatar",        30153),

    -- TBC T5: Avatar Regalia (SSC/TK)
    S("T5 - Avatar Regalia",    "Head",     "Hood of the Avatar",            30161),
    S("T5 - Avatar Regalia",    "Shoulder", "Wings of the Avatar",           30163),
    S("T5 - Avatar Regalia",    "Chest",    "Shroud of the Avatar",          30159),
    S("T5 - Avatar Regalia",    "Hands",    "Handguards of the Avatar",      30160),
    S("T5 - Avatar Regalia",    "Legs",     "Leggings of the Avatar",        30162),

    -- TBC T6: Absolution (Hyjal/BT/SWP)
    S("T6 - Absolution",        "Head",     "Cowl of Absolution",            31063),
    S("T6 - Absolution",        "Shoulder", "Mantle of Absolution",          31069),
    S("T6 - Absolution",        "Chest",    "Vestments of Absolution",       31066),
    S("T6 - Absolution",        "Hands",    "Gloves of Absolution",          31060),
    S("T6 - Absolution",        "Legs",     "Breeches of Absolution",        31068),
    S("T6 - Absolution",        "Waist",    "Belt of Absolution",            34527),
    S("T6 - Absolution",        "Wrist",    "Cuffs of Absolution",           34435),
    S("T6 - Absolution",        "Feet",     "Boots of Absolution",           34562),

    -- PvP S1: Gladiator's Raiment [set 581] — AtlasLoot ItemSet.lua
    S("Gladiator's - Raiment",       "Head",     "Gladiator's Raiment Hood",          27710),
    S("Gladiator's - Raiment",       "Shoulder", "Gladiator's Raiment Mantle",        27711),
    S("Gladiator's - Raiment",       "Chest",    "Gladiator's Raiment Robe",          27708),
    S("Gladiator's - Raiment",       "Hands",    "Gladiator's Raiment Gloves",        27707),
    S("Gladiator's - Raiment",       "Legs",     "Gladiator's Raiment Leggings",      27709),

    -- PvP S2: Merciless Gladiator's Raiment [set 707]
    S("Merciless - Raiment",       "Head",     "Merciless Gladiator's Raiment Hood",      32037),
    S("Merciless - Raiment",       "Shoulder", "Merciless Gladiator's Raiment Mantle",    32038),
    S("Merciless - Raiment",       "Chest",    "Merciless Gladiator's Raiment Robe",      32035),
    S("Merciless - Raiment",       "Hands",    "Merciless Gladiator's Raiment Gloves",    32034),
    S("Merciless - Raiment",       "Legs",     "Merciless Gladiator's Raiment Leggings",  32036),

    -- PvP S3: Vengeful Gladiator's Raiment [set 729]
    S("Vengeful - Raiment",       "Head",     "Vengeful Gladiator's Raiment Hood",       33747),
    S("Vengeful - Raiment",       "Shoulder", "Vengeful Gladiator's Raiment Mantle",     33748),
    S("Vengeful - Raiment",       "Chest",    "Vengeful Gladiator's Raiment Robe",       33745),
    S("Vengeful - Raiment",       "Hands",    "Vengeful Gladiator's Raiment Gloves",     33744),
    S("Vengeful - Raiment",       "Legs",     "Vengeful Gladiator's Raiment Leggings",   33746),

    -- PvP S4: Brutal Gladiator's Raiment [set 2000581]
    S("Brutal - Raiment",       "Head",     "Brutal Gladiator's Raiment Hood",         35086),
    S("Brutal - Raiment",       "Shoulder", "Brutal Gladiator's Raiment Mantle",       35087),
    S("Brutal - Raiment",       "Chest",    "Brutal Gladiator's Raiment Robe",         35084),
    S("Brutal - Raiment",       "Hands",    "Brutal Gladiator's Raiment Gloves",       35083),
    S("Brutal - Raiment",       "Legs",     "Brutal Gladiator's Raiment Leggings",     35085),
}

-- ============================================================
-- ROGUE
-- ============================================================
WW.DATA["ROGUE"] = {
    -- Pre-Raid: Shadowcraft Armor (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Shadowcraft",  "Head",    "Shadowcraft Cap",               16707),
    S("Pre-Raid - Shadowcraft",  "Shoulder","Shadowcraft Spaulders",         16708),
    S("Pre-Raid - Shadowcraft",  "Chest",   "Shadowcraft Tunic",             16721),
    S("Pre-Raid - Shadowcraft",  "Hands",   "Shadowcraft Gloves",            16712),
    S("Pre-Raid - Shadowcraft",  "Legs",    "Shadowcraft Pants",             16709),
    S("Pre-Raid - Shadowcraft",  "Feet",    "Shadowcraft Boots",             16711),
    S("Pre-Raid - Shadowcraft",  "Waist",   "Shadowcraft Belt",              16713),
    S("Pre-Raid - Shadowcraft",  "Wrist",   "Shadowcraft Bracers",           16710),

    -- Classic T1: Nightslayer Armor (MC) — verified
    S("T1 - Nightslayer",       "Head",     "Nightslayer Cover",             16821),
    S("T1 - Nightslayer",       "Shoulder", "Nightslayer Shoulder Pads",     16823),
    S("T1 - Nightslayer",       "Chest",    "Nightslayer Chestpiece",        16820),
    S("T1 - Nightslayer",       "Hands",    "Nightslayer Gloves",            16826),
    S("T1 - Nightslayer",       "Legs",     "Nightslayer Pants",             16822),
    S("T1 - Nightslayer",       "Feet",     "Nightslayer Boots",             16824),
    S("T1 - Nightslayer",       "Waist",    "Nightslayer Belt",              16827),
    S("T1 - Nightslayer",       "Wrist",    "Nightslayer Bracelets",         16825),

    -- Classic T2: Bloodfang Armor (BWL) — verified
    S("T2 - Bloodfang",         "Head",     "Bloodfang Hood",                16908),
    S("T2 - Bloodfang",         "Shoulder", "Bloodfang Spaulders",           16832),
    S("T2 - Bloodfang",         "Chest",    "Bloodfang Chestpiece",          16905),
    S("T2 - Bloodfang",         "Hands",    "Bloodfang Gloves",              16907),
    S("T2 - Bloodfang",         "Legs",     "Bloodfang Pants",               16909),
    S("T2 - Bloodfang",         "Feet",     "Bloodfang Boots",               16906),
    S("T2 - Bloodfang",         "Waist",    "Bloodfang Belt",                16910),
    S("T2 - Bloodfang",         "Wrist",    "Bloodfang Bracers",             16911),

    -- Classic T3: Bonescythe Armor (Naxx)
    S("T3 - Bonescythe",        "Head",     "Bonescythe Helmet",             22478),
    S("T3 - Bonescythe",        "Shoulder", "Bonescythe Pauldrons",          22479),
    S("T3 - Bonescythe",        "Chest",    "Bonescythe Breastplate",        22476),
    S("T3 - Bonescythe",        "Hands",    "Bonescythe Gauntlets",          22481),
    S("T3 - Bonescythe",        "Legs",     "Bonescythe Legplates",          22477),
    S("T3 - Bonescythe",        "Feet",     "Bonescythe Sabatons",           22480),
    S("T3 - Bonescythe",        "Waist",    "Bonescythe Waistguard",         22482),
    S("T3 - Bonescythe",        "Wrist",    "Bonescythe Bracers",            22483),

    -- TBC T4: Netherblade (Kara/Gruul/Mag)
    S("T4 - Netherblade",       "Head",     "Netherblade Cover",             29087),
    S("T4 - Netherblade",       "Shoulder", "Netherblade Shoulderpads",      29089),
    S("T4 - Netherblade",       "Chest",    "Netherblade Chestpiece",        29085),
    S("T4 - Netherblade",       "Hands",    "Netherblade Gloves",            29086),
    S("T4 - Netherblade",       "Legs",     "Netherblade Breeches",          29088),

    -- TBC T5: Deathmantle (SSC/TK)
    S("T5 - Deathmantle",       "Head",     "Deathmantle Helm",              30146),
    S("T5 - Deathmantle",       "Shoulder", "Deathmantle Shoulderpads",      30149),
    S("T5 - Deathmantle",       "Chest",    "Deathmantle Chestguard",        30144),
    S("T5 - Deathmantle",       "Hands",    "Deathmantle Handguards",        30145),
    S("T5 - Deathmantle",       "Legs",     "Deathmantle Legguards",         30148),

    -- TBC T6: Slayer's Armor (Hyjal/BT/SWP)
    S("T6 - Slayer's Armor",    "Head",     "Slayer's Helm",                 31027),
    S("T6 - Slayer's Armor",    "Shoulder", "Slayer's Shoulderpads",         31030),
    S("T6 - Slayer's Armor",    "Chest",    "Slayer's Chestguard",           31028),
    S("T6 - Slayer's Armor",    "Hands",    "Slayer's Handguards",           31026),
    S("T6 - Slayer's Armor",    "Legs",     "Slayer's Legguards",            31029),
    S("T6 - Slayer's Armor",    "Waist",    "Slayer's Belt",                 34558),
    S("T6 - Slayer's Armor",    "Wrist",    "Slayer's Bracers",              34448),
    S("T6 - Slayer's Armor",    "Feet",     "Slayer's Boots",                34575),

    -- PvP S1: Gladiator's Wildhide [set 585] — AtlasLoot ItemSet.lua
    S("Gladiator's - Wildhide",      "Head",     "Gladiator's Wildhide Helm",         28139),
    S("Gladiator's - Wildhide",      "Shoulder", "Gladiator's Wildhide Spaulders",    28140),
    S("Gladiator's - Wildhide",      "Chest",    "Gladiator's Wildhide Tunic",        28137),
    S("Gladiator's - Wildhide",      "Hands",    "Gladiator's Wildhide Gloves",       28136),
    S("Gladiator's - Wildhide",      "Legs",     "Gladiator's Wildhide Legguards",    28138),

    -- PvP S2: Merciless Gladiator's Wildhide [set 716]
    S("Merciless - Wildhide",      "Head",     "Merciless Gladiator's Wildhide Helm",      32059),
    S("Merciless - Wildhide",      "Shoulder", "Merciless Gladiator's Wildhide Spaulders", 32060),
    S("Merciless - Wildhide",      "Chest",    "Merciless Gladiator's Wildhide Tunic",     32057),
    S("Merciless - Wildhide",      "Hands",    "Merciless Gladiator's Wildhide Gloves",    32056),
    S("Merciless - Wildhide",      "Legs",     "Merciless Gladiator's Wildhide Legguards", 32058),

    -- PvP S3: Vengeful Gladiator's Wildhide [set 722]
    S("Vengeful - Wildhide",      "Head",     "Vengeful Gladiator's Wildhide Helm",       33770),
    S("Vengeful - Wildhide",      "Shoulder", "Vengeful Gladiator's Wildhide Spaulders",  33771),
    S("Vengeful - Wildhide",      "Chest",    "Vengeful Gladiator's Wildhide Tunic",      33768),
    S("Vengeful - Wildhide",      "Hands",    "Vengeful Gladiator's Wildhide Gloves",     33767),
    S("Vengeful - Wildhide",      "Legs",     "Vengeful Gladiator's Wildhide Legguards",  33769),

    -- PvP S4: Brutal Gladiator's Wildhide [set 2000585]
    S("Brutal - Wildhide",      "Head",     "Brutal Gladiator's Wildhide Helm",         35114),
    S("Brutal - Wildhide",      "Shoulder", "Brutal Gladiator's Wildhide Spaulders",    35115),
    S("Brutal - Wildhide",      "Chest",    "Brutal Gladiator's Wildhide Tunic",        35112),
    S("Brutal - Wildhide",      "Hands",    "Brutal Gladiator's Wildhide Gloves",       35111),
    S("Brutal - Wildhide",      "Legs",     "Brutal Gladiator's Wildhide Legguards",    35113),
}

-- ============================================================
-- SHAMAN
-- ============================================================
WW.DATA["SHAMAN"] = {
    -- Classic T1: The Elements (MC) — verified
    S("T1 - The Elements",      "Head",     "Earthfury Helmet",              16842),
    S("T1 - The Elements",      "Shoulder", "Earthfury Epaulets",            16844),
    S("T1 - The Elements",      "Chest",    "Earthfury Vestments",           16841),
    S("T1 - The Elements",      "Hands",    "Earthfury Gauntlets",           16839),
    S("T1 - The Elements",      "Legs",     "Earthfury Legguards",           16843),
    S("T1 - The Elements",      "Feet",     "Earthfury Boots",               16837),
    S("T1 - The Elements",      "Waist",    "Earthfury Belt",                16838),
    S("T1 - The Elements",      "Wrist",    "Earthfury Bracers",             16840),

    -- Classic T2: Ten Storms (BWL) — verified
    S("T2 - Ten Storms",        "Head",     "Helmet of Ten Storms",          16947),
    S("T2 - Ten Storms",        "Shoulder", "Epaulets of Ten Storms",        16945),
    S("T2 - Ten Storms",        "Chest",    "Breastplate of Ten Storms",     16950),
    S("T2 - Ten Storms",        "Hands",    "Gauntlets of Ten Storms",       16948),
    S("T2 - Ten Storms",        "Legs",     "Legplates of Ten Storms",       16946),
    S("T2 - Ten Storms",        "Feet",     "Greaves of Ten Storms",         16949),
    S("T2 - Ten Storms",        "Waist",    "Belt of Ten Storms",            16944),
    S("T2 - Ten Storms",        "Wrist",    "Bracers of Ten Storms",         16943),

    -- Classic T3: The Earthshatterer (Naxx)
    S("T3 - Earthshatterer",    "Head",     "Earthshatter Headpiece",        22466),
    S("T3 - Earthshatterer",    "Shoulder", "Earthshatter Spaulders",        22467),
    S("T3 - Earthshatterer",    "Chest",    "Earthshatter Tunic",            22464),
    S("T3 - Earthshatterer",    "Hands",    "Earthshatter Handguards",       22469),
    S("T3 - Earthshatterer",    "Legs",     "Earthshatter Legguards",        22465),
    S("T3 - Earthshatterer",    "Feet",     "Earthshatter Boots",            22468),
    S("T3 - Earthshatterer",    "Waist",    "Earthshatter Girdle",           22470),
    S("T3 - Earthshatterer",    "Wrist",    "Earthshatter Wristguards",      22471),

    -- TBC T4: Cyclone (Kara/Gruul/Mag) — confirmed scan: 29028-29039 range
    S("T4 - Cyclone",           "Head",     "Cyclone Headdress",             29028),
    S("T4 - Cyclone",           "Shoulder", "Cyclone Shoulderpads",          29031),
    S("T4 - Cyclone",           "Chest",    "Cyclone Hauberk",               29029),
    S("T4 - Cyclone",           "Hands",    "Cyclone Gloves",                29032),
    S("T4 - Cyclone",           "Legs",     "Cyclone Kilt",                  29030),

    -- TBC T5: Cataclysm (SSC/TK)
    S("T5 - Cataclysm",         "Head",     "Cataclysm Headguard",           30166),
    S("T5 - Cataclysm",         "Shoulder", "Cataclysm Shoulderguards",      30168),
    S("T5 - Cataclysm",         "Chest",    "Cataclysm Chestguard",          30164),
    S("T5 - Cataclysm",         "Hands",    "Cataclysm Gloves",              30165),
    S("T5 - Cataclysm",         "Legs",     "Cataclysm Legguards",           30167),

    -- TBC T6: Skyshatter (Hyjal/BT/SWP)
    S("T6 - Skyshatter",        "Head",     "Skyshatter Helmet",             31012),
    S("T6 - Skyshatter",        "Shoulder", "Skyshatter Shoulderpads",       31022),
    S("T6 - Skyshatter",        "Chest",    "Skyshatter Chestguard",         31016),
    S("T6 - Skyshatter",        "Hands",    "Skyshatter Gloves",             31007),
    S("T6 - Skyshatter",        "Legs",     "Skyshatter Leggings",           31019),
    S("T6 - Skyshatter",        "Waist",    "Skyshatter Belt",               34543),
    S("T6 - Skyshatter",        "Wrist",    "Skyshatter Bracers",            34438),
    S("T6 - Skyshatter",        "Feet",     "Skyshatter Boots",              34565),

    -- PvP S1: Gladiator's Earthshaker [set 578] — AtlasLoot ItemSet.lua
    S("Gladiator's - Earthshaker",   "Head",     "Gladiator's Earthshaker Helm",      25999),
    S("Gladiator's - Earthshaker",   "Shoulder", "Gladiator's Earthshaker Spaulders", 25997),
    S("Gladiator's - Earthshaker",   "Chest",    "Gladiator's Earthshaker Hauberk",   25998),
    S("Gladiator's - Earthshaker",   "Hands",    "Gladiator's Earthshaker Gauntlets", 26000),
    S("Gladiator's - Earthshaker",   "Legs",     "Gladiator's Earthshaker Kilt",      26001),

    -- PvP S2: Merciless Gladiator's Earthshaker [set 703]
    S("Merciless - Earthshaker",   "Head",     "Merciless Gladiator's Earthshaker Helm",      32008),
    S("Merciless - Earthshaker",   "Shoulder", "Merciless Gladiator's Earthshaker Spaulders", 32004),
    S("Merciless - Earthshaker",   "Chest",    "Merciless Gladiator's Earthshaker Hauberk",   32006),
    S("Merciless - Earthshaker",   "Hands",    "Merciless Gladiator's Earthshaker Gauntlets", 32005),
    S("Merciless - Earthshaker",   "Legs",     "Merciless Gladiator's Earthshaker Kilt",      32007),

    -- PvP S3: Vengeful Gladiator's Earthshaker [set 732]
    S("Vengeful - Earthshaker",   "Head",     "Vengeful Gladiator's Earthshaker Helm",       33710),
    S("Vengeful - Earthshaker",   "Shoulder", "Vengeful Gladiator's Earthshaker Spaulders",  33706),
    S("Vengeful - Earthshaker",   "Chest",    "Vengeful Gladiator's Earthshaker Hauberk",    33708),
    S("Vengeful - Earthshaker",   "Hands",    "Vengeful Gladiator's Earthshaker Gauntlets",  33707),
    S("Vengeful - Earthshaker",   "Legs",     "Vengeful Gladiator's Earthshaker Kilt",       33709),

    -- PvP S4: Brutal Gladiator's Earthshaker [set 2000578]
    S("Brutal - Earthshaker",   "Head",     "Brutal Gladiator's Earthshaker Helm",         35046),
    S("Brutal - Earthshaker",   "Shoulder", "Brutal Gladiator's Earthshaker Spaulders",    35042),
    S("Brutal - Earthshaker",   "Chest",    "Brutal Gladiator's Earthshaker Hauberk",      35044),
    S("Brutal - Earthshaker",   "Hands",    "Brutal Gladiator's Earthshaker Gauntlets",    35043),
    S("Brutal - Earthshaker",   "Legs",     "Brutal Gladiator's Earthshaker Kilt",         35045),
}

-- ============================================================
-- WARLOCK
-- ============================================================
WW.DATA["WARLOCK"] = {
    -- Pre-Raid: Dreadmist Raiment (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Dreadmist",   "Head",     "Dreadmist Mask",                16698),
    S("Pre-Raid - Dreadmist",   "Shoulder", "Dreadmist Mantle",              16701),
    S("Pre-Raid - Dreadmist",   "Chest",    "Dreadmist Robe",                16700),
    S("Pre-Raid - Dreadmist",   "Hands",    "Dreadmist Wraps",               16705),
    S("Pre-Raid - Dreadmist",   "Legs",     "Dreadmist Leggings",            16699),
    S("Pre-Raid - Dreadmist",   "Feet",     "Dreadmist Sandals",             16704),
    S("Pre-Raid - Dreadmist",   "Waist",    "Dreadmist Belt",                16702),
    S("Pre-Raid - Dreadmist",   "Wrist",    "Dreadmist Bracers",             16703),

    -- Classic T1: Felheart Raiment (MC) — verified
    S("T1 - Felheart",          "Head",     "Felheart Horns",                16808),
    S("T1 - Felheart",          "Shoulder", "Felheart Shoulder Pads",        16807),
    S("T1 - Felheart",          "Chest",    "Felheart Robes",                16809),
    S("T1 - Felheart",          "Hands",    "Felheart Gloves",               16805),
    S("T1 - Felheart",          "Legs",     "Felheart Pants",                16810),
    S("T1 - Felheart",          "Feet",     "Felheart Slippers",             16803),
    S("T1 - Felheart",          "Waist",    "Felheart Belt",                 16806),
    S("T1 - Felheart",          "Wrist",    "Felheart Bracers",              16804),

    -- Classic T2: Nemesis Raiment (BWL) — verified
    S("T2 - Nemesis",           "Head",     "Nemesis Skullcap",              16929),
    S("T2 - Nemesis",           "Shoulder", "Nemesis Spaulders",             16932),
    S("T2 - Nemesis",           "Chest",    "Nemesis Robes",                 16931),
    S("T2 - Nemesis",           "Hands",    "Nemesis Gloves",                16928),
    S("T2 - Nemesis",           "Legs",     "Nemesis Leggings",              16930),
    S("T2 - Nemesis",           "Feet",     "Nemesis Boots",                 16927),
    S("T2 - Nemesis",           "Waist",    "Nemesis Belt",                  16933),
    S("T2 - Nemesis",           "Wrist",    "Nemesis Bracers",               16934),

    -- Classic T3: Plagueheart Raiment (Naxx)
    S("T3 - Plagueheart",       "Head",     "Plagueheart Circlet",           22506),
    S("T3 - Plagueheart",       "Shoulder", "Plagueheart Shoulderpads",      22507),
    S("T3 - Plagueheart",       "Chest",    "Plagueheart Robe",              22504),
    S("T3 - Plagueheart",       "Hands",    "Plagueheart Gloves",            22509),
    S("T3 - Plagueheart",       "Legs",     "Plagueheart Leggings",          22505),
    S("T3 - Plagueheart",       "Feet",     "Plagueheart Sandals",           22508),
    S("T3 - Plagueheart",       "Waist",    "Plagueheart Belt",              22510),
    S("T3 - Plagueheart",       "Wrist",    "Plagueheart Bindings",          22511),

    -- TBC T4: Voidheart (Kara/Gruul/Mag)
    S("T4 - Voidheart",         "Head",     "Voidheart Crown",               28963),
    S("T4 - Voidheart",         "Shoulder", "Voidheart Mantle",              28967),
    S("T4 - Voidheart",         "Chest",    "Voidheart Robe",                28964),
    S("T4 - Voidheart",         "Hands",    "Voidheart Gloves",              28968),
    S("T4 - Voidheart",         "Legs",     "Voidheart Leggings",            28966),

    -- TBC T5: Corruptor (SSC/TK)
    S("T5 - Corruptor",         "Head",     "Hood of the Corruptor",         30212),
    S("T5 - Corruptor",         "Shoulder", "Mantle of the Corruptor",       30215),
    S("T5 - Corruptor",         "Chest",    "Robe of the Corruptor",         30214),
    S("T5 - Corruptor",         "Hands",    "Gloves of the Corruptor",       30211),
    S("T5 - Corruptor",         "Legs",     "Leggings of the Corruptor",     30213),

    -- TBC T6: Malefic (Hyjal/BT/SWP)
    S("T6 - Malefic",           "Head",     "Hood of the Malefic",           31051),
    S("T6 - Malefic",           "Shoulder", "Mantle of the Malefic",         31054),
    S("T6 - Malefic",           "Chest",    "Robe of the Malefic",           31052),
    S("T6 - Malefic",           "Hands",    "Gloves of the Malefic",         31050),
    S("T6 - Malefic",           "Legs",     "Leggings of the Malefic",       31053),
    S("T6 - Malefic",           "Waist",    "Belt of the Malefic",           34541),
    S("T6 - Malefic",           "Wrist",    "Bracers of the Malefic",        34436),
    S("T6 - Malefic",           "Feet",     "Boots of the Malefic",          34564),

    -- PvP S1: Gladiator's Dreadgear [set 568] — AtlasLoot ItemSet.lua
    S("Gladiator's - Dreadgear",     "Head",     "Gladiator's Dreadgear Hood",        24554),
    S("Gladiator's - Dreadgear",     "Shoulder", "Gladiator's Dreadgear Mantle",      24552),
    S("Gladiator's - Dreadgear",     "Chest",    "Gladiator's Dreadgear Robes",       24553),
    S("Gladiator's - Dreadgear",     "Hands",    "Gladiator's Dreadgear Gloves",      24556),
    S("Gladiator's - Dreadgear",     "Legs",     "Gladiator's Dreadgear Leggings",    24555),

    -- PvP S2: Merciless Gladiator's Dreadgear [set 702]
    S("Merciless - Dreadgear",     "Head",     "Merciless Gladiator's Dreadgear Hood",     31976),
    S("Merciless - Dreadgear",     "Shoulder", "Merciless Gladiator's Dreadgear Mantle",   31977),
    S("Merciless - Dreadgear",     "Chest",    "Merciless Gladiator's Dreadgear Robes",    31974),
    S("Merciless - Dreadgear",     "Hands",    "Merciless Gladiator's Dreadgear Gloves",   31973),
    S("Merciless - Dreadgear",     "Legs",     "Merciless Gladiator's Dreadgear Leggings", 31975),

    -- PvP S3: Vengeful Gladiator's Dreadgear [set 734]
    S("Vengeful - Dreadgear",     "Head",     "Vengeful Gladiator's Dreadgear Hood",      33679),
    S("Vengeful - Dreadgear",     "Shoulder", "Vengeful Gladiator's Dreadgear Mantle",    33680),
    S("Vengeful - Dreadgear",     "Chest",    "Vengeful Gladiator's Dreadgear Robes",     33677),
    S("Vengeful - Dreadgear",     "Hands",    "Vengeful Gladiator's Dreadgear Gloves",    33676),
    S("Vengeful - Dreadgear",     "Legs",     "Vengeful Gladiator's Dreadgear Leggings",  33678),

    -- PvP S4: Brutal Gladiator's Dreadgear [set 2000568]
    S("Brutal - Dreadgear",     "Head",     "Brutal Gladiator's Dreadgear Hood",        35006),
    S("Brutal - Dreadgear",     "Shoulder", "Brutal Gladiator's Dreadgear Mantle",      35007),
    S("Brutal - Dreadgear",     "Chest",    "Brutal Gladiator's Dreadgear Robes",       35004),
    S("Brutal - Dreadgear",     "Hands",    "Brutal Gladiator's Dreadgear Gloves",      35003),
    S("Brutal - Dreadgear",     "Legs",     "Brutal Gladiator's Dreadgear Leggings",    35005),
}

-- ============================================================
-- WARRIOR
-- ============================================================
WW.DATA["WARRIOR"] = {
    -- Pre-Raid: Valor Armor (dungeon blues) — IDs from AtlasLoot data.lua
    S("Pre-Raid - Valor",       "Head",     "Helm of Valor",                 16731),
    S("Pre-Raid - Valor",       "Shoulder", "Spaulders of Valor",            16733),
    S("Pre-Raid - Valor",       "Chest",    "Breastplate of Valor",          16730),
    S("Pre-Raid - Valor",       "Hands",    "Gauntlets of Valor",            16737),
    S("Pre-Raid - Valor",       "Legs",     "Legplates of Valor",            16732),
    S("Pre-Raid - Valor",       "Feet",     "Boots of Valor",                16734),
    S("Pre-Raid - Valor",       "Waist",    "Belt of Valor",                 16736),
    S("Pre-Raid - Valor",       "Wrist",    "Bracers of Valor",              16735),

    -- Classic T1: Battlegear of Might (MC) — verified
    S("T1 - Might",             "Head",     "Helm of Might",                 16866),
    S("T1 - Might",             "Shoulder", "Pauldrons of Might",            16868),
    S("T1 - Might",             "Chest",    "Breastplate of Might",          16865),
    S("T1 - Might",             "Hands",    "Gauntlets of Might",            16863),
    S("T1 - Might",             "Legs",     "Legplates of Might",            16867),
    S("T1 - Might",             "Feet",     "Sabatons of Might",             16862),
    S("T1 - Might",             "Waist",    "Belt of Might",                 16864),
    S("T1 - Might",             "Wrist",    "Bracers of Might",              16861),

    -- Classic T2: Battlegear of Wrath (BWL) — verified
    S("T2 - Wrath",             "Head",     "Helm of Wrath",                 16963),
    S("T2 - Wrath",             "Shoulder", "Pauldrons of Wrath",            16961),
    S("T2 - Wrath",             "Chest",    "Breastplate of Wrath",          16966),
    S("T2 - Wrath",             "Hands",    "Gauntlets of Wrath",            16964),
    S("T2 - Wrath",             "Legs",     "Legplates of Wrath",            16962),
    S("T2 - Wrath",             "Feet",     "Sabatons of Wrath",             16965),
    S("T2 - Wrath",             "Waist",    "Waistband of Wrath",            16960),
    S("T2 - Wrath",             "Wrist",    "Bracelets of Wrath",            16959),

    -- Classic T3: Dreadnaught's Battlegear (Naxx)
    S("T3 - Dreadnaught",       "Head",     "Dreadnaught Helmet",            22418),
    S("T3 - Dreadnaught",       "Shoulder", "Dreadnaught Pauldrons",         22419),
    S("T3 - Dreadnaught",       "Chest",    "Dreadnaught Breastplate",       22416),
    S("T3 - Dreadnaught",       "Hands",    "Dreadnaught Gauntlets",         22421),
    S("T3 - Dreadnaught",       "Legs",     "Dreadnaught Legplates",         22417),
    S("T3 - Dreadnaught",       "Feet",     "Dreadnaught Sabatons",          22420),
    S("T3 - Dreadnaught",       "Waist",    "Dreadnaught Waistguard",        22422),
    S("T3 - Dreadnaught",       "Wrist",    "Dreadnaught Bracers",           22423),

    -- TBC T4: Warbringer (Kara/Gruul/Mag)
    S("T4 - Warbringer",        "Head",     "Warbringer Battle-Helm",        29021),
    S("T4 - Warbringer",        "Shoulder", "Warbringer Shoulderplates",     29023),
    S("T4 - Warbringer",        "Chest",    "Warbringer Breastplate",        29019),
    S("T4 - Warbringer",        "Hands",    "Warbringer Gauntlets",          29020),
    S("T4 - Warbringer",        "Legs",     "Warbringer Greaves",            29022),

    -- TBC T5: Destroyer (SSC/TK)
    S("T5 - Destroyer",         "Head",     "Destroyer Battle-Helm",         30120),
    S("T5 - Destroyer",         "Shoulder", "Destroyer Shoulderblades",      30122),
    S("T5 - Destroyer",         "Chest",    "Destroyer Breastplate",         30118),
    S("T5 - Destroyer",         "Hands",    "Destroyer Gauntlets",           30119),
    S("T5 - Destroyer",         "Legs",     "Destroyer Greaves",             30121),

    -- TBC T6: Onslaught (Hyjal/BT/SWP)
    S("T6 - Onslaught",         "Head",     "Onslaught Battle-Helm",         30972),
    S("T6 - Onslaught",         "Shoulder", "Onslaught Shoulderblades",      30979),
    S("T6 - Onslaught",         "Chest",    "Onslaught Breastplate",         30975),
    S("T6 - Onslaught",         "Hands",    "Onslaught Gauntlets",           30969),
    S("T6 - Onslaught",         "Legs",     "Onslaught Greaves",             30977),
    S("T6 - Onslaught",         "Waist",    "Onslaught Belt",                34546),
    S("T6 - Onslaught",         "Wrist",    "Onslaught Bracers",             34441),
    S("T6 - Onslaught",         "Feet",     "Onslaught Treads",              34569),

    -- PvP S1: Gladiator's Battlegear [set 567] — AtlasLoot ItemSet.lua
    S("Gladiator's - Battlegear",    "Head",     "Gladiator's Battlegear Helm",       24546),
    S("Gladiator's - Battlegear",    "Shoulder", "Gladiator's Battlegear Spaulders",  24544),
    S("Gladiator's - Battlegear",    "Chest",    "Gladiator's Battlegear Breastplate",24545),
    S("Gladiator's - Battlegear",    "Hands",    "Gladiator's Battlegear Gauntlets",  24549),
    S("Gladiator's - Battlegear",    "Legs",     "Gladiator's Battlegear Legguards",  24547),

    -- PvP S2: Merciless Gladiator's Battlegear [set 701]
    S("Merciless - Battlegear",    "Head",     "Merciless Gladiator's Battlegear Helm",       30490),
    S("Merciless - Battlegear",    "Shoulder", "Merciless Gladiator's Battlegear Spaulders",  30486),
    S("Merciless - Battlegear",    "Chest",    "Merciless Gladiator's Battlegear Breastplate",30488),
    S("Merciless - Battlegear",    "Hands",    "Merciless Gladiator's Battlegear Gauntlets",  30487),
    S("Merciless - Battlegear",    "Legs",     "Merciless Gladiator's Battlegear Legguards",  30489),

    -- PvP S3: Vengeful Gladiator's Battlegear [set 736]
    S("Vengeful - Battlegear",    "Head",     "Vengeful Gladiator's Battlegear Helm",        33732),
    S("Vengeful - Battlegear",    "Shoulder", "Vengeful Gladiator's Battlegear Spaulders",   33728),
    S("Vengeful - Battlegear",    "Chest",    "Vengeful Gladiator's Battlegear Breastplate", 33730),
    S("Vengeful - Battlegear",    "Hands",    "Vengeful Gladiator's Battlegear Gauntlets",   33729),
    S("Vengeful - Battlegear",    "Legs",     "Vengeful Gladiator's Battlegear Legguards",   33731),

    -- PvP S4: Brutal Gladiator's Battlegear [set 2000567]
    S("Brutal - Battlegear",    "Head",     "Brutal Gladiator's Battlegear Helm",          35070),
    S("Brutal - Battlegear",    "Shoulder", "Brutal Gladiator's Battlegear Spaulders",     35066),
    S("Brutal - Battlegear",    "Chest",    "Brutal Gladiator's Battlegear Breastplate",   35068),
    S("Brutal - Battlegear",    "Hands",    "Brutal Gladiator's Battlegear Gauntlets",     35067),
    S("Brutal - Battlegear",    "Legs",     "Brutal Gladiator's Battlegear Legguards",     35069),
}

-- ============================================================
-- Utility functions
-- ============================================================
function WW:GetSets(class)
    local data = WW.DATA[class]
    if not data then return {} end
    local seen, sets = {}, {}
    for _, item in ipairs(data) do
        if not seen[item.set] then
            seen[item.set] = true
            table.insert(sets, item.set)
        end
    end
    return sets
end

function WW:GetSetItems(class, setName)
    local data = WW.DATA[class]
    if not data then return {} end
    local result = {}
    for _, item in ipairs(data) do
        if item.set == setName then table.insert(result, item) end
    end
    return result
end

WW.CLASS_ORDER = {
    "DRUID", "HUNTER", "MAGE", "PALADIN",
    "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR",
}

WW.CLASS_DISPLAY = {
    DRUID   = "Druid",   HUNTER  = "Hunter", MAGE    = "Mage",
    PALADIN = "Paladin", PRIEST  = "Priest", ROGUE   = "Rogue",
    SHAMAN  = "Shaman",  WARLOCK = "Warlock",WARRIOR = "Warrior",
}
