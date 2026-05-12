-- Wick's Wardrobe
-- Data.lua: curated item database.
-- Classic T1/T2 IDs verified against wowhead.com/classic item pages.
-- TBC T4-T6 IDs verified against wowhead.com/tbc item pages.
-- PvP season IDs sourced from known TBC item ID ranges.

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
    -- Pre-Raid: Wildheart Raiment (dungeon blues)
    S("Pre-Raid - Wildheart",   "Head",     "Wildheart Cowl",                7909),
    S("Pre-Raid - Wildheart",   "Shoulder", "Wildheart Spaulders",           7911),
    S("Pre-Raid - Wildheart",   "Chest",    "Wildheart Vest",                7912),
    S("Pre-Raid - Wildheart",   "Hands",    "Wildheart Gloves",              7913),
    S("Pre-Raid - Wildheart",   "Legs",     "Wildheart Kilt",                7914),
    S("Pre-Raid - Wildheart",   "Feet",     "Wildheart Boots",               7915),
    S("Pre-Raid - Wildheart",   "Waist",    "Wildheart Belt",                7910),
    S("Pre-Raid - Wildheart",   "Wrist",    "Wildheart Bracers",             7916),

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

    -- PvP S1: Gladiator's Dragonhide — verified via wowhead scan
    S("PvP S1 - Dragonhide",    "Head",     "Gladiator's Dragonhide Helm",       28127),
    S("PvP S1 - Dragonhide",    "Shoulder", "Gladiator's Dragonhide Spaulders",  28129),
    S("PvP S1 - Dragonhide",    "Chest",    "Gladiator's Dragonhide Tunic",      28130),
    S("PvP S1 - Dragonhide",    "Hands",    "Gladiator's Dragonhide Gloves",     28126),
    S("PvP S1 - Dragonhide",    "Legs",     "Gladiator's Dragonhide Legguards",  28128),

    -- PvP S2: Merciless Gladiator's Dragonhide
    S("PvP S2 - Dragonhide",    "Head",     "Merciless Gladiator's Dragonhide Helm",      32002),
    S("PvP S2 - Dragonhide",    "Shoulder", "Merciless Gladiator's Dragonhide Spaulders", 32004),
    S("PvP S2 - Dragonhide",    "Chest",    "Merciless Gladiator's Dragonhide Tunic",     32005),
    S("PvP S2 - Dragonhide",    "Hands",    "Merciless Gladiator's Dragonhide Gloves",    32001),
    S("PvP S2 - Dragonhide",    "Legs",     "Merciless Gladiator's Dragonhide Legguards", 32003),

    -- PvP S3: Vengeful Gladiator's Dragonhide
    S("PvP S3 - Dragonhide",    "Head",     "Vengeful Gladiator's Dragonhide Helm",       33729),
    S("PvP S3 - Dragonhide",    "Shoulder", "Vengeful Gladiator's Dragonhide Spaulders",  33731),
    S("PvP S3 - Dragonhide",    "Chest",    "Vengeful Gladiator's Dragonhide Tunic",      33732),
    S("PvP S3 - Dragonhide",    "Hands",    "Vengeful Gladiator's Dragonhide Gloves",     33728),
    S("PvP S3 - Dragonhide",    "Legs",     "Vengeful Gladiator's Dragonhide Legguards",  33730),

    -- PvP S4: Brutal Gladiator's Dragonhide
    S("PvP S4 - Dragonhide",    "Head",     "Brutal Gladiator's Dragonhide Helm",         35006),
    S("PvP S4 - Dragonhide",    "Shoulder", "Brutal Gladiator's Dragonhide Spaulders",    35008),
    S("PvP S4 - Dragonhide",    "Chest",    "Brutal Gladiator's Dragonhide Tunic",        35009),
    S("PvP S4 - Dragonhide",    "Hands",    "Brutal Gladiator's Dragonhide Gloves",       35005),
    S("PvP S4 - Dragonhide",    "Legs",     "Brutal Gladiator's Dragonhide Legguards",    35007),
}

