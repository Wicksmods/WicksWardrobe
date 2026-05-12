-- Wick's Wardrobe
-- UI.lua: brand chrome helpers + main panel (item list, inline model, bottom dropdown bar).

local ADDON, ns = ...
local WW = WicksWardrobe

WW.UI = {}
local UI = WW.UI

-- ============================================================
-- Brand palette (locked tokens)
-- ============================================================
UI.C_BG          = { 0.051, 0.039, 0.078, 0.97 }
UI.C_HEADER_BG   = { 0.090, 0.067, 0.141, 1    }
UI.C_BORDER      = { 0.220, 0.188, 0.345, 1    }
UI.C_GREEN       = { 0.310, 0.780, 0.471, 1    }
UI.C_TEXT_DIM    = { 0.42,  0.35,  0.54,  1    }
UI.C_TEXT_NORMAL = { 0.831, 0.784, 0.631, 1    }

function UI:SetRGBA(tex, c)
    tex:SetColorTexture(c[1], c[2], c[3], c[4] or 1)
end

function UI:NewTexture(parent, layer, c)
    local t = parent:CreateTexture(nil, layer or "BACKGROUND")
    if c then self:SetRGBA(t, c) end
    return t
end

function UI:NewText(parent, size, c)
    local fs = parent:CreateFontString(nil, "OVERLAY")
    fs:SetFont("Fonts\\FRIZQT__.TTF", size or 11, "")
    if c then fs:SetTextColor(c[1], c[2], c[3], c[4] or 1) end
    return fs
end

function UI:AddBorder(frame, c)
    c = c or self.C_BORDER
    local function edge(p1, p2, w, h)
        local t = frame:CreateTexture(nil, "BORDER")
        t:SetColorTexture(c[1], c[2], c[3], c[4] or 1)
        t:SetPoint(p1); t:SetPoint(p2)
        if w then t:SetWidth(w) end
        if h then t:SetHeight(h) end
    end
    edge("TOPLEFT",    "TOPRIGHT",    nil, 1)
    edge("BOTTOMLEFT", "BOTTOMRIGHT", nil, 1)
    edge("TOPLEFT",    "BOTTOMLEFT",  1,   nil)
    edge("TOPRIGHT",   "BOTTOMRIGHT", 1,   nil)
end

function UI:AddCornerAccents(frame, arm, thick)
    arm   = arm   or 10
    thick = thick or 2
    local g = self.C_GREEN
    local function brk(anchor)
        local h = frame:CreateTexture(nil, "OVERLAY")
        h:SetColorTexture(g[1], g[2], g[3], 1)
        h:SetPoint(anchor); h:SetSize(arm, thick)
        local v = frame:CreateTexture(nil, "OVERLAY")
        v:SetColorTexture(g[1], g[2], g[3], 1)
        v:SetPoint(anchor); v:SetSize(thick, arm)
    end
    brk("TOPLEFT"); brk("TOPRIGHT"); brk("BOTTOMLEFT"); brk("BOTTOMRIGHT")
end

-- Two-tone "Wick's Wardrobe" header
function UI:AddTitleText(parent)
    local off = self.C_TEXT_NORMAL
    local g   = self.C_GREEN
    local left = parent:CreateFontString(nil, "OVERLAY")
    left:SetFont("Fonts\\FRIZQT__.TTF", 13, "")
    left:SetTextColor(off[1], off[2], off[3], 1)
    left:SetPoint("LEFT", parent, "LEFT", 10, 0)
    left:SetText("Wick's")
    local right = parent:CreateFontString(nil, "OVERLAY")
    right:SetFont("Fonts\\FRIZQT__.TTF", 13, "")
    right:SetTextColor(g[1], g[2], g[3], 1)
    right:SetPoint("LEFT", left, "RIGHT", 4, 0)
    right:SetText("Wardrobe")
    return left, right
end

-- ============================================================
-- BIS Tracker spec map (title-case class -> ordered spec list)
-- Matches WTBT_Data keys exactly.
-- ============================================================
local CLASS_SPECS = {
    Druid   = { "Balance", "Feral", "Restoration" },
    Hunter  = { "Beast Mastery", "Marksmanship", "Survival" },
    Mage    = { "Arcane", "Fire", "Frost" },
    Paladin = { "Holy", "Protection", "Retribution" },
    Priest  = { "Holy", "Shadow" },
    Rogue   = { "Assassination", "Combat" },
    Shaman  = { "Elemental", "Enhancement", "Restoration" },
    Warlock = { "Affliction", "Demonology", "Destruction" },
    Warrior = { "Arms", "Fury", "Protection" },
}

-- ============================================================
-- Panel dimensions
-- ============================================================
local MIN_W      = 500
local MIN_H      = 380
local HEADER_H   = 26
local ITEM_W     = 160   -- item list column width
local BOT_BAR_H  = 32   -- bottom dropdown + control strip

-- ============================================================
-- Scroll list helper
-- ============================================================
local function MakeScrollList(parent, w, h, rowH)
    local clip = CreateFrame("Frame", nil, parent)
    clip:SetSize(w, h)
    clip:SetClipsChildren(true)

    local content = CreateFrame("Frame", nil, clip)
    content:SetSize(w, h)
    content:SetPoint("TOPLEFT")

    local scrollY = 0
    local totalH  = 0

    local function setScroll(y)
        totalH = content:GetHeight()
        y = math.max(0, math.min(y, math.max(0, totalH - h)))
        scrollY = y
        content:SetPoint("TOPLEFT", clip, "TOPLEFT", 0, scrollY)
    end

    clip:EnableMouseWheel(true)
    clip:SetScript("OnMouseWheel", function(self, delta)
        setScroll(scrollY - delta * rowH)
    end)

    content.setScroll   = setScroll
    content.resetScroll = function() setScroll(0) end
    content.clip = clip
    return content
