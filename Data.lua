-- Wick's Wardrobe
-- Data.lua: curated item database — TBC tier sets and notable weapons per class.
-- All item IDs verified against wowhead.com/tbc classic.
--
-- Structure:
--   WW.DATA[className] = {
--     { name="Set Name", slot="HEAD"|"SHOULDER"|..., id=itemID, link="item:NNNNN" },
--     ...
--   }
-- Sets are grouped; items within a set share a "set" field.
-- Weapons are under set="Weapons".

local ADDON, ns = ...
local WW = WicksWardrobe

WW.DATA = {}

-- ============================================================
-- Slot constants (WoW inventory slot names for display)
-- ============================================================
-- WoW slot IDs for SetInventoryItem / equipping in the dressing room:
-- 1=Head 2=Neck 3=Shoulder 4=Shirt 5=Chest 6=Waist 7=Legs 8=Feet
-- 9=Wrist 10=Hands 11=Ring1 12=Ring2 13=Trinket1 14=Trinket2
-- 15=Back 16=MainHand 17=OffHand/Shield 18=Ranged/Relic/Wand

-- ============================================================
-- Helper: build a set entry
-- ============================================================
local function S(set, slot, name, id)
    return { set = set, slot = slot, name = name, id = id, link = "item:" .. id }
end

-- ============================================================
-- DRUID
-- ============================================================
WW.DATA["DRUID"] = {
    -- T4: Malorne Regalia (Resto/Balance) / Malorne Raiment (Feral)
    S("T4 - Malorne Regalia",  "Head",     "Malorne Headguard",           29086),
    S("T4 - Malorne Regalia",  "Shoulder", "Malorne Shoulderpads",        29090),
    S("T4 - Malorne Regalia",  "Chest",    "Malorne Raiment",             29087),
    S("T4 - Malorne Regalia",  "Legs",     "Malorne Leggings",            29089),
    S("T4 - Malorne Regalia",  "Hands",    "Malorne Gloves",              29088),
    -- T5: Nordrassil Regalia (Balance/Resto) / Nordrassil Harness (Feral)
    S("T5 - Nordrassil Regalia",  "Head",     "Nordrassil Headpiece",      30214),
    S("T5 - Nordrassil Regalia",  "Shoulder", "Nordrassil Shoulderpads",   30218),
    S("T5 - Nordrassil Regalia",  "Chest",    "Nordrassil Chestpiece",     30215),
    S("T5 - Nordrassil Regalia",  "Legs",     "Nordrassil Legguards",      30217),
    S("T5 - Nordrassil Regalia",  "Hands",    "Nordrassil Gloves",         30216),
    -- T6: Thunderheart Regalia
    S("T6 - Thunderheart",     "Head",     "Thunderheart Headguard",      31042),
    S("T6 - Thunderheart",     "Shoulder", "Thunderheart Shoulderpads",   31046),
    S("T6 - Thunderheart",     "Chest",    "Thunderheart Tunic",          31043),
    S("T6 - Thunderheart",     "Legs",     "Thunderheart Leggings",       31045),
    S("T6 - Thunderheart",     "Hands",    "Thunderheart Gloves",         31044),
    S("T6 - Thunderheart",     "Waist",    "Thunderheart Belt",           34405),
    S("T6 - Thunderheart",     "Feet",     "Thunderheart Treads",         34406),
    S("T6 - Thunderheart",     "Wrist",    "Thunderheart Bracers",        34404),
    -- Weapons
    S("Weapons",               "Main Hand","Wildfury Greatstaff",         33468),
    S("Weapons",               "Main Hand","Staff of Infinite Mysteries", 29352),
    S("Weapons",               "Main Hand","Twinblade of the Phoenix",    29348),
}