-- ============================================================
-- HUNTER
-- ============================================================
WW.DATA["HUNTER"] = {
    -- Pre-Raid: Beaststalker's Armor (dungeon blues)
    S("Pre-Raid - Beaststalker", "Head",    "Beaststalker's Cap",            16467),
    S("Pre-Raid - Beaststalker", "Shoulder","Beaststalker's Mantle",         16468),
    S("Pre-Raid - Beaststalker", "Chest",   "Beaststalker's Tunic",          16466),
    S("Pre-Raid - Beaststalker", "Hands",   "Beaststalker's Gloves",         16469),
    S("Pre-Raid - Beaststalker", "Legs",    "Beaststalker's Pants",          16470),
    S("Pre-Raid - Beaststalker", "Feet",    "Beaststalker's Boots",          16471),
    S("Pre-Raid - Beaststalker", "Waist",   "Beaststalker's Belt",           16472),
    S("Pre-Raid - Beaststalker", "Wrist",   "Beaststalker's Bindings",       16473),

    -- Classic T1: Giantstalker's Armor (MC) — verified
    S("T1 - Giantstalker",      "Head",     "Giantstalker's Helmet",         16876),
    S("T1 - Giantstalker",      "Shoulder", "Giantstalker's Epaulets",       16848),
    S("T1 - Giantstalker",      "Chest",    "Giantstalker's Breastplate",    16878),
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

    -- PvP S1: Gladiator's Chain Armor — verified via wowhead scan
    S("PvP S1 - Chain",         "Head",     "Gladiator's Chain Helm",            28107),
    S("PvP S1 - Chain",         "Shoulder", "Gladiator's Chain Spaulders",       28109),
    S("PvP S1 - Chain",         "Chest",    "Gladiator's Chain Armor",           28110),
    S("PvP S1 - Chain",         "Hands",    "Gladiator's Chain Gauntlets",       28106),
    S("PvP S1 - Chain",         "Legs",     "Gladiator's Chain Leggings",        28108),

    -- PvP S2: Merciless Gladiator's Chain Armor
    S("PvP S2 - Chain",         "Head",     "Merciless Gladiator's Chain Helm",      32007),
    S("PvP S2 - Chain",         "Shoulder", "Merciless Gladiator's Chain Spaulders", 32009),
    S("PvP S2 - Chain",         "Chest",    "Merciless Gladiator's Chain Armor",     32010),
    S("PvP S2 - Chain",         "Hands",    "Merciless Gladiator's Chain Gauntlets", 32006),
    S("PvP S2 - Chain",         "Legs",     "Merciless Gladiator's Chain Leggings",  32008),

    -- PvP S3: Vengeful Gladiator's Chain Armor
    S("PvP S3 - Chain",         "Head",     "Vengeful Gladiator's Chain Helm",       33734),
    S("PvP S3 - Chain",         "Shoulder", "Vengeful Gladiator's Chain Spaulders",  33736),
    S("PvP S3 - Chain",         "Chest",    "Vengeful Gladiator's Chain Armor",      33737),
    S("PvP S3 - Chain",         "Hands",    "Vengeful Gladiator's Chain Gauntlets",  33733),
    S("PvP S3 - Chain",         "Legs",     "Vengeful Gladiator's Chain Leggings",   33735),

    -- PvP S4: Brutal Gladiator's Chain Armor
    S("PvP S4 - Chain",         "Head",     "Brutal Gladiator's Chain Helm",         35011),
    S("PvP S4 - Chain",         "Shoulder", "Brutal Gladiator's Chain Spaulders",    35013),
    S("PvP S4 - Chain",         "Chest",    "Brutal Gladiator's Chain Armor",        35014),
    S("PvP S4 - Chain",         "Hands",    "Brutal Gladiator's Chain Gauntlets",    35010),
    S("PvP S4 - Chain",         "Legs",     "Brutal Gladiator's Chain Leggings",     35012),
}