end

-- ============================================================
-- Dropdown helper: creates a compact dropdown button + popup list
-- Returns the button frame; button.setValue(val, label) updates the display.
-- onChange(value) called when user selects an entry.
-- entries: array of { value, label }
-- ============================================================
local function MakeDropdown(parent, w, h, entries, onChange)
    local btn = CreateFrame("Button", nil, parent)
    btn:SetSize(w, h)
    local bg = parent:CreateTexture(nil, "BACKGROUND")  -- placeholder; set on btn below
    local btnBg = btn:CreateTexture(nil, "BACKGROUND")
    btnBg:SetAllPoints()
    btnBg:SetColorTexture(UI.C_HEADER_BG[1], UI.C_HEADER_BG[2], UI.C_HEADER_BG[3], 1)
    UI:AddBorder(btn)

    local lbl = btn:CreateFontString(nil, "OVERLAY")
    lbl:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
    lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
    lbl:SetPoint("LEFT", btn, "LEFT", 5, 0)
    lbl:SetPoint("RIGHT", btn, "RIGHT", -12, 0)
    lbl:SetJustifyH("LEFT")

    -- Arrow glyph
    local arrow = btn:CreateFontString(nil, "OVERLAY")
    arrow:SetFont("Fonts\\FRIZQT__.TTF", 8, "")
    arrow:SetTextColor(UI.C_TEXT_DIM[1], UI.C_TEXT_DIM[2], UI.C_TEXT_DIM[3], 1)
    arrow:SetPoint("RIGHT", btn, "RIGHT", -3, 0)
    arrow:SetText("v")

    -- Popup list
    local popup = CreateFrame("Frame", nil, UIParent)
    popup:SetFrameStrata("TOOLTIP")
    popup:SetWidth(w)
    popup:Hide()
    local popupBg = popup:CreateTexture(nil, "BACKGROUND")
    popupBg:SetAllPoints()
    popupBg:SetColorTexture(UI.C_BG[1], UI.C_BG[2], UI.C_BG[3], 0.98)
    UI:AddBorder(popup)

    local rowH   = 18
    local popupRows = {}

    local function rebuildPopup(ents)
        for _, r in ipairs(popupRows) do r:Hide() end
        wipe(popupRows)
        local yOff = -2
        for _, e in ipairs(ents) do
            local row = CreateFrame("Button", nil, popup)
            row:SetSize(w - 4, rowH)
            row:SetPoint("TOPLEFT", popup, "TOPLEFT", 2, yOff)
            yOff = yOff - rowH
            local rlbl = row:CreateFontString(nil, "OVERLAY")
            rlbl:SetFont("Fonts\\FRIZQT__.TTF", 10, "")
            rlbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
            rlbl:SetPoint("LEFT", row, "LEFT", 4, 0)
            rlbl:SetText(e.label)
            row:SetScript("OnEnter", function()
                rlbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
            end)
            row:SetScript("OnLeave", function()
                rlbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
            end)
            local val = e.value
            local elab = e.label
            row:SetScript("OnClick", function()
                lbl:SetText(elab)
                popup:Hide()
                onChange(val)
            end)
            table.insert(popupRows, row)
        end
        popup:SetHeight(math.max(20, -yOff + 2))
    end

    rebuildPopup(entries)

    btn:SetScript("OnClick", function()
        if popup:IsShown() then
            popup:Hide()
            return
        end
        popup:ClearAllPoints()
        popup:SetPoint("BOTTOMLEFT", btn, "TOPLEFT", 0, 2)
        popup:Show()
    end)

    btn:SetScript("OnEnter", function()
        lbl:SetTextColor(1, 1, 1, 1)
        arrow:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
    end)
    btn:SetScript("OnLeave", function()
        lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
        arrow:SetTextColor(UI.C_TEXT_DIM[1], UI.C_TEXT_DIM[2], UI.C_TEXT_DIM[3], 1)
    end)

    function btn.setValue(val, label)
        lbl:SetText(label or val or "")
    end

    function btn.setEntries(ents)
        rebuildPopup(ents)
    end

    -- click-catcher to close popup
    local catcher = CreateFrame("Frame", nil, UIParent)
    catcher:SetAllPoints(UIParent)
    catcher:SetFrameStrata("TOOLTIP")
    catcher:SetFrameLevel(popup:GetFrameLevel() - 1)
    catcher:EnableMouse(true)
    catcher:Hide()
    catcher:SetScript("OnMouseDown", function()
        popup:Hide()
        catcher:Hide()
    end)
    popup:HookScript("OnShow", function() catcher:Show() end)
    popup:HookScript("OnHide", function() catcher:Hide() end)

    return btn
end

-- ============================================================
-- Visible slot filter — only slots that render on DressUpModel
-- ============================================================
local SLOT_DISPLAY_ORDER = {
    "Head","Shoulder","Back","Chest","Hands","Legs","Feet",
    "MainHand","OffHand","Ranged","Relic","Idol","Totem","Libram",
}
local SLOT_VISIBLE = {}
for _, s in ipairs(SLOT_DISPLAY_ORDER) do SLOT_VISIBLE[s] = true end

-- ============================================================
-- Build the main panel (lazy, called once on first show)
-- ============================================================
local panel