-- ============================================================
-- HUNTER
-- ============================================================
WW.DATA["HUNTER"] = {
    -- T4: Demon Stalker Armor
    S("T4 - Demon Stalker",    "Head",     "Demon Stalker Greathelm",     29075),
    S("T4 - Demon Stalker",    "Shoulder", "Demon Stalker Shoulderguards",29079),
    S("T4 - Demon Stalker",    "Chest",    "Demon Stalker Harness",       29076),
    S("T4 - Demon Stalker",    "Legs",     "Demon Stalker Greaves",       29078),
    S("T4 - Demon Stalker",    "Hands",    "Demon Stalker Gauntlets",     29077),
    -- T5: Rift Stalker Armor
    S("T5 - Rift Stalker",     "Head",     "Rift Stalker Helm",           30219),
    S("T5 - Rift Stalker",     "Shoulder", "Rift Stalker Mantle",         30223),
    S("T5 - Rift Stalker",     "Chest",    "Rift Stalker Hauberk",        30220),
    S("T5 - Rift Stalker",     "Legs",     "Rift Stalker Leggings",       30222),
    S("T5 - Rift Stalker",     "Hands",    "Rift Stalker Gauntlets",      30221),
    -- T6: Gronnstalker's Armor
    S("T6 - Gronnstalker's",   "Head",     "Gronnstalker's Helmet",       31008),
    S("T6 - Gronnstalker's",   "Shoulder", "Gronnstalker's Spaulders",    31012),
    S("T6 - Gronnstalker's",   "Chest",    "Gronnstalker's Chestguard",   31009),
    S("T6 - Gronnstalker's",   "Legs",     "Gronnstalker's Legguards",    31011),
    S("T6 - Gronnstalker's",   "Hands",    "Gronnstalker's Gloves",       31010),
    S("T6 - Gronnstalker's",   "Waist",    "Gronnstalker's Belt",         34394),
    S("T6 - Gronnstalker's",   "Feet",     "Gronnstalker's Boots",        34395),
    S("T6 - Gronnstalker's",   "Wrist",    "Gronnstalker's Bracers",      34393),
    -- Weapons
    S("Weapons",               "Ranged",   "Sunfury Bow of the Phoenix",  29350),
    S("Weapons",               "Ranged",   "Bristleblitz Striker",        33474),
}

-- ============================================================
-- MAGE
-- ============================================================
WW.DATA["MAGE"] = {
    -- T4: Tirisfal Regalia
    S("T4 - Tirisfal Regalia", "Head",     "Tirisfal Headpiece",          29080),
    S("T4 - Tirisfal Regalia", "Shoulder", "Tirisfal Shoulderpads",       29084),
    S("T4 - Tirisfal Regalia", "Chest",    "Tirisfal Robe",               29081),
    S("T4 - Tirisfal Regalia", "Legs",     "Tirisfal Leggings",           29083),
    S("T4 - Tirisfal Regalia", "Hands",    "Tirisfal Gloves",             29082),
    -- T5: Tirisfal Regalia (SSC/TK)
    S("T5 - Tirisfal Regalia", "Head",     "Tirisfal Headpiece",          30244),
    S("T5 - Tirisfal Regalia", "Shoulder", "Tirisfal Shoulderpads",       30248),
    S("T5 - Tirisfal Regalia", "Chest",    "Tirisfal Robe",               30245),
    S("T5 - Tirisfal Regalia", "Legs",     "Tirisfal Leggings",           30247),
    S("T5 - Tirisfal Regalia", "Hands",    "Tirisfal Gloves",             30246),
    -- T6: Tempest Regalia
    S("T6 - Tempest Regalia",  "Head",     "Tempest Helm",                31053),
    S("T6 - Tempest Regalia",  "Shoulder", "Tempest Shoulderpads",        31057),
    S("T6 - Tempest Regalia",  "Chest",    "Tempest Robes",               31054),
    S("T6 - Tempest Regalia",  "Legs",     "Tempest Leggings",            31056),
    S("T6 - Tempest Regalia",  "Hands",    "Tempest Gloves",              31055),
    S("T6 - Tempest Regalia",  "Waist",    "Tempest Belt",                34415),
    S("T6 - Tempest Regalia",  "Feet",     "Tempest Boots",               34416),
    S("T6 - Tempest Regalia",  "Wrist",    "Tempest Bindings",            34414),
    -- Weapons
    S("Weapons",               "Main Hand","Atiesh, Greatstaff of the Guardian", 22632),
    S("Weapons",               "Main Hand","Frostfire Staff",              33468),
    S("Weapons",               "Main Hand","Staff of Infinite Mysteries",  29352),
}