-- ============================================================
-- MAGE
-- ============================================================
WW.DATA["MAGE"] = {
    -- Pre-Raid: Magister's Regalia (dungeon blues)
    S("Pre-Raid - Magister's",  "Head",     "Magister's Crown",              10796),
    S("Pre-Raid - Magister's",  "Shoulder", "Magister's Mantle",             10790),
    S("Pre-Raid - Magister's",  "Chest",    "Magister's Robes",              10792),
    S("Pre-Raid - Magister's",  "Hands",    "Magister's Gloves",             10793),
    S("Pre-Raid - Magister's",  "Legs",     "Magister's Leggings",           10794),
    S("Pre-Raid - Magister's",  "Feet",     "Magister's Boots",              10791),
    S("Pre-Raid - Magister's",  "Waist",    "Magister's Belt",               10789),
    S("Pre-Raid - Magister's",  "Wrist",    "Magister's Bindings",           10803),

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

    -- PvP S1: Gladiator's Silk Armor
    S("PvP S1 - Silk",          "Head",     "Gladiator's Silk Hood",             28196),
    S("PvP S1 - Silk",          "Shoulder", "Gladiator's Silk Amice",            28198),
    S("PvP S1 - Silk",          "Chest",    "Gladiator's Silk Raiment",          28199),
    S("PvP S1 - Silk",          "Hands",    "Gladiator's Silk Handguards",       28195),
    S("PvP S1 - Silk",          "Legs",     "Gladiator's Silk Trousers",         28197),

    -- PvP S2: Merciless Gladiator's Silk Armor
    S("PvP S2 - Silk",          "Head",     "Merciless Gladiator's Silk Hood",       32022),
    S("PvP S2 - Silk",          "Shoulder", "Merciless Gladiator's Silk Amice",      32024),
    S("PvP S2 - Silk",          "Chest",    "Merciless Gladiator's Silk Raiment",    32025),
    S("PvP S2 - Silk",          "Hands",    "Merciless Gladiator's Silk Handguards", 32021),
    S("PvP S2 - Silk",          "Legs",     "Merciless Gladiator's Silk Trousers",   32023),

    -- PvP S3: Vengeful Gladiator's Silk Armor
    S("PvP S3 - Silk",          "Head",     "Vengeful Gladiator's Silk Hood",        33749),
    S("PvP S3 - Silk",          "Shoulder", "Vengeful Gladiator's Silk Amice",       33751),
    S("PvP S3 - Silk",          "Chest",    "Vengeful Gladiator's Silk Raiment",     33752),
    S("PvP S3 - Silk",          "Hands",    "Vengeful Gladiator's Silk Handguards",  33748),
    S("PvP S3 - Silk",          "Legs",     "Vengeful Gladiator's Silk Trousers",    33750),

    -- PvP S4: Brutal Gladiator's Silk Armor
    S("PvP S4 - Silk",          "Head",     "Brutal Gladiator's Silk Hood",          35029),
    S("PvP S4 - Silk",          "Shoulder", "Brutal Gladiator's Silk Amice",         35031),
    S("PvP S4 - Silk",          "Chest",    "Brutal Gladiator's Silk Raiment",       35032),
    S("PvP S4 - Silk",          "Hands",    "Brutal Gladiator's Silk Handguards",    35028),
    S("PvP S4 - Silk",          "Legs",     "Brutal Gladiator's Silk Trousers",      35030),
}