local function buildPanel()
    if panel then return end

    local db = WW.db
    local W  = (db.ui.width  or 580)
    local H  = (db.ui.height or 460)

    panel = CreateFrame("Frame", "WicksWardrobePanel", UIParent, "BackdropTemplate")
    tinsert(UISpecialFrames, "WicksWardrobePanel")
    panel:SetFrameStrata("HIGH")
    panel:SetFrameLevel(100)
    panel:SetSize(W, H)
    panel:SetClampedToScreen(true)
    panel:SetMovable(true)
    panel:SetResizable(true)
    panel:EnableMouse(true)

    -- Background
    local bg = UI:NewTexture(panel, "BACKGROUND", UI.C_BG)
    bg:SetAllPoints()

    -- Border (on panel)
    UI:AddBorder(panel)

    -- --------------------------------------------------------
    -- Header strip
    -- --------------------------------------------------------
    local header = CreateFrame("Frame", nil, panel)
    header:SetPoint("TOPLEFT",  panel, "TOPLEFT",  0, 0)
    header:SetPoint("TOPRIGHT", panel, "TOPRIGHT", 0, 0)
    header:SetHeight(HEADER_H)
    local hbg = UI:NewTexture(header, "BACKGROUND", UI.C_HEADER_BG)
    hbg:SetAllPoints()
    UI:AddTitleText(header)

    -- L-brackets
    local arm, thick = 10, 2
    local g = UI.C_GREEN
    local function brk(parent, anchor)
        local h = parent:CreateTexture(nil, "OVERLAY")
        h:SetColorTexture(g[1], g[2], g[3], 1)
        h:SetPoint(anchor); h:SetSize(arm, thick)
        local v = parent:CreateTexture(nil, "OVERLAY")
        v:SetColorTexture(g[1], g[2], g[3], 1)
        v:SetPoint(anchor); v:SetSize(thick, arm)
    end
    brk(header, "TOPLEFT")
    brk(header, "TOPRIGHT")

    -- Close button
    local closeBtn = CreateFrame("Button", nil, header)
    closeBtn:SetSize(20, 20)
    closeBtn:SetPoint("RIGHT", header, "RIGHT", -6, 0)
    local closeText = header:CreateFontString(nil, "OVERLAY")
    closeText:SetFont("Fonts\\FRIZQT__.TTF", 14, "")
    closeText:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
    closeText:SetPoint("CENTER", closeBtn, "CENTER")
    closeText:SetText("×")
    closeBtn:SetScript("OnClick", function() panel:Hide() end)
    closeBtn:SetScript("OnEnter", function()
        closeText:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
    end)
    closeBtn:SetScript("OnLeave", function()
        closeText:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
    end)

    -- Drag on header
    local pos = db.pos
    local function snapPosition()
        local p, _, rp, x, y = panel:GetPoint()
        pos.posPoint = p
        pos.posRel   = rp or p
        pos.posX     = x or 0
        pos.posY     = y or 0
    end
    panel._snapPosition = snapPosition

    header:EnableMouse(true)
    header:SetScript("OnMouseDown", function(self, btn)
        if btn == "LeftButton" then panel:StartMoving() end
    end)
    header:SetScript("OnMouseUp", function()
        panel:StopMovingOrSizing()
        snapPosition()
    end)

    -- --------------------------------------------------------
    -- Body area (between header and bottom bar)
    -- --------------------------------------------------------
    local bodyFrame = CreateFrame("Frame", nil, panel)
    bodyFrame:SetPoint("TOPLEFT",     panel, "TOPLEFT",     0, -HEADER_H)
    bodyFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, BOT_BAR_H)

    -- Vertical divider: items | model
    local divItems = UI:NewTexture(bodyFrame, "BORDER", UI.C_BORDER)
    divItems:SetWidth(1)
    divItems:SetPoint("TOPLEFT",    bodyFrame, "TOPLEFT",    ITEM_W, 0)
    divItems:SetPoint("BOTTOMLEFT", bodyFrame, "BOTTOMLEFT", ITEM_W, 0)

    -- --------------------------------------------------------
    -- Item list column (left)
    -- --------------------------------------------------------
    local itemLabel = UI:NewText(bodyFrame, 10, UI.C_TEXT_DIM)
    itemLabel:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 8, -6)
    itemLabel:SetText("ITEMS")

    -- Bottom button row inside item column
    local BTN_H   = 20
    local BTN_PAD = 4
    local BTN_W   = math.floor((ITEM_W - 12 - BTN_PAD) / 2)

    local previewAllBtn = CreateFrame("Button", nil, bodyFrame)
    previewAllBtn:SetSize(BTN_W, BTN_H)
    previewAllBtn:SetPoint("BOTTOMLEFT", bodyFrame, "BOTTOMLEFT", 6, 4)
    local pabg = UI:NewTexture(previewAllBtn, "BACKGROUND", UI.C_HEADER_BG)
    pabg:SetAllPoints()
    UI:AddBorder(previewAllBtn)
    local paLbl = UI:NewText(previewAllBtn, 10, UI.C_TEXT_NORMAL)
    paLbl:SetPoint("CENTER")
    paLbl:SetText("Preview Set")
    previewAllBtn:SetScript("OnEnter", function()
        paLbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
    end)
    previewAllBtn:SetScript("OnLeave", function()
        paLbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
    end)

    local model = nil  -- assigned after DressUpModel created

    -- "From BIS" button
    local bisBtn = CreateFrame("Button", nil, bodyFrame)
    bisBtn:SetSize(BTN_W, BTN_H)
    bisBtn:SetPoint("BOTTOMLEFT", previewAllBtn, "BOTTOMRIGHT", BTN_PAD, 0)
    local bisbg = UI:NewTexture(bisBtn, "BACKGROUND", UI.C_HEADER_BG)
    bisbg:SetAllPoints()
    UI:AddBorder(bisBtn)
    local bisLbl = UI:NewText(bisBtn, 10, UI.C_TEXT_NORMAL)
    bisLbl:SetPoint("CENTER")
    bisLbl:SetText("From BIS")
    bisBtn:SetScript("OnEnter", function()
        bisLbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
    end)
    bisBtn:SetScript("OnLeave", function()
        bisLbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
    end)

    -- BIS import popup
    local bisPopup = CreateFrame("Frame", "WicksWardrobeBISPopup", UIParent)
    bisPopup:SetFrameStrata("DIALOG")
    bisPopup:SetWidth(180)
    bisPopup:Hide()
    local bisPopupBg = UI:NewTexture(bisPopup, "BACKGROUND", UI.C_BG)
    bisPopupBg:SetAllPoints()
    UI:AddBorder(bisPopup)
    UI:AddCornerAccents(bisPopup, 6, 1)

    local bisPopupTitle = UI:NewText(bisPopup, 9, UI.C_TEXT_DIM)
    bisPopupTitle:SetPoint("TOPLEFT", bisPopup, "TOPLEFT", 6, -4)
    bisPopupTitle:SetText("BIS TRACKER SETS")

    local function previewBISItems(slotTable)
        if not model then return end
        model:Undress()
        for slotKey, entry in pairs(slotTable) do
            if SLOT_VISIBLE[slotKey] then
                local itemId
                if type(entry) == "table" then
                    if entry.itemId then
                        itemId = entry.itemId
                    elseif type(entry[1]) == "table" and entry[1].itemId then
                        itemId = entry[1].itemId
                    end
                end
                if itemId then
                    local link = ("|Hitem:%d:0:0:0:0:0:0:0|h[item:%d]|h"):format(itemId, itemId)
                    model:TryOn(link)
                end
            end
        end
    end

    local selectedClass = db.lastClass or "MAGE"
    local selectedSpec  = "Feral"
    local selectedSet   = nil

    local bisPopupRows = {}
    local function buildBISPopup(cls, spec)
        for _, r in ipairs(bisPopupRows) do r:Hide() end
        wipe(bisPopupRows)
        local entries = {}
        if WTBTCustomLists and WTBTCustomLists[cls] and WTBTCustomLists[cls][spec] then
            for name, slotData in pairs(WTBTCustomLists[cls][spec]) do
                table.insert(entries, { label = name, data = slotData })
            end
        end
        if WTBT_Data and WTBT_Data[cls] and WTBT_Data[cls][spec] then
            local phases = {}
            for phaseName in pairs(WTBT_Data[cls][spec]) do
                table.insert(phases, phaseName)
            end
            table.sort(phases)
            for _, phaseName in ipairs(phases) do
                table.insert(entries, {
                    label = "BIS: " .. phaseName,
                    data  = WTBT_Data[cls][spec][phaseName],
                    isBIS = true,
                })
            end
        end
        if #entries == 0 then
            table.insert(entries, { label = "(no BIS data)", data = nil })
        end
        local rowH  = 18
        local yOff  = -16
        for _, entry in ipairs(entries) do
            local row = CreateFrame("Button", nil, bisPopup)
            row:SetSize(168, rowH)
            row:SetPoint("TOPLEFT", bisPopup, "TOPLEFT", 6, yOff)
            yOff = yOff - rowH - 2
            local lbl = UI:NewText(row, 10, UI.C_TEXT_NORMAL)
            lbl:SetPoint("LEFT", row, "LEFT", 4, 0)
            lbl:SetText(entry.label)
            if entry.data then
                row:SetScript("OnClick", function()
                    if entry.isBIS then
                        local flat = {}
                        for slotKey, items in pairs(entry.data) do
                            if type(items) == "table" and items[1] then
                                flat[slotKey] = { itemId = items[1].itemId }
                            end
                        end
                        previewBISItems(flat)
                    else
                        previewBISItems(entry.data)
                    end
                    bisPopup:Hide()
                end)
                row:SetScript("OnEnter", function()
                    lbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
                end)
                row:SetScript("OnLeave", function()
                    lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
                end)
            else
                lbl:SetTextColor(UI.C_TEXT_DIM[1], UI.C_TEXT_DIM[2], UI.C_TEXT_DIM[3], 1)
            end
            table.insert(bisPopupRows, row)
        end
        local totalH = -yOff + 4
        bisPopup:SetHeight(totalH)
    end

    bisBtn:SetScript("OnClick", function()
        if bisPopup:IsShown() then bisPopup:Hide(); return end
        local cls = selectedClass:sub(1,1):upper() .. selectedClass:sub(2):lower()
        buildBISPopup(cls, selectedSpec)
        bisPopup:ClearAllPoints()
        bisPopup:SetPoint("BOTTOMLEFT", bisBtn, "TOPLEFT", 0, 2)
        bisPopup:Show()
    end)

    local bisCatcher = CreateFrame("Frame", nil, UIParent)
    bisCatcher:SetAllPoints(UIParent)
    bisCatcher:SetFrameStrata("DIALOG")
    bisCatcher:EnableMouse(true)
    bisCatcher:Hide()
    bisCatcher:SetScript("OnMouseDown", function()
        bisPopup:Hide()
        bisCatcher:Hide()
    end)
    bisPopup:HookScript("OnShow", function() bisCatcher:Show() end)
    bisPopup:HookScript("OnHide", function() bisCatcher:Hide() end)
    bisPopup:SetFrameLevel(bisCatcher:GetFrameLevel() + 1)

    panel._previewBISItems = previewBISItems

    local ITEM_ROW_H        = 38
    local ITEM_LIST_BOT_PAD = 28
    local bodyH = H - HEADER_H - BOT_BAR_H
    local itemListH = bodyH - 20 - ITEM_LIST_BOT_PAD
    local itemScrollContent = MakeScrollList(bodyFrame, ITEM_W - 4, itemListH, ITEM_ROW_H)
    itemScrollContent.clip:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 2, -18)

    local itemRows   = {}
    local itemContent = {}

    -- Shared row builder — accepts any array of {id, name, slot, link}
    local function buildItemRows(items)
        for _, row in ipairs(itemRows) do row:Hide() end
        wipe(itemRows)
        local ROW_H = ITEM_ROW_H - 2
        local ICO_S = 32
        itemScrollContent:SetHeight(math.max(80, #items * ITEM_ROW_H + 4))
        itemScrollContent:resetScroll()
        for i, item in ipairs(items) do
            local row = CreateFrame("Button", nil, itemScrollContent)
            row:SetSize(ITEM_W - 8, ROW_H)
            row:SetPoint("TOPLEFT", itemScrollContent, "TOPLEFT", 2, -(i - 1) * ITEM_ROW_H - 2)
            row.previewing = false

            local hoverBg = UI:NewTexture(row, "BACKGROUND", { 0.18, 0.13, 0.28, 0 })
            hoverBg:SetAllPoints()
            row.hoverBg = hoverBg

            local iconFrame = CreateFrame("Frame", nil, row)
            iconFrame:SetSize(ICO_S, ICO_S)
            iconFrame:SetPoint("LEFT", row, "LEFT", 2, 0)
            local iconTex = iconFrame:CreateTexture(nil, "ARTWORK")
            iconTex:SetAllPoints()
            local function applyIcon()
                local _, _, _, _, _, _, _, _, _, iconPath = GetItemInfo(item.id)
                if iconPath then
                    iconTex:SetTexture(iconPath)
                else
                    iconTex:SetTexture("Interface\\Icons\\INV_Misc_QuestionMark")
                end
            end
            applyIcon()
            row.iconTex   = iconTex
            row.itemId    = item.id
            row.applyIcon = applyIcon
            UI:AddBorder(iconFrame)

            local nameLbl = UI:NewText(row, 10, UI.C_TEXT_NORMAL)
            nameLbl:SetPoint("TOPLEFT",  row, "TOPLEFT",  ICO_S + 6, -3)
            nameLbl:SetPoint("TOPRIGHT", row, "TOPRIGHT", -4, -3)
            nameLbl:SetText(item.name)
            nameLbl:SetWordWrap(false)
            nameLbl:SetNonSpaceWrap(false)

            local slotLbl = UI:NewText(row, 9, UI.C_TEXT_DIM)
            slotLbl:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", ICO_S + 6, 4)
            slotLbl:SetText(item.slot)

            row:SetScript("OnClick", function()
                if row.previewing then
                    modelFrame:SetUnit("player")
                    row.previewing = false
                    iconTex:SetDesaturated(false)
                    UI:SetRGBA(hoverBg, { 0.18, 0.13, 0.28, 0 })
                    for _, r in ipairs(itemRows) do
                        if r ~= row and r.previewing then
                            modelFrame:TryOn(r.item.link)
                        end
                    end
                else
                    if model then model:TryOn(item.link) end
                    row.previewing = true
                    iconTex:SetDesaturated(false)
                    UI:SetRGBA(hoverBg, { 0.10, 0.30, 0.15, 0.4 })
                end
            end)
            row:SetScript("OnEnter", function()
                nameLbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
                UI:SetRGBA(hoverBg, { 0.18, 0.13, 0.28, row.previewing and 0.4 or 0.25 })
                GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(item.link)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function()
                nameLbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
                UI:SetRGBA(hoverBg, { 0.18, 0.13, 0.28, row.previewing and 0.4 or 0 })
                GameTooltip:Hide()
            end)
            row.item = item
            table.insert(itemRows, row)
        end
    end

    itemContent.populate = function(class, setName)
        buildItemRows(WW:GetSetItems(class, setName))
        previewAllBtn:SetScript("OnClick", function()
            if not model then return end
            model:Undress()
            for _, r in ipairs(itemRows) do
                if r.item then model:TryOn(r.item.link) end
            end
            for _, r in ipairs(itemRows) do
                r.previewing = true
                if r.hoverBg then UI:SetRGBA(r.hoverBg, { 0.10, 0.30, 0.15, 0.4 }) end
            end
        end)
    end

    -- Populate item list from an external flat array of {id, name, slot, link}
    itemContent.populateDirect = function(items)
        buildItemRows(items)
        previewAllBtn:SetScript("OnClick", function()
            if not model then return end
            model:Undress()
            for _, r in ipairs(itemRows) do
                if r.item then model:TryOn(r.item.link) end
            end
            for _, r in ipairs(itemRows) do
                r.previewing = true
                if r.hoverBg then UI:SetRGBA(r.hoverBg, { 0.10, 0.30, 0.15, 0.4 }) end
            end
        end)
    end

    WW.eventFrame:HookScript("OnEvent", function(_, event, itemId)
        if event ~= "GET_ITEM_INFO_RECEIVED" then return end
        for _, r in ipairs(itemRows) do
            if r.itemId == itemId and r.applyIcon then
                r.applyIcon()
            end
        end
    end)
    pcall(WW.eventFrame.RegisterEvent, WW.eventFrame, "GET_ITEM_INFO_RECEIVED")

    -- --------------------------------------------------------
    -- Right column: inline DressUpModel
    -- --------------------------------------------------------
    local modelFrame = CreateFrame("DressUpModel", "WicksWardrobeModel", panel)
    model = modelFrame
    modelFrame:SetFrameLevel(panel:GetFrameLevel() + 1)
    modelFrame:SetPoint("TOPLEFT",     panel, "TOPLEFT",     ITEM_W + 1, -HEADER_H)
    modelFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, BOT_BAR_H)
    modelFrame:EnableMouse(true)

    local dragX  = nil
    local facing = 0
    modelFrame:SetScript("OnMouseDown", function(self, btn)
        if btn == "LeftButton" then dragX = select(1, GetCursorPosition()) end
    end)
    modelFrame:SetScript("OnMouseUp", function(self, btn)
        if btn == "LeftButton" then dragX = nil end
    end)
    modelFrame:SetScript("OnUpdate", function(self)
        if not dragX then return end
        local cx = select(1, GetCursorPosition())
        facing = facing + (cx - dragX) * 0.01
        dragX  = cx
        self:SetFacing(facing)
    end)

    -- --------------------------------------------------------
    -- Bottom bar: dropdowns + model controls
    -- --------------------------------------------------------
    local botBar = CreateFrame("Frame", nil, panel)
    botBar:SetPoint("BOTTOMLEFT",  panel, "BOTTOMLEFT",  0, 0)
    botBar:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, 0)
    botBar:SetHeight(BOT_BAR_H)
    local botBg = UI:NewTexture(botBar, "BACKGROUND", UI.C_HEADER_BG)
    botBg:SetAllPoints()

    -- Top border on bot bar
    local botTopLine = UI:NewTexture(botBar, "BORDER", UI.C_BORDER)
    botTopLine:SetHeight(1)
    botTopLine:SetPoint("TOPLEFT",  botBar, "TOPLEFT",  0, 0)
    botTopLine:SetPoint("TOPRIGHT", botBar, "TOPRIGHT", 0, 0)

    -- Label + dropdown widths
    local LABEL_W = 36
    local DD_H    = 20
    local DD_PAD  = 4

    local xCursor = 6  -- running x offset inside botBar

    local function addLabel(text, w)
        local lbl = botBar:CreateFontString(nil, "OVERLAY")
        lbl:SetFont("Fonts\\FRIZQT__.TTF", 9, "")
        lbl:SetTextColor(UI.C_TEXT_DIM[1], UI.C_TEXT_DIM[2], UI.C_TEXT_DIM[3], 1)
        lbl:SetPoint("LEFT", botBar, "LEFT", xCursor, 0)
        lbl:SetWidth(w)
        lbl:SetJustifyH("LEFT")
        lbl:SetText(text)
        xCursor = xCursor + w
        return lbl
    end

    -- Forward declarations (dropdowns reference each other's callbacks)
    local classDd, specDd, setDd

    -- refreshItems: update set dropdown and item list
    local function refreshItems(setName)
        selectedSet   = setName
        db.lastSetIdx = setName
        if itemContent then itemContent.populate(selectedClass, setName) end
    end

    -- refreshSets: rebuild set dropdown for a given class
    local function refreshSets(class)
        selectedClass = class
        db.lastClass  = class
        local sets = WW:GetSets(class)
        local entries = {}
        for _, s in ipairs(sets) do
            table.insert(entries, { value = s, label = s })
        end
        if setDd then
            setDd.setEntries(entries)
            if #sets > 0 then
                setDd.setValue(sets[1], sets[1])
                refreshItems(sets[1])
            else
                setDd.setValue(nil, "")
            end
        end
    end

    -- refreshSpecs: rebuild spec dropdown for a given class
    local function refreshSpecs(class)
        local titleClass = class:sub(1,1):upper() .. class:sub(2):lower()
        local specs = CLASS_SPECS[titleClass] or {}
        local entries = {}
        for _, s in ipairs(specs) do
            table.insert(entries, { value = s, label = s })
        end
        if specDd then
            specDd.setEntries(entries)
            if #specs > 0 then
                local valid = false
                for _, s in ipairs(specs) do if s == selectedSpec then valid = true break end end
                if not valid then selectedSpec = specs[1] end
                specDd.setValue(selectedSpec, selectedSpec)
            else
                specDd.setValue(nil, "")
            end
        end
    end

    -- Class dropdown
    addLabel("Class", LABEL_W)
    local classEntries = {}
    for _, cn in ipairs(WW.CLASS_ORDER) do
        table.insert(classEntries, { value = cn, label = WW.CLASS_DISPLAY[cn] })
    end
    classDd = MakeDropdown(botBar, 90, DD_H, classEntries, function(val)
        selectedClass = val
        db.lastClass  = val
        refreshSpecs(val)
        refreshSets(val)
    end)
    classDd:SetPoint("LEFT", botBar, "LEFT", xCursor, 0)
    xCursor = xCursor + 90 + DD_PAD

    addLabel("Spec", LABEL_W)
    local specEntries = {}
    specDd = MakeDropdown(botBar, 100, DD_H, specEntries, function(val)
        selectedSpec = val
    end)
    specDd:SetPoint("LEFT", botBar, "LEFT", xCursor, 0)
    xCursor = xCursor + 100 + DD_PAD

    addLabel("Set", LABEL_W)
    local setEntries = {}
    setDd = MakeDropdown(botBar, 120, DD_H, setEntries, function(val)
        refreshItems(val)
    end)
    setDd:SetPoint("LEFT", botBar, "LEFT", xCursor, 0)

    -- Undress / Current Gear buttons (right side of bot bar)
    local function makeCtrlBtn(parent, w, label)
        local btn = CreateFrame("Button", nil, parent)
        btn:SetSize(w, DD_H)
        local bg = UI:NewTexture(btn, "BACKGROUND", { 0.14, 0.09, 0.22, 1 })
        bg:SetAllPoints()
        UI:AddBorder(btn)
        local lbl = UI:NewText(btn, 9, UI.C_TEXT_NORMAL)
        lbl:SetPoint("CENTER")
        lbl:SetText(label)
        btn:SetScript("OnEnter", function()
            lbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
        end)
        btn:SetScript("OnLeave", function()
            lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
        end)
        return btn
    end

    local resetBtn   = makeCtrlBtn(botBar, 78, "Current Gear")
    local undressBtn = makeCtrlBtn(botBar, 60, "Undress")
    resetBtn:SetPoint("RIGHT",   botBar, "RIGHT", -6, 0)
    undressBtn:SetPoint("RIGHT", resetBtn, "LEFT", -4, 0)

    undressBtn:SetScript("OnClick", function() modelFrame:Undress() end)
    resetBtn:SetScript("OnClick", function() modelFrame:SetUnit("player") end)

    brk(botBar, "BOTTOMLEFT")

    -- --------------------------------------------------------
    -- Resize grip (BOTTOMRIGHT corner)
    -- --------------------------------------------------------
    local grip = CreateFrame("Frame", nil, panel)
    grip:SetSize(16, 16)
    grip:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, 0)
    grip:EnableMouse(true)
    local gripTex = grip:CreateTexture(nil, "BACKGROUND")
    gripTex:SetAllPoints()
    gripTex:SetColorTexture(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 0.3)
    brk(grip, "BOTTOMRIGHT")
    grip:SetScript("OnMouseDown", function(self, btn)
        if btn == "LeftButton" then panel:StartSizing("BOTTOMRIGHT") end
    end)
    grip:SetScript("OnMouseUp", function()
        panel:StopMovingOrSizing()
        local newW = math.max(MIN_W, panel:GetWidth())
        local newH = math.max(MIN_H, panel:GetHeight())
        panel:SetSize(newW, newH)
        db.ui.width  = newW
        db.ui.height = newH
    end)

    -- --------------------------------------------------------
    -- Restore / clamp position
    -- --------------------------------------------------------
    local function applyPosition()
        -- Clamp to right of BIS Tracker if it is visible
        local bisPanel = _G["WTBTPanel"]
        if bisPanel and bisPanel:IsShown() then
            panel:ClearAllPoints()
            panel:SetPoint("TOPLEFT", bisPanel, "TOPRIGHT", 4, 0)
            return
        end
        if pos.posPoint and pos.posPoint ~= false then
            panel:SetPoint(pos.posPoint, UIParent, pos.posRel, pos.posX or 0, pos.posY or 0)
        else
            panel:SetPoint("CENTER", UIParent, "CENTER")
        end
    end

    applyPosition()

    -- Re-clamp whenever BIS panel shows/hides
    if _G["WTBTPanel"] then
        _G["WTBTPanel"]:HookScript("OnShow", function()
            if panel:IsShown() then
                panel:ClearAllPoints()
                panel:SetPoint("TOPLEFT", _G["WTBTPanel"], "TOPRIGHT", 4, 0)
            end
        end)
        _G["WTBTPanel"]:HookScript("OnHide", function()
            if panel:IsShown() then
                panel:ClearAllPoints()
                if pos.posPoint and pos.posPoint ~= false then
                    panel:SetPoint(pos.posPoint, UIParent, pos.posRel, pos.posX or 0, pos.posY or 0)
                else
                    panel:SetPoint("CENTER", UIParent, "CENTER")
                end
            end
        end)
    else
        -- BIS Tracker not loaded yet; hook when it loads
        WW.eventFrame:HookScript("OnEvent", function(_, event, addonName)
            if event ~= "ADDON_LOADED" then return end
            if addonName ~= "WickidsTBCBISTracker" then return end
            C_Timer.After(0.1, function()
                local bisPanel = _G["WTBTPanel"]
                if not bisPanel then return end
                bisPanel:HookScript("OnShow", function()
                    if panel and panel:IsShown() then
                        panel:ClearAllPoints()
                        panel:SetPoint("TOPLEFT", bisPanel, "TOPRIGHT", 4, 0)
                    end
                end)
                bisPanel:HookScript("OnHide", function()
                    if panel and panel:IsShown() then
                        panel:ClearAllPoints()
                        if pos.posPoint and pos.posPoint ~= false then
                            panel:SetPoint(pos.posPoint, UIParent, pos.posRel, pos.posX or 0, pos.posY or 0)
                        else
                            panel:SetPoint("CENTER", UIParent, "CENTER")
                        end
                    end
                end)
            end)
        end)
        pcall(WW.eventFrame.RegisterEvent, WW.eventFrame, "ADDON_LOADED")
    end

    -- --------------------------------------------------------
    -- Initial population
    -- --------------------------------------------------------
    local _, playerClass = UnitClass("player")
    local initClass = (playerClass and WW.DATA[playerClass:upper()]) and playerClass:upper() or "MAGE"
    if db.lastClass and WW.DATA[db.lastClass] then
        initClass = db.lastClass
    end
    selectedClass = initClass

    -- Prime class dropdown display
    classDd.setValue(initClass, WW.CLASS_DISPLAY[initClass] or initClass)

    -- Build spec list (sets selectedSpec)
    local titleInit = initClass:sub(1,1):upper() .. initClass:sub(2):lower()
    local initSpecs = CLASS_SPECS[titleInit] or {}
    local specEnts  = {}
    for _, s in ipairs(initSpecs) do table.insert(specEnts, { value = s, label = s }) end
    specDd.setEntries(specEnts)
    if #initSpecs > 0 then
        selectedSpec = initSpecs[1]
        specDd.setValue(selectedSpec, selectedSpec)
    end

    -- Build set list
    local initSets = WW:GetSets(initClass)
    local setEnts  = {}
    for _, s in ipairs(initSets) do table.insert(setEnts, { value = s, label = s }) end
    setDd.setEntries(setEnts)
    -- Load the player model once so the viewer has a character to render.
    -- This must happen before any TryOn calls.
    modelFrame:SetUnit("player")

    if #initSets > 0 then
        setDd.setValue(initSets[1], initSets[1])
        C_Timer.After(0, function()
            refreshItems(initSets[1])
        end)
    end

    panel._refreshSets  = refreshSets
    panel._refreshItems = refreshItems

    panel._setClassDisplay = function(cls)
        selectedClass = cls
        db.lastClass  = cls
        classDd.setValue(cls, WW.CLASS_DISPLAY[cls] or cls)
    end

    panel._populateItemsDirect = function(items)
        itemContent.populateDirect(items)
    end

    -- Preview a named Wardrobe set on the model
    panel._previewSet = function(cls, setName)
        if not model then return end
        local setItems = WW:GetSetItems(cls, setName)
        model:Undress()
        for _, it in ipairs(setItems) do model:TryOn(it.link) end
    end

    -- Preview whichever set is currently loaded in the item list
    panel._previewCurrentSet = function()
        if not model then return end
        model:Undress()
        for _, r in ipairs(itemRows) do
            if r.item then model:TryOn(r.item.link) end
        end
    end

    panel:Hide()