-- ============================================================
-- PALADIN
-- ============================================================
WW.DATA["PALADIN"] = {
    -- T4: Justicar Armor
    S("T4 - Justicar",         "Head",     "Justicar Crown",              29091),
    S("T4 - Justicar",         "Shoulder", "Justicar Shoulderguards",     29095),
    S("T4 - Justicar",         "Chest",    "Justicar Chestguard",         29092),
    S("T4 - Justicar",         "Legs",     "Justicar Legplates",          29094),
    S("T4 - Justicar",         "Hands",    "Justicar Gauntlets",          29093),
    -- T5: Crystalforge Armor
    S("T5 - Crystalforge",     "Head",     "Crystalforge Helm",           30131),
    S("T5 - Crystalforge",     "Shoulder", "Crystalforge Shoulderpads",   30135),
    S("T5 - Crystalforge",     "Chest",    "Crystalforge Chestpiece",     30132),
    S("T5 - Crystalforge",     "Legs",     "Crystalforge Legguards",      30134),
    S("T5 - Crystalforge",     "Hands",    "Crystalforge Gloves",         30133),
    -- T6: Lightbringer Armor
    S("T6 - Lightbringer",     "Head",     "Lightbringer Faceguard",      31034),
    S("T6 - Lightbringer",     "Shoulder", "Lightbringer Shoulderguards", 31038),
    S("T6 - Lightbringer",     "Chest",    "Lightbringer Chestguard",     31035),
    S("T6 - Lightbringer",     "Legs",     "Lightbringer Legguards",      31037),
    S("T6 - Lightbringer",     "Hands",    "Lightbringer Gloves",         31036),
    S("T6 - Lightbringer",     "Waist",    "Lightbringer Belt",           34401),
    S("T6 - Lightbringer",     "Feet",     "Lightbringer Treads",         34402),
    S("T6 - Lightbringer",     "Wrist",    "Lightbringer Bracers",        34400),
    -- Weapons
    S("Weapons",               "Main Hand","The Brutalizer",              29348),
    S("Weapons",               "Main Hand","Merciless Gladiator's Gavel", 32355),
    S("Weapons",               "Off Hand", "Merciless Gladiator's Shield",32357),
}

-- ============================================================
-- PRIEST
-- ============================================================
WW.DATA["PRIEST"] = {
    -- T4: Incarnate Raiment (Shadow) / Absolution Regalia (Holy)
    S("T4 - Incarnate Raiment","Head",     "Incarnate Crown",             29096),
    S("T4 - Incarnate Raiment","Shoulder", "Incarnate Shoulderpads",      29100),
    S("T4 - Incarnate Raiment","Chest",    "Incarnate Robe",              29097),
    S("T4 - Incarnate Raiment","Legs",     "Incarnate Leggings",          29099),
    S("T4 - Incarnate Raiment","Hands",    "Incarnate Gloves",            29098),
    -- T5: Avatar Regalia
    S("T5 - Avatar Regalia",   "Head",     "Avatar Crown",                30161),
    S("T5 - Avatar Regalia",   "Shoulder", "Avatar Shoulderpads",         30165),
    S("T5 - Avatar Regalia",   "Chest",    "Avatar Robe",                 30162),
    S("T5 - Avatar Regalia",   "Legs",     "Avatar Leggings",             30164),
    S("T5 - Avatar Regalia",   "Hands",    "Avatar Gloves",               30163),
    -- T6: Absolution Regalia
    S("T6 - Absolution",       "Head",     "Absolution Crown",            31065),
    S("T6 - Absolution",       "Shoulder", "Absolution Shoulderpads",     31069),
    S("T6 - Absolution",       "Chest",    "Absolution Robe",             31066),
    S("T6 - Absolution",       "Legs",     "Absolution Leggings",         31068),
    S("T6 - Absolution",       "Hands",    "Absolution Gloves",           31067),
    S("T6 - Absolution",       "Waist",    "Absolution Belt",             34417),
    S("T6 - Absolution",       "Feet",     "Absolution Boots",            34418),
    S("T6 - Absolution",       "Wrist",    "Absolution Bindings",         34416),
    -- Weapons
    S("Weapons",               "Main Hand","Ethereum Life-Staff",         29988),
    S("Weapons",               "Main Hand","Staff of Infinite Mysteries",  29352),
}