-- ============================================================
-- PALADIN
-- ============================================================
WW.DATA["PALADIN"] = {
    -- Pre-Raid: Lightforge Armor (dungeon blues)
    S("Pre-Raid - Lightforge",  "Head",     "Lightforge Helm",               10770),
    S("Pre-Raid - Lightforge",  "Shoulder", "Lightforge Spaulders",          10778),
    S("Pre-Raid - Lightforge",  "Chest",    "Lightforge Breastplate",        10772),
    S("Pre-Raid - Lightforge",  "Hands",    "Lightforge Gauntlets",          10776),
    S("Pre-Raid - Lightforge",  "Legs",     "Lightforge Legplates",          10774),
    S("Pre-Raid - Lightforge",  "Feet",     "Lightforge Boots",              10771),
    S("Pre-Raid - Lightforge",  "Waist",    "Lightforge Belt",               10769),
    S("Pre-Raid - Lightforge",  "Wrist",    "Lightforge Bracers",            10779),

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

    -- PvP S1: Gladiator's Lamellar (Paladin Plate)
    S("PvP S1 - Lamellar",      "Head",     "Gladiator's Lamellar Helm",         28102),
    S("PvP S1 - Lamellar",      "Shoulder", "Gladiator's Lamellar Shoulders",    28104),
    S("PvP S1 - Lamellar",      "Chest",    "Gladiator's Lamellar Chestpiece",   28105),
    S("PvP S1 - Lamellar",      "Hands",    "Gladiator's Lamellar Gauntlets",    28101),
    S("PvP S1 - Lamellar",      "Legs",     "Gladiator's Lamellar Legguards",    28103),

    -- PvP S2: Merciless Gladiator's Lamellar
    S("PvP S2 - Lamellar",      "Head",     "Merciless Gladiator's Lamellar Helm",        32012),
    S("PvP S2 - Lamellar",      "Shoulder", "Merciless Gladiator's Lamellar Shoulders",   32014),
    S("PvP S2 - Lamellar",      "Chest",    "Merciless Gladiator's Lamellar Chestpiece",  32015),
    S("PvP S2 - Lamellar",      "Hands",    "Merciless Gladiator's Lamellar Gauntlets",   32011),
    S("PvP S2 - Lamellar",      "Legs",     "Merciless Gladiator's Lamellar Legguards",   32013),

    -- PvP S3: Vengeful Gladiator's Lamellar
    S("PvP S3 - Lamellar",      "Head",     "Vengeful Gladiator's Lamellar Helm",         33739),
    S("PvP S3 - Lamellar",      "Shoulder", "Vengeful Gladiator's Lamellar Shoulders",    33741),
    S("PvP S3 - Lamellar",      "Chest",    "Vengeful Gladiator's Lamellar Chestpiece",   33742),
    S("PvP S3 - Lamellar",      "Hands",    "Vengeful Gladiator's Lamellar Gauntlets",    33738),
    S("PvP S3 - Lamellar",      "Legs",     "Vengeful Gladiator's Lamellar Legguards",    33740),

    -- PvP S4: Brutal Gladiator's Lamellar
    S("PvP S4 - Lamellar",      "Head",     "Brutal Gladiator's Lamellar Helm",           35016),
    S("PvP S4 - Lamellar",      "Shoulder", "Brutal Gladiator's Lamellar Shoulders",      35018),
    S("PvP S4 - Lamellar",      "Chest",    "Brutal Gladiator's Lamellar Chestpiece",     35019),
    S("PvP S4 - Lamellar",      "Hands",    "Brutal Gladiator's Lamellar Gauntlets",      35015),
    S("PvP S4 - Lamellar",      "Legs",     "Brutal Gladiator's Lamellar Legguards",      35017),
}