end

-- ============================================================
-- Public API
-- ============================================================
function UI:Show()
    local ok, err = pcall(buildPanel)
    if not ok then
        print("|cffff4444Wick's Wardrobe|r build error: " .. tostring(err))
        return
    end
    if not panel then
        print("|cffff4444Wick's Wardrobe|r panel is nil after build")
        return
    end
    panel:Show()
    WW.db.ui.hidden = false
    -- Clamp to BIS Tracker on open if it is visible
    local bisPanel = _G["WTBTPanel"]
    if bisPanel and bisPanel:IsShown() then
        panel:ClearAllPoints()
        panel:SetPoint("TOPLEFT", bisPanel, "TOPRIGHT", 4, 0)
    end
end

local function slotTableToItems(slotTable)
    local items = {}
    local seen = {}
    for _, slotKey in ipairs(SLOT_DISPLAY_ORDER) do
        local entry = slotTable[slotKey]
        if entry then
            seen[slotKey] = true
            local itemId
            if type(entry) == "table" then
                itemId = entry.itemId or (entry[1] and entry[1].itemId)
            end
            if itemId then
                local name = GetItemInfo(itemId) or ("Item #" .. itemId)
                local link = ("|Hitem:%d:0:0:0:0:0:0:0|h[%s]|h"):format(itemId, name)
                table.insert(items, { id = itemId, name = name, slot = slotKey, link = link })
            end
        end
    end
    -- Any visible slots not in the ordered list
    for slotKey, entry in pairs(slotTable) do
        if not seen[slotKey] and SLOT_VISIBLE[slotKey] then
            local itemId
            if type(entry) == "table" then
                itemId = entry.itemId or (entry[1] and entry[1].itemId)
            end
            if itemId then
                local name = GetItemInfo(itemId) or ("Item #" .. itemId)
                local link = ("|Hitem:%d:0:0:0:0:0:0:0|h[%s]|h"):format(itemId, name)
                table.insert(items, { id = itemId, name = name, slot = slotKey, link = link })
            end
        end
    end
    return items