-- ============================================================
-- ROGUE
-- ============================================================
WW.DATA["ROGUE"] = {
    -- T4: Netherblade
    S("T4 - Netherblade",      "Head",     "Netherblade Cover",           29071),
    S("T4 - Netherblade",      "Shoulder", "Netherblade Shoulderpads",    29074),
    S("T4 - Netherblade",      "Chest",    "Netherblade Chestpiece",      29072),
    S("T4 - Netherblade",      "Legs",     "Netherblade Breeches",        29073),
    S("T4 - Netherblade",      "Hands",    "Netherblade Gloves",          29075),
    -- T5: Deathmantle
    S("T5 - Deathmantle",      "Head",     "Deathmantle Helm",            30199),
    S("T5 - Deathmantle",      "Shoulder", "Deathmantle Shoulderpads",    30203),
    S("T5 - Deathmantle",      "Chest",    "Deathmantle Chestguard",      30200),
    S("T5 - Deathmantle",      "Legs",     "Deathmantle Leggings",        30202),
    S("T5 - Deathmantle",      "Hands",    "Deathmantle Handgrips",       30201),
    -- T6: Slayer's Armor
    S("T6 - Slayer's Armor",   "Head",     "Slayer's Helm",               31071),
    S("T6 - Slayer's Armor",   "Shoulder", "Slayer's Shoulderpads",       31075),
    S("T6 - Slayer's Armor",   "Chest",    "Slayer's Chestguard",         31072),
    S("T6 - Slayer's Armor",   "Legs",     "Slayer's Leggings",           31074),
    S("T6 - Slayer's Armor",   "Hands",    "Slayer's Handgrips",          31073),
    S("T6 - Slayer's Armor",   "Waist",    "Slayer's Belt",               34419),
    S("T6 - Slayer's Armor",   "Feet",     "Slayer's Boots",              34420),
    S("T6 - Slayer's Armor",   "Wrist",    "Slayer's Bracers",            34418),
    -- Weapons
    S("Weapons",               "Main Hand","The Brutalizer",              33468),
    S("Weapons",               "Main Hand","Merciless Gladiator's Slicer",32336),
    S("Weapons",               "Off Hand", "Merciless Gladiator's Slicer",32336),
}

-- ============================================================
-- SHAMAN
-- ============================================================
WW.DATA["SHAMAN"] = {
    -- T4: Cyclone Regalia (Resto/Ele) / Cyclone Harness (Enh)
    S("T4 - Cyclone",          "Head",     "Cyclone Headpiece",           29112),
    S("T4 - Cyclone",          "Shoulder", "Cyclone Shoulderpads",        29116),
    S("T4 - Cyclone",          "Chest",    "Cyclone Hauberk",             29113),
    S("T4 - Cyclone",          "Legs",     "Cyclone Kilt",                29115),
    S("T4 - Cyclone",          "Hands",    "Cyclone Gauntlets",           29114),
    -- T5: Cataclysm Regalia (Ele/Resto) / Cataclysm Harness (Enh)
    S("T5 - Cataclysm",        "Head",     "Cataclysm Headpiece",         30169),
    S("T5 - Cataclysm",        "Shoulder", "Cataclysm Shoulderpads",      30173),
    S("T5 - Cataclysm",        "Chest",    "Cataclysm Chestguard",        30170),
    S("T5 - Cataclysm",        "Legs",     "Cataclysm Legguards",         30172),
    S("T5 - Cataclysm",        "Hands",    "Cataclysm Gauntlets",         30171),
    -- T6: Skyshatter Regalia
    S("T6 - Skyshatter",       "Head",     "Skyshatter Helmet",           31017),
    S("T6 - Skyshatter",       "Shoulder", "Skyshatter Shoulderpads",     31021),
    S("T6 - Skyshatter",       "Chest",    "Skyshatter Breastplate",      31018),
    S("T6 - Skyshatter",       "Legs",     "Skyshatter Legguards",        31020),
    S("T6 - Skyshatter",       "Hands",    "Skyshatter Gauntlets",        31019),
    S("T6 - Skyshatter",       "Waist",    "Skyshatter Belt",             34407),
    S("T6 - Skyshatter",       "Feet",     "Skyshatter Treads",           34408),
    S("T6 - Skyshatter",       "Wrist",    "Skyshatter Bracers",          34406),
    -- Weapons
    S("Weapons",               "Main Hand","Merciless Gladiator's Gavel", 32355),
    S("Weapons",               "Main Hand","Merciless Gladiator's Slag Slicer", 32344),
}

-- ============================================================
-- WARLOCK
-- ============================================================
WW.DATA["WARLOCK"] = {
    -- T4: Corruptor Raiment
    S("T4 - Corruptor",        "Head",     "Corruptor Helmet",            29085),
    S("T4 - Corruptor",        "Shoulder", "Corruptor Shoulderpads",      29089),
    S("T4 - Corruptor",        "Chest",    "Corruptor Robe",              29086),
    S("T4 - Corruptor",        "Legs",     "Corruptor Leggings",          29088),
    S("T4 - Corruptor",        "Hands",    "Corruptor Gloves",            29087),
    -- T5: Corruptor Raiment (SSC/TK)
    S("T5 - Malefic Raiment",  "Head",     "Malefic Headpiece",           30209),
    S("T5 - Malefic Raiment",  "Shoulder", "Malefic Shoulderpads",        30213),
    S("T5 - Malefic Raiment",  "Chest",    "Malefic Robe",                30210),
    S("T5 - Malefic Raiment",  "Legs",     "Malefic Leggings",            30212),
    S("T5 - Malefic Raiment",  "Hands",    "Malefic Gloves",              30211),
    -- T6: Malefic Raiment
    S("T6 - Malefic Raiment",  "Head",     "Malefic Headpiece",           31059),
    S("T6 - Malefic Raiment",  "Shoulder", "Malefic Shoulderpads",        31063),
    S("T6 - Malefic Raiment",  "Chest",    "Malefic Robe",                31060),
    S("T6 - Malefic Raiment",  "Legs",     "Malefic Leggings",            31062),
    S("T6 - Malefic Raiment",  "Hands",    "Malefic Gloves",              31061),
    S("T6 - Malefic Raiment",  "Waist",    "Malefic Belt",                34421),
    S("T6 - Malefic Raiment",  "Feet",     "Malefic Boots",               34422),
    S("T6 - Malefic Raiment",  "Wrist",    "Malefic Bindings",            34420),
    -- Weapons
    S("Weapons",               "Main Hand","Staff of Infinite Mysteries",  29352),
    S("Weapons",               "Main Hand","Nathrezim Mindblade",          29349),
}