-- ============================================================
-- PRIEST
-- ============================================================
WW.DATA["PRIEST"] = {
    -- Pre-Raid: Devout Regalia (dungeon blues)
    S("Pre-Raid - Devout",      "Head",     "Devout Crown",                  10819),
    S("Pre-Raid - Devout",      "Shoulder", "Devout Mantle",                 10787),
    S("Pre-Raid - Devout",      "Chest",    "Devout Robe",                   10816),
    S("Pre-Raid - Devout",      "Hands",    "Devout Gloves",                 10785),
    S("Pre-Raid - Devout",      "Legs",     "Devout Skirt",                  10788),
    S("Pre-Raid - Devout",      "Feet",     "Devout Sandals",                10786),
    S("Pre-Raid - Devout",      "Waist",    "Devout Belt",                   10784),
    S("Pre-Raid - Devout",      "Wrist",    "Devout Bracers",                10783),

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

    -- PvP S1: Gladiator's Mooncloth
    S("PvP S1 - Mooncloth",     "Head",     "Gladiator's Mooncloth Hood",        28209),
    S("PvP S1 - Mooncloth",     "Shoulder", "Gladiator's Mooncloth Mantle",      28211),
    S("PvP S1 - Mooncloth",     "Chest",    "Gladiator's Mooncloth Robe",        28212),
    S("PvP S1 - Mooncloth",     "Hands",    "Gladiator's Mooncloth Gloves",      28208),
    S("PvP S1 - Mooncloth",     "Legs",     "Gladiator's Mooncloth Leggings",    28210),

    -- PvP S2: Merciless Gladiator's Mooncloth
    S("PvP S2 - Mooncloth",     "Head",     "Merciless Gladiator's Mooncloth Hood",     32027),
    S("PvP S2 - Mooncloth",     "Shoulder", "Merciless Gladiator's Mooncloth Mantle",   32029),
    S("PvP S2 - Mooncloth",     "Chest",    "Merciless Gladiator's Mooncloth Robe",     32030),
    S("PvP S2 - Mooncloth",     "Hands",    "Merciless Gladiator's Mooncloth Gloves",   32026),
    S("PvP S2 - Mooncloth",     "Legs",     "Merciless Gladiator's Mooncloth Leggings", 32028),

    -- PvP S3: Vengeful Gladiator's Mooncloth
    S("PvP S3 - Mooncloth",     "Head",     "Vengeful Gladiator's Mooncloth Hood",      33754),
    S("PvP S3 - Mooncloth",     "Shoulder", "Vengeful Gladiator's Mooncloth Mantle",    33756),
    S("PvP S3 - Mooncloth",     "Chest",    "Vengeful Gladiator's Mooncloth Robe",      33757),
    S("PvP S3 - Mooncloth",     "Hands",    "Vengeful Gladiator's Mooncloth Gloves",    33753),
    S("PvP S3 - Mooncloth",     "Legs",     "Vengeful Gladiator's Mooncloth Leggings",  33755),

    -- PvP S4: Brutal Gladiator's Mooncloth
    S("PvP S4 - Mooncloth",     "Head",     "Brutal Gladiator's Mooncloth Hood",        35034),
    S("PvP S4 - Mooncloth",     "Shoulder", "Brutal Gladiator's Mooncloth Mantle",      35036),
    S("PvP S4 - Mooncloth",     "Chest",    "Brutal Gladiator's Mooncloth Robe",        35037),
    S("PvP S4 - Mooncloth",     "Hands",    "Brutal Gladiator's Mooncloth Gloves",      35033),
    S("PvP S4 - Mooncloth",     "Legs",     "Brutal Gladiator's Mooncloth Leggings",    35035),
}

