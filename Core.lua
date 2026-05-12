-- Wick's Wardrobe
-- Core.lua: namespace, saved variables, event dispatch, slash command.

local ADDON, ns = ...

-- TBC Anniversary 2.5.5 namespaced API shims
ns.IsAddOnLoaded    = (C_AddOns and C_AddOns.IsAddOnLoaded)    or IsAddOnLoaded
ns.GetAddOnMetadata = (C_AddOns and C_AddOns.GetAddOnMetadata) or GetAddOnMetadata

-- ============================================================
-- Saved variables
-- ============================================================
WicksWardrobeDB = WicksWardrobeDB or {}

local DB_DEFAULTS = {
    ui = {
        hidden   = true,
        width    = 620,
        height   = 480,
    },
    pos = { posPoint = false, posRel = false, posX = 0, posY = 0 },
    minimap = {
        hide     = false,
        position = 225,
    },
    lastClass  = nil,
    lastSetIdx = nil,
    outfits    = {},   -- saved named outfits: { name=string, items={slot=itemLink} }
}

local function applyDefaults(target, defaults)
    for k, v in pairs(defaults) do
        if type(v) == "table" then
            if type(target[k]) ~= "table" then target[k] = {} end
            applyDefaults(target[k], v)
        elseif target[k] == nil then
            target[k] = v
        end
    end
end

-- ============================================================
-- Namespace / global
-- ============================================================
WicksWardrobe = WicksWardrobe or {}
local WW = WicksWardrobe
ns.WW = WW
WW.ADDON = ADDON
WW.db    = WicksWardrobeDB  -- placeholder; rebound on ADDON_LOADED

-- Internal pub/sub
WW._listeners = {}
function WW:On(event, fn)
    self._listeners[event] = self._listeners[event] or {}
    table.insert(self._listeners[event], fn)
end
function WW:Emit(event, ...)
    local list = self._listeners[event]
    if not list then return end
    for _, fn in ipairs(list) do
        local ok, err = pcall(fn, ...)
        if not ok then
            print(("|cff4FC778Wick's Wardrobe|r error in %s: %s"):format(event, tostring(err)))
        end
    end
end

-- ============================================================
-- WoW event frame
-- ============================================================
local f = CreateFrame("Frame")
WW.eventFrame = f

local EVENTS = {
    "ADDON_LOADED",
    "PLAYER_LOGIN",
    "PLAYER_LOGOUT",
}
for _, e in ipairs(EVENTS) do
    pcall(f.RegisterEvent, f, e)
end

f:SetScript("OnEvent", function(self, event, ...)
    if event == "ADDON_LOADED" then
        local arg1 = ...
        if arg1 == ADDON then
            WicksWardrobeDB = WicksWardrobeDB or {}
            applyDefaults(WicksWardrobeDB, DB_DEFAULTS)
            WW.db = WicksWardrobeDB
        end
    elseif event == "PLAYER_LOGIN" then
        WW:Emit("LOGIN")
        print("|cff4FC778Wick's Wardrobe|r loaded. /wwd to toggle.")
    elseif event == "PLAYER_LOGOUT" then
        if WW.UI and WW.UI.SnapPosition then WW.UI:SnapPosition() end
    end
    WW:Emit(event, ...)
end)

-- ============================================================
-- Slash command
-- ============================================================
SLASH_WICKSWARDROBE1 = "/wwd"
SLASH_WICKSWARDROBE2 = "/wardrobe"
SlashCmdList.WICKSWARDROBE = function(input)
    input = (input or ""):gsub("^%s*(.-)%s*$", "%1"):lower()
    if input == "" or input == "toggle" then
        if WW.UI and WW.UI.Toggle then WW.UI:Toggle() end
        return
    end
    if input == "show"  and WW.UI then WW.UI:Show()  return end
    if input == "hide"  and WW.UI then WW.UI:Hide()  return end
    if input == "reset" and WW.UI then WW.UI:Reset()  return end
    if input == "help" or input == "?" then
        print("|cff4FC778Wick's Wardrobe|r")
        print("  /wwd           toggle the panel")
        print("  /wwd show      open")
        print("  /wwd hide      close")
        print("  /wwd reset     reset position and size")
        return
    end
    print("|cff4FC778Wick's Wardrobe|r: unknown command. Try /wwd help")
end