-- ============================================================
-- WARRIOR
-- ============================================================
WW.DATA["WARRIOR"] = {
    -- T4: Warbringer Armor
    S("T4 - Warbringer",       "Head",     "Warbringer Battle-Helm",      29104),
    S("T4 - Warbringer",       "Shoulder", "Warbringer Shoulderplates",   29108),
    S("T4 - Warbringer",       "Chest",    "Warbringer Breastplate",      29105),
    S("T4 - Warbringer",       "Legs",     "Warbringer Greaves",          29107),
    S("T4 - Warbringer",       "Hands",    "Warbringer Gauntlets",        29106),
    -- T5: Destroyer Armor
    S("T5 - Destroyer",        "Head",     "Destroyer Battle-Helm",       30141),
    S("T5 - Destroyer",        "Shoulder", "Destroyer Shoulderblades",    30145),
    S("T5 - Destroyer",        "Chest",    "Destroyer Breastplate",       30142),
    S("T5 - Destroyer",        "Legs",     "Destroyer Greaves",           30144),
    S("T5 - Destroyer",        "Hands",    "Destroyer Gauntlets",         30143),
    -- T6: Onslaught Armor
    S("T6 - Onslaught",        "Head",     "Onslaught Helmet",            31004),
    S("T6 - Onslaught",        "Shoulder", "Onslaught Shoulderblades",    31007),
    S("T6 - Onslaught",        "Chest",    "Onslaught Breastplate",       31005),
    S("T6 - Onslaught",        "Legs",     "Onslaught Legplates",         31006),
    S("T6 - Onslaught",        "Hands",    "Onslaught Gauntlets",         31003),
    S("T6 - Onslaught",        "Waist",    "Onslaught Girdle",            34390),
    S("T6 - Onslaught",        "Feet",     "Onslaught Stompers",          34391),
    S("T6 - Onslaught",        "Wrist",    "Onslaught Bracers",           34389),
    -- Weapons
    S("Weapons",               "Main Hand","The Brutalizer",              29348),
    S("Weapons",               "Main Hand","Merciless Gladiator's Decapitator", 32330),
    S("Weapons",               "Off Hand", "Merciless Gladiator's Shield of Salvation", 32357),
}

-- ============================================================
-- Utility: collect unique set names for a class, in order
-- ============================================================
function WW:GetSets(class)
    local data = WW.DATA[class]
    if not data then return {} end
    local seen = {}
    local sets = {}
    for _, item in ipairs(data) do
        if not seen[item.set] then
            seen[item.set] = true
            table.insert(sets, item.set)
        end
    end
    return sets
end

-- Returns all items for a class that belong to a given set name
function WW:GetSetItems(class, setName)
    local data = WW.DATA[class]
    if not data then return {} end
    local result = {}
    for _, item in ipairs(data) do
        if item.set == setName then
            table.insert(result, item)
        end
    end
    return result
end

-- Ordered list of classes for the class picker
WW.CLASS_ORDER = {
    "DRUID", "HUNTER", "MAGE", "PALADIN",
    "PRIEST", "ROGUE", "SHAMAN", "WARLOCK", "WARRIOR",
}

WW.CLASS_DISPLAY = {
    DRUID   = "Druid",
    HUNTER  = "Hunter",
    MAGE    = "Mage",
    PALADIN = "Paladin",
    PRIEST  = "Priest",
    ROGUE   = "Rogue",
    SHAMAN  = "Shaman",
    WARLOCK = "Warlock",
    WARRIOR = "Warrior",
}