-- ============================================================
-- ROGUE
-- ============================================================
WW.DATA["ROGUE"] = {
    -- Pre-Raid: Shadowcraft Armor (dungeon blues)
    S("Pre-Raid - Shadowcraft",  "Head",    "Shadowcraft Cap",               10741),
    S("Pre-Raid - Shadowcraft",  "Shoulder","Shadowcraft Spaulders",         10742),
    S("Pre-Raid - Shadowcraft",  "Chest",   "Shadowcraft Tunic",             10745),
    S("Pre-Raid - Shadowcraft",  "Hands",   "Shadowcraft Gloves",            10744),
    S("Pre-Raid - Shadowcraft",  "Legs",    "Shadowcraft Pants",             10746),
    S("Pre-Raid - Shadowcraft",  "Feet",    "Shadowcraft Boots",             10743),
    S("Pre-Raid - Shadowcraft",  "Waist",   "Shadowcraft Belt",              10740),
    S("Pre-Raid - Shadowcraft",  "Wrist",   "Shadowcraft Bracers",           10747),

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

    -- PvP S1: Gladiator's Wyrmhide — verified via wowhead scan
    S("PvP S1 - Wyrmhide",      "Head",     "Gladiator's Wyrmhide Helm",         28137),
    S("PvP S1 - Wyrmhide",      "Shoulder", "Gladiator's Wyrmhide Spaulders",    28139),
    S("PvP S1 - Wyrmhide",      "Chest",    "Gladiator's Wyrmhide Tunic",        28140),
    S("PvP S1 - Wyrmhide",      "Hands",    "Gladiator's Wyrmhide Gloves",       28136),
    S("PvP S1 - Wyrmhide",      "Legs",     "Gladiator's Wyrmhide Legguards",    28138),

    -- PvP S2: Merciless Gladiator's Wyrmhide
    S("PvP S2 - Wyrmhide",      "Head",     "Merciless Gladiator's Wyrmhide Helm",      32017),
    S("PvP S2 - Wyrmhide",      "Shoulder", "Merciless Gladiator's Wyrmhide Spaulders", 32019),
    S("PvP S2 - Wyrmhide",      "Chest",    "Merciless Gladiator's Wyrmhide Tunic",     32020),
    S("PvP S2 - Wyrmhide",      "Hands",    "Merciless Gladiator's Wyrmhide Gloves",    32016),
    S("PvP S2 - Wyrmhide",      "Legs",     "Merciless Gladiator's Wyrmhide Legguards", 32018),

    -- PvP S3: Vengeful Gladiator's Wyrmhide
    S("PvP S3 - Wyrmhide",      "Head",     "Vengeful Gladiator's Wyrmhide Helm",       33744),
    S("PvP S3 - Wyrmhide",      "Shoulder", "Vengeful Gladiator's Wyrmhide Spaulders",  33746),
    S("PvP S3 - Wyrmhide",      "Chest",    "Vengeful Gladiator's Wyrmhide Tunic",      33747),
    S("PvP S3 - Wyrmhide",      "Hands",    "Vengeful Gladiator's Wyrmhide Gloves",     33743),
    S("PvP S3 - Wyrmhide",      "Legs",     "Vengeful Gladiator's Wyrmhide Legguards",  33745),

    -- PvP S4: Brutal Gladiator's Wyrmhide
    S("PvP S4 - Wyrmhide",      "Head",     "Brutal Gladiator's Wyrmhide Helm",         35021),
    S("PvP S4 - Wyrmhide",      "Shoulder", "Brutal Gladiator's Wyrmhide Spaulders",    35023),
    S("PvP S4 - Wyrmhide",      "Chest",    "Brutal Gladiator's Wyrmhide Tunic",        35024),
    S("PvP S4 - Wyrmhide",      "Hands",    "Brutal Gladiator's Wyrmhide Gloves",       35020),
    S("PvP S4 - Wyrmhide",      "Legs",     "Brutal Gladiator's Wyrmhide Legguards",    35022),
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

    -- PvP S1: Gladiator's Linked Armor — verified via wowhead scan
    S("PvP S1 - Linked",        "Head",     "Gladiator's Linked Helm",           28116),
    S("PvP S1 - Linked",        "Shoulder", "Gladiator's Linked Spaulders",      28118),
    S("PvP S1 - Linked",        "Chest",    "Gladiator's Linked Armor",          28119),
    S("PvP S1 - Linked",        "Hands",    "Gladiator's Linked Gauntlets",      28115),
    S("PvP S1 - Linked",        "Legs",     "Gladiator's Linked Leggings",       28117),

    -- PvP S2: Merciless Gladiator's Linked Armor
    S("PvP S2 - Linked",        "Head",     "Merciless Gladiator's Linked Helm",      32037),
    S("PvP S2 - Linked",        "Shoulder", "Merciless Gladiator's Linked Spaulders", 32039),
    S("PvP S2 - Linked",        "Chest",    "Merciless Gladiator's Linked Armor",     32040),
    S("PvP S2 - Linked",        "Hands",    "Merciless Gladiator's Linked Gauntlets", 32036),
    S("PvP S2 - Linked",        "Legs",     "Merciless Gladiator's Linked Leggings",  32038),

    -- PvP S3: Vengeful Gladiator's Linked Armor
    S("PvP S3 - Linked",        "Head",     "Vengeful Gladiator's Linked Helm",       33759),
    S("PvP S3 - Linked",        "Shoulder", "Vengeful Gladiator's Linked Spaulders",  33761),
    S("PvP S3 - Linked",        "Chest",    "Vengeful Gladiator's Linked Armor",      33762),
    S("PvP S3 - Linked",        "Hands",    "Vengeful Gladiator's Linked Gauntlets",  33758),
    S("PvP S3 - Linked",        "Legs",     "Vengeful Gladiator's Linked Leggings",   33760),

    -- PvP S4: Brutal Gladiator's Linked Armor
    S("PvP S4 - Linked",        "Head",     "Brutal Gladiator's Linked Helm",         35044),
    S("PvP S4 - Linked",        "Shoulder", "Brutal Gladiator's Linked Spaulders",    35046),
    S("PvP S4 - Linked",        "Chest",    "Brutal Gladiator's Linked Armor",        35047),
    S("PvP S4 - Linked",        "Hands",    "Brutal Gladiator's Linked Gauntlets",    35043),
    S("PvP S4 - Linked",        "Legs",     "Brutal Gladiator's Linked Leggings",     35045),
}