end

-- class: uppercase e.g. "DRUID"
-- setName: custom list name, or nil for BIS tab
-- spec: title-case spec e.g. "Feral", or nil
-- phase: phase number (1-5) for BIS tab, or nil
function UI:ShowWithContext(class, setName, spec, phase)
    self:Show()
    if not panel then return end
    C_Timer.After(0, function()
        local cls = class and class:upper()
        local titleCls = cls and (cls:sub(1,1):upper() .. cls:sub(2):lower())

        if setName and cls then
            -- Determine if setName is a Wardrobe set or a BIS Tracker custom list
            local isWardrobeSet = false
            local sets = WW:GetSets(cls)
            for _, s in ipairs(sets) do
                if s == setName then isWardrobeSet = true break end
            end

            if isWardrobeSet then
                if panel._refreshSets then panel._refreshSets(cls) end
                if panel._refreshItems then panel._refreshItems(setName) end
                if panel._previewSet then panel._previewSet(cls, setName) end
            else
                -- Custom BIS list: update class label, populate items list, preview on model
                if panel._setClassDisplay then panel._setClassDisplay(cls) end
                if WTBTCustomLists and titleCls then
                    for _, lists in pairs(WTBTCustomLists[titleCls] or {}) do
                        if lists[setName] then
                            local slotTable = lists[setName]
                            if panel._previewBISItems then panel._previewBISItems(slotTable) end
                            if panel._populateItemsDirect then
                                panel._populateItemsDirect(slotTableToItems(slotTable))
                            end
                            break
                        end
                    end
                end
            end
        elseif cls then
            -- BIS tab: build flat slotTable from phase data, populate items + preview model
            if panel._setClassDisplay then panel._setClassDisplay(cls) end
            if WTBT_Data and titleCls and spec and phase then
                local phaseData = WTBT_Data[titleCls]
                    and WTBT_Data[titleCls][spec]
                    and WTBT_Data[titleCls][spec][phase]
                if phaseData then
                    local flat = {}
                    for slotKey, items in pairs(phaseData) do
                        if type(items) == "table" and items[1] and items[1].itemId then
                            flat[slotKey] = { itemId = items[1].itemId, name = items[1].name }
                        end
                    end
                    if panel._previewBISItems then panel._previewBISItems(flat) end
                    if panel._populateItemsDirect then
                        panel._populateItemsDirect(slotTableToItems(flat))
                    end
                end
            end
        end
    end)
end

function UI:Hide()
    if panel then panel:Hide() end
    WW.db.ui.hidden = true
end

function UI:Toggle()
    if panel and panel:IsShown() then
        self:Hide()
    else
        self:Show()
    end
end

function UI:SnapPosition()
    if panel and panel._snapPosition then panel._snapPosition() end
end

function UI:Reset()
    local pos = WW.db.pos
    pos.posPoint = false
    pos.posRel   = false
    pos.posX     = 0
    pos.posY     = 0
    if panel then
        panel:ClearAllPoints()
        panel:SetPoint("CENTER", UIParent, "CENTER")
    end
end

-- ============================================================
-- Boot on LOGIN
-- ============================================================
WW:On("LOGIN", function()
    WW.db.ui.hidden = true
end)