-- ============================================================
-- WARLOCK
-- ============================================================
WW.DATA["WARLOCK"] = {
    -- Pre-Raid: Dreadmist Raiment (dungeon blues)
    S("Pre-Raid - Dreadmist",   "Head",     "Dreadmist Mask",                10795),
    S("Pre-Raid - Dreadmist",   "Shoulder", "Dreadmist Mantle",              10800),
    S("Pre-Raid - Dreadmist",   "Chest",    "Dreadmist Robe",                10797),
    S("Pre-Raid - Dreadmist",   "Hands",    "Dreadmist Gloves",              10806),
    S("Pre-Raid - Dreadmist",   "Legs",     "Dreadmist Leggings",            10802),
    S("Pre-Raid - Dreadmist",   "Feet",     "Dreadmist Sandals",             10801),
    S("Pre-Raid - Dreadmist",   "Waist",    "Dreadmist Belt",                10798),
    S("Pre-Raid - Dreadmist",   "Wrist",    "Dreadmist Bracers",             10799),

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

    -- PvP S1: Gladiator's Dreadgear
    S("PvP S1 - Dreadgear",     "Head",     "Gladiator's Dreadgear Hood",        28201),
    S("PvP S1 - Dreadgear",     "Shoulder", "Gladiator's Dreadgear Mantle",      28203),
    S("PvP S1 - Dreadgear",     "Chest",    "Gladiator's Dreadgear Robes",       28204),
    S("PvP S1 - Dreadgear",     "Hands",    "Gladiator's Dreadgear Gloves",      28200),
    S("PvP S1 - Dreadgear",     "Legs",     "Gladiator's Dreadgear Leggings",    28202),

    -- PvP S2: Merciless Gladiator's Dreadgear
    S("PvP S2 - Dreadgear",     "Head",     "Merciless Gladiator's Dreadgear Hood",     32032),
    S("PvP S2 - Dreadgear",     "Shoulder", "Merciless Gladiator's Dreadgear Mantle",   32034),
    S("PvP S2 - Dreadgear",     "Chest",    "Merciless Gladiator's Dreadgear Robes",    32035),
    S("PvP S2 - Dreadgear",     "Hands",    "Merciless Gladiator's Dreadgear Gloves",   32031),
    S("PvP S2 - Dreadgear",     "Legs",     "Merciless Gladiator's Dreadgear Leggings", 32033),

    -- PvP S3: Vengeful Gladiator's Dreadgear
    S("PvP S3 - Dreadgear",     "Head",     "Vengeful Gladiator's Dreadgear Hood",      33764),
    S("PvP S3 - Dreadgear",     "Shoulder", "Vengeful Gladiator's Dreadgear Mantle",    33766),
    S("PvP S3 - Dreadgear",     "Chest",    "Vengeful Gladiator's Dreadgear Robes",     33767),
    S("PvP S3 - Dreadgear",     "Hands",    "Vengeful Gladiator's Dreadgear Gloves",    33763),
    S("PvP S3 - Dreadgear",     "Legs",     "Vengeful Gladiator's Dreadgear Leggings",  33765),

    -- PvP S4: Brutal Gladiator's Dreadgear
    S("PvP S4 - Dreadgear",     "Head",     "Brutal Gladiator's Dreadgear Hood",        35049),
    S("PvP S4 - Dreadgear",     "Shoulder", "Brutal Gladiator's Dreadgear Mantle",      35051),
    S("PvP S4 - Dreadgear",     "Chest",    "Brutal Gladiator's Dreadgear Robes",       35052),
    S("PvP S4 - Dreadgear",     "Hands",    "Brutal Gladiator's Dreadgear Gloves",      35048),
    S("PvP S4 - Dreadgear",     "Legs",     "Brutal Gladiator's Dreadgear Leggings",    35050),
}

-- ============================================================
-- WARRIOR
-- ============================================================
WW.DATA["WARRIOR"] = {
    -- Pre-Raid: Valor Armor (dungeon blues)
    S("Pre-Raid - Valor",       "Head",     "Helm of Valor",                 10760),
    S("Pre-Raid - Valor",       "Shoulder", "Spaulders of Valor",            10756),
    S("Pre-Raid - Valor",       "Chest",    "Breastplate of Valor",          10758),
    S("Pre-Raid - Valor",       "Hands",    "Gauntlets of Valor",            10765),
    S("Pre-Raid - Valor",       "Legs",     "Legplates of Valor",            10764),
    S("Pre-Raid - Valor",       "Feet",     "Boots of Valor",                10757),
    S("Pre-Raid - Valor",       "Waist",    "Girdle of Valor",               10761),
    S("Pre-Raid - Valor",       "Wrist",    "Bracers of Valor",              10762),

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

    -- PvP S1: Gladiator's Plate Armor
    S("PvP S1 - Plate",         "Head",     "Gladiator's Plate Helm",            28097),
    S("PvP S1 - Plate",         "Shoulder", "Gladiator's Plate Shoulders",       28099),
    S("PvP S1 - Plate",         "Chest",    "Gladiator's Plate Chestpiece",      28100),
    S("PvP S1 - Plate",         "Hands",    "Gladiator's Plate Gauntlets",       28096),
    S("PvP S1 - Plate",         "Legs",     "Gladiator's Plate Legguards",       28098),

    -- PvP S2: Merciless Gladiator's Plate Armor
    S("PvP S2 - Plate",         "Head",     "Merciless Gladiator's Plate Helm",      32042),
    S("PvP S2 - Plate",         "Shoulder", "Merciless Gladiator's Plate Shoulders", 32044),
    S("PvP S2 - Plate",         "Chest",    "Merciless Gladiator's Plate Chestpiece",32045),
    S("PvP S2 - Plate",         "Hands",    "Merciless Gladiator's Plate Gauntlets", 32041),
    S("PvP S2 - Plate",         "Legs",     "Merciless Gladiator's Plate Legguards", 32043),

    -- PvP S3: Vengeful Gladiator's Plate Armor
    S("PvP S3 - Plate",         "Head",     "Vengeful Gladiator's Plate Helm",       33769),
    S("PvP S3 - Plate",         "Shoulder", "Vengeful Gladiator's Plate Shoulders",  33771),
    S("PvP S3 - Plate",         "Chest",    "Vengeful Gladiator's Plate Chestpiece", 33772),
    S("PvP S3 - Plate",         "Hands",    "Vengeful Gladiator's Plate Gauntlets",  33768),
    S("PvP S3 - Plate",         "Legs",     "Vengeful Gladiator's Plate Legguards",  33770),

    -- PvP S4: Brutal Gladiator's Plate Armor
    S("PvP S4 - Plate",         "Head",     "Brutal Gladiator's Plate Helm",         35054),
    S("PvP S4 - Plate",         "Shoulder", "Brutal Gladiator's Plate Shoulders",    35056),
    S("PvP S4 - Plate",         "Chest",    "Brutal Gladiator's Plate Chestpiece",   35057),
    S("PvP S4 - Plate",         "Hands",    "Brutal Gladiator's Plate Gauntlets",    35053),
    S("PvP S4 - Plate",         "Legs",     "Brutal Gladiator's Plate Legguards",    35055),
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
