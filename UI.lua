-- Wick's Wardrobe
-- UI.lua: brand chrome helpers + main panel (class picker, set list, item list, inline model).

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
-- BIS Tracker spec map (title-case class → ordered spec list)
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
local MIN_W    = 560
local MIN_H    = 420
local HEADER_H = 26
local SIDE_W   = 180    -- class + set list column
local ITEM_W   = 160    -- item list column
local MODEL_MIN= 180    -- minimum model viewer width

-- ============================================================
-- Scroll list helper: creates a clip frame + scroll content
-- Returns: clip, content, scrollbar (thin), scrollUp(), scrollDown()
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
        -- delta +1 = wheel up = scroll toward top = decrease scrollY
        setScroll(scrollY - delta * rowH)
    end)

    content.setScroll  = setScroll
    content.resetScroll = function() setScroll(0) end
    content.clip = clip
    return content
end

-- ============================================================
-- Build the main panel (lazy, called once on first show)
-- ============================================================
local panel

local function buildPanel()
    if panel then return end

    local db = WW.db
    local W  = (db.ui.width  or 620)
    local H  = (db.ui.height or 480)

    panel = CreateFrame("Frame", "WicksWardrobePanel", UIParent, "BackdropTemplate")
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

    -- L-brackets: top two on header (child frame, so they paint above hbg),
    -- bottom two on panel directly.
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
    brk(panel,  "BOTTOMLEFT")
    -- BOTTOMRIGHT bracket drawn after grip exists so it renders above the grip texture

    -- Close button
    local closeBtn = CreateFrame("Button", nil, header)
    closeBtn:SetSize(20, 20)
    closeBtn:SetPoint("RIGHT", header, "RIGHT", -6, 0)
    local closeText = header:CreateFontString(nil, "OVERLAY")
    closeText:SetFont("Fonts\\FRIZQT__.TTF", 14, "")
    closeText:SetTextColor(UI.C_TEXT_DIM[1], UI.C_TEXT_DIM[2], UI.C_TEXT_DIM[3], 1)
    closeText:SetPoint("CENTER", closeBtn, "CENTER")
    closeText:SetText("x")
    closeBtn:SetScript("OnClick", function() panel:Hide() end)
    closeBtn:SetScript("OnEnter", function()
        closeText:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
    end)
    closeBtn:SetScript("OnLeave", function()
        closeText:SetTextColor(UI.C_TEXT_DIM[1], UI.C_TEXT_DIM[2], UI.C_TEXT_DIM[3], 1)
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
    -- Body area (below header)
    -- --------------------------------------------------------
    local bodyH = H - HEADER_H
    local bodyFrame = CreateFrame("Frame", nil, panel)
    bodyFrame:SetPoint("TOPLEFT",     panel, "TOPLEFT",     0, -HEADER_H)
    bodyFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, 0)

    -- Divider lines between columns
    local div1 = UI:NewTexture(bodyFrame, "BORDER", UI.C_BORDER)
    div1:SetWidth(1)
    div1:SetPoint("TOPLEFT",    bodyFrame, "TOPLEFT",    SIDE_W, 0)
    div1:SetPoint("BOTTOMLEFT", bodyFrame, "BOTTOMLEFT", SIDE_W, 0)

    local div2 = UI:NewTexture(bodyFrame, "BORDER", UI.C_BORDER)
    div2:SetWidth(1)
    div2:SetPoint("TOPLEFT",    bodyFrame, "TOPLEFT",    SIDE_W + ITEM_W, 0)
    div2:SetPoint("BOTTOMLEFT", bodyFrame, "BOTTOMLEFT", SIDE_W + ITEM_W, 0)

    -- --------------------------------------------------------
    -- Left column: class picker + set list
    -- --------------------------------------------------------
    local classHeaderH = 24

    -- "Class" label
    local classLabel = UI:NewText(bodyFrame, 10, UI.C_TEXT_DIM)
    classLabel:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 8, -6)
    classLabel:SetText("CLASS")

    -- Class buttons (9 classes)
    local classBtns = {}
    local selectedClass = db.lastClass or UnitClass("player") and select(2, UnitClass("player")) or "MAGE"
    selectedClass = selectedClass:upper()

    local function highlightClass(c)
        for _, b in pairs(classBtns) do
            if b.class == c then
                b.label:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
            else
                b.label:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
            end
        end
    end

    local selectedSpec = "Feral"  -- default; updated when spec clicked
    local specRows     = {}
    local setList      -- forward ref

    local function highlightSpec(spec)
        for _, r in ipairs(specRows) do
            if r.spec == spec then
                r.label:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
            else
                r.label:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
            end
        end
    end

    -- specPickerFrame: lives inside bodyFrame, positioned dynamically
    local specPickerFrame = CreateFrame("Frame", nil, bodyFrame)
    specPickerFrame:SetWidth(SIDE_W - 4)

    local function rebuildSpecPicker(class)
        for _, r in ipairs(specRows) do r:Hide() end
        wipe(specRows)
        local titleClass = class:sub(1,1):upper() .. class:sub(2):lower()
        local specs = CLASS_SPECS[titleClass]
        if not specs or #specs == 0 then
            specPickerFrame:SetHeight(0)
            return
        end
        -- Default spec to first if current selectedSpec not valid for this class
        local valid = false
        for _, s in ipairs(specs) do if s == selectedSpec then valid = true break end end
        if not valid then selectedSpec = specs[1] end

        local rowH = 16
        for i, spec in ipairs(specs) do
            local r = CreateFrame("Button", nil, specPickerFrame)
            r:SetSize(SIDE_W - 4, rowH)
            r:SetPoint("TOPLEFT", specPickerFrame, "TOPLEFT", 0, -(i - 1) * rowH)
            r.spec = spec
            local lbl = UI:NewText(r, 10, UI.C_TEXT_NORMAL)
            lbl:SetPoint("LEFT", r, "LEFT", 6, 0)
            lbl:SetText(spec)
            r.label = lbl
            r:SetScript("OnClick", function()
                selectedSpec = spec
                highlightSpec(spec)
            end)
            r:SetScript("OnEnter", function() lbl:SetTextColor(1, 1, 1, 1) end)
            r:SetScript("OnLeave", function()
                if selectedSpec == spec then
                    lbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
                else
                    lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
                end
            end)
            table.insert(specRows, r)
        end
        specPickerFrame:SetHeight(#specs * rowH)
        highlightSpec(selectedSpec)
    end

    local function refreshSets(class)
        selectedClass = class
        db.lastClass  = class
        highlightClass(class)
        rebuildSpecPicker(class)
        if setList then setList.populate(class) end
    end

    local classBtnH = 18
    for i, className in ipairs(WW.CLASS_ORDER) do
        local b = CreateFrame("Button", nil, bodyFrame)
        b:SetSize(SIDE_W - 4, classBtnH)
        b:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 2, -(i - 1) * classBtnH - 18)
        b.class = className
        local lbl = UI:NewText(b, 11, UI.C_TEXT_NORMAL)
        lbl:SetPoint("LEFT", b, "LEFT", 6, 0)
        lbl:SetText(WW.CLASS_DISPLAY[className])
        b.label = lbl
        b:SetScript("OnClick", function() refreshSets(className) end)
        b:SetScript("OnEnter", function()
            lbl:SetTextColor(1, 1, 1, 1)
            GameTooltip:SetOwner(b, "ANCHOR_RIGHT")
            GameTooltip:AddLine(WW.CLASS_DISPLAY[className])
            GameTooltip:Show()
        end)
        b:SetScript("OnLeave", function()
            if selectedClass == className then
                lbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
            else
                lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
            end
            GameTooltip:Hide()
        end)
        classBtns[className] = b
    end

    -- Spec picker: sits below class buttons
    local specLabelY = -(#WW.CLASS_ORDER * classBtnH + 16)
    local specLabel = UI:NewText(bodyFrame, 10, UI.C_TEXT_DIM)
    specLabel:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 8, specLabelY)
    specLabel:SetText("SPEC")

    local specDivLine = UI:NewTexture(bodyFrame, "BORDER", UI.C_BORDER)
    specDivLine:SetHeight(1)
    specDivLine:SetPoint("TOPLEFT",  bodyFrame, "TOPLEFT",  0, specLabelY)
    specDivLine:SetPoint("TOPRIGHT", div1,      "TOPLEFT",  0, specLabelY)

    specPickerFrame:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 2, specLabelY - 14)

    -- Divider between spec list and set list (fixed offset: max 3 specs × 16px + padding)
    local SPEC_BLOCK_H = 3 * 16 + 8   -- enough for 3 specs
    local setDivY = specLabelY - 14 - SPEC_BLOCK_H
    local setDivLine = UI:NewTexture(bodyFrame, "BORDER", UI.C_BORDER)
    setDivLine:SetHeight(1)
    setDivLine:SetPoint("TOPLEFT",  bodyFrame, "TOPLEFT",  0, setDivY)
    setDivLine:SetPoint("TOPRIGHT", div1,      "TOPLEFT",  0, setDivY)

    -- "Set" label
    local setLabel = UI:NewText(bodyFrame, 10, UI.C_TEXT_DIM)
    setLabel:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 8, setDivY - 6)
    setLabel:SetText("SET")

    local setListTopY = setDivY - 18
    local setListH    = math.max(80, bodyH + setListTopY - 4)  -- remaining body height below set label
    local setContent  = MakeScrollList(bodyFrame, SIDE_W - 4, setListH, 18)
    setContent.clip:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 2, setListTopY)

    local selectedSet   = nil
    local itemContent   = nil   -- forward ref

    local function refreshItems(setName)
        selectedSet   = setName
        db.lastSetIdx = setName
        if itemContent then itemContent.populate(selectedClass, setName) end
    end

    local setRows = {}
    setList = {}
    setList.populate = function(class)
        -- Clear old rows
        for _, row in ipairs(setRows) do row:Hide() end
        wipe(setRows)
        setContent:resetScroll()
        local sets = WW:GetSets(class)
        local contentH = #sets * 20 + 4
        setContent:SetHeight(math.max(80, contentH))
        for i, s in ipairs(sets) do
            local row = CreateFrame("Button", nil, setContent)
            row:SetSize(SIDE_W - 8, 18)
            row:SetPoint("TOPLEFT", setContent, "TOPLEFT", 2, -(i - 1) * 20 - 2)
            local lbl = UI:NewText(row, 10, UI.C_TEXT_NORMAL)
            lbl:SetPoint("LEFT", row, "LEFT", 4, 0)
            lbl:SetText(s)
            row.setName = s
            row.label   = lbl
            row:SetScript("OnClick", function()
                for _, r in ipairs(setRows) do
                    r.label:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
                end
                lbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
                refreshItems(s)
            end)
            row:SetScript("OnEnter", function() lbl:SetTextColor(1, 1, 1, 1) end)
            row:SetScript("OnLeave", function()
                if selectedSet == s then
                    lbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
                else
                    lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
                end
            end)
            table.insert(setRows, row)
        end
    end

    -- --------------------------------------------------------
    -- Middle column: item list
    -- --------------------------------------------------------
    local itemLabel = UI:NewText(bodyFrame, 10, UI.C_TEXT_DIM)
    itemLabel:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", SIDE_W + 8, -6)
    itemLabel:SetText("ITEMS")

    -- Bottom button row: "Preview Set" (left) + "From BIS" (right)
    local BTN_H   = 20
    local BTN_PAD = 4
    local BTN_W   = math.floor((ITEM_W - 12 - BTN_PAD) / 2)

    local previewAllBtn = CreateFrame("Button", nil, bodyFrame)
    previewAllBtn:SetSize(BTN_W, BTN_H)
    previewAllBtn:SetPoint("BOTTOMLEFT", bodyFrame, "BOTTOMLEFT", SIDE_W + 6, 4)
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

    local model = nil  -- assigned after DressUpModel frame is created below

    -- "From BIS" button — imports BIS Tracker custom list or BIS phase
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

    -- BIS import popup (built once, reused)
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

    -- Slot key → model slot ID mapping (matches BIS Tracker CUSTOM_SLOTS)
    local BIS_SLOT_MAP = {
        Head      = 1,  Neck     = 2,  Shoulder = 3,  Back     = 15,
        Chest     = 5,  Wrist    = 9,  Hands    = 10, Waist    = 6,
        Legs      = 7,  Feet     = 8,
        MainHand  = 16, OffHand  = 17, Relic    = 18,
    }

    local function previewBISItems(slotTable)
        if not model then return end
        model:Undress()
        for slotKey, entry in pairs(slotTable) do
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

    local bisPopupRows = {}
    local function buildBISPopup(cls, spec)
        -- Clear old rows
        for _, r in ipairs(bisPopupRows) do r:Hide() end
        wipe(bisPopupRows)

        local entries = {}

        -- Custom lists from BIS Tracker
        if WTBTCustomLists and WTBTCustomLists[cls] and WTBTCustomLists[cls][spec] then
            for name, slotData in pairs(WTBTCustomLists[cls][spec]) do
                table.insert(entries, { label = name, data = slotData })
            end
        end

        -- BIS phase sets from WTBT_Data
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
                        -- BIS data: { slotKey = { {itemId, ...}, ... } }
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
        if bisPopup:IsShown() then
            bisPopup:Hide()
            return
        end
        local cls = selectedClass:sub(1,1):upper() .. selectedClass:sub(2):lower()
        buildBISPopup(cls, selectedSpec)
        bisPopup:ClearAllPoints()
        bisPopup:SetPoint("BOTTOMLEFT", bisBtn, "TOPLEFT", 0, 2)
        bisPopup:Show()
    end)

    -- Close popup when clicking elsewhere (click-catcher backdrop)
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
    -- Put the popup above the catcher
    bisPopup:SetFrameLevel(bisCatcher:GetFrameLevel() + 1)

    local ITEM_ROW_H        = 38   -- icon row height + gap
    local ITEM_LIST_BOT_PAD = 30  -- space for button row
    local itemListH = bodyH - 20 - ITEM_LIST_BOT_PAD
    local itemScrollContent = MakeScrollList(bodyFrame, ITEM_W - 4, itemListH, ITEM_ROW_H)
    itemScrollContent.clip:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", SIDE_W + 2, -18)

    local itemRows = {}

    -- Inventory slot numbers for DressUpModel:SetItem(slotId, itemId)
    -- SetItem bypasses class/equip restrictions — visual only.
    local SLOT_ID = {
        Head    = 1,  Neck      = 2,  Shoulder = 3,  Back   = 15,
        Chest   = 5,  Shirt     = 4,  Tabard   = 19, Wrist  = 9,
        Hands   = 10, Waist     = 6,  Legs     = 7,  Feet   = 8,
        ["Main Hand"] = 16, ["Off Hand"] = 17, Ranged = 18,
    }

    local function tryOnItem(item)
        if not model then return end
        model:TryOn(item.link)
    end

    itemContent = {}
    itemContent.populate = function(class, setName)
        for _, row in ipairs(itemRows) do row:Hide() end
        wipe(itemRows)
        local items = WW:GetSetItems(class, setName)
        local ROW_H = ITEM_ROW_H - 2
        local ICO_S = 32
        itemScrollContent:SetHeight(math.max(80, #items * ITEM_ROW_H + 4))
        itemScrollContent:resetScroll()
        for i, item in ipairs(items) do
            local row = CreateFrame("Button", nil, itemScrollContent)
            row:SetSize(ITEM_W - 8, ROW_H)
            row:SetPoint("TOPLEFT", itemScrollContent, "TOPLEFT", 2, -(i - 1) * ITEM_ROW_H - 2)
            row.previewing = false

            -- Hover bg (stored on row for external access)
            local hoverBg = UI:NewTexture(row, "BACKGROUND", { 0.18, 0.13, 0.28, 0 })
            hoverBg:SetAllPoints()
            row.hoverBg = hoverBg

            -- Item icon
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
            row.iconTex  = iconTex
            row.itemId   = item.id
            row.applyIcon = applyIcon
            -- Dimmed border around icon
            UI:AddBorder(iconFrame)

            -- Item name label (single line, truncates)
            local nameLbl = UI:NewText(row, 10, UI.C_TEXT_NORMAL)
            nameLbl:SetPoint("TOPLEFT",  row, "TOPLEFT",  ICO_S + 6, -3)
            nameLbl:SetPoint("TOPRIGHT", row, "TOPRIGHT", -4, -3)
            nameLbl:SetText(item.name)
            nameLbl:SetWordWrap(false)
            nameLbl:SetNonSpaceWrap(false)

            -- Slot label below name
            local slotLbl = UI:NewText(row, 9, UI.C_TEXT_DIM)
            slotLbl:SetPoint("BOTTOMLEFT", row, "BOTTOMLEFT", ICO_S + 6, 4)
            slotLbl:SetText(item.slot)

            row:SetScript("OnClick", function()
                if row.previewing then
                    -- toggle off: reload current gear then re-apply other active items
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
                    tryOnItem(item)
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

        -- Wire preview-all to current set
        previewAllBtn:SetScript("OnClick", function()
            if not model then return end
            local setItems = WW:GetSetItems(class, setName)
            model:Undress()
            for _, it in ipairs(setItems) do
                model:TryOn(it.link)
            end
            for _, r in ipairs(itemRows) do
                r.previewing = true
                if r.hoverBg then UI:SetRGBA(r.hoverBg, { 0.10, 0.30, 0.15, 0.4 }) end
            end
        end)
    end

    -- Update icons when item data arrives from server
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
    -- Right column: inline DressUpModel character preview
    -- --------------------------------------------------------
    -- Controls strip along the bottom of the model pane (declared first — modelFrame uses modelCtrlH)
    local modelCtrlH = 22
    local ctrlStrip = CreateFrame("Frame", nil, bodyFrame)
    ctrlStrip:SetPoint("BOTTOMLEFT",  bodyFrame, "BOTTOMLEFT",  SIDE_W + ITEM_W + 2, 0)
    ctrlStrip:SetPoint("BOTTOMRIGHT", bodyFrame, "BOTTOMRIGHT", 0, 0)
    ctrlStrip:SetHeight(modelCtrlH)
    local ctrlBg = UI:NewTexture(ctrlStrip, "BACKGROUND", UI.C_HEADER_BG)
    ctrlBg:SetAllPoints()

    local function makeCtrlBtn(parent, w, anchorPoint, anchorFrame, anchorTo, ox, label)
        local btn = CreateFrame("Button", nil, parent)
        btn:SetSize(w, 18)
        btn:SetPoint(anchorPoint, anchorFrame, anchorTo, ox, 0)
        local bg = UI:NewTexture(btn, "BACKGROUND", { 0.14, 0.09, 0.22, 1 })
        bg:SetAllPoints()
        UI:AddBorder(btn)
        local lbl = UI:NewText(btn, 9, UI.C_TEXT_NORMAL)
        lbl:SetPoint("CENTER")
        lbl:SetText(label)
        btn:SetScript("OnEnter", function() lbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1) end)
        btn:SetScript("OnLeave", function() lbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1) end)
        return btn
    end

    -- DressUpModel must be parented to a top-level frame (panel), not a sub-frame,
    -- or the model renderer has no valid draw context and renders nothing.
    local modelFrame = CreateFrame("DressUpModel", "WicksWardrobeModel", panel)
    model = modelFrame
    modelFrame:SetFrameLevel(panel:GetFrameLevel() + 1)
    modelFrame:SetPoint("TOPLEFT",     panel, "TOPLEFT",     SIDE_W + ITEM_W + 2, -HEADER_H)
    modelFrame:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, modelCtrlH)
    modelFrame:EnableMouse(true)

    -- Drag-to-rotate
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

    local undressBtn = makeCtrlBtn(ctrlStrip, 60, "LEFT", ctrlStrip, "LEFT", 4, "Undress")
    undressBtn:SetScript("OnClick", function() modelFrame:Undress() end)

    local resetBtn = makeCtrlBtn(ctrlStrip, 72, "LEFT", undressBtn, "RIGHT", 4, "Current Gear")
    resetBtn:SetScript("OnClick", function()
        modelFrame:SetUnit("player")
    end)

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
    -- Draw BOTTOMRIGHT bracket on the grip so it renders above the grip background
    brk(grip, "BOTTOMRIGHT")
    grip:SetScript("OnMouseDown", function(self, btn)
        if btn == "LeftButton" then
            panel:StartSizing("BOTTOMRIGHT")
        end
    end)
    grip:SetScript("OnMouseUp", function()
        panel:StopMovingOrSizing()
        local newW = math.max(MIN_W, panel:GetWidth())
        local newH = math.max(MIN_H, panel:GetHeight())
        panel:SetSize(newW, newH)
        db.ui.width  = newW
        db.ui.height = newH
    end)

    -- SetMinResize does not exist in TBC 2.5.5; omit it.

    -- --------------------------------------------------------
    -- Restore position from saved vars (posPoint == false = no saved pos yet)
    -- --------------------------------------------------------
    if pos.posPoint and pos.posPoint ~= false then
        panel:SetPoint(pos.posPoint, UIParent, pos.posRel, pos.posX or 0, pos.posY or 0)
    else
        panel:SetPoint("CENTER", UIParent, "CENTER")
    end

    -- --------------------------------------------------------
    -- Initial population: auto-select player class
    -- --------------------------------------------------------
    local _, playerClass = UnitClass("player")
    local initClass = (playerClass and WW.DATA[playerClass:upper()]) and playerClass:upper() or "MAGE"
    if db.lastClass and WW.DATA[db.lastClass] then
        initClass = db.lastClass
    end
    refreshSets(initClass)
    -- Auto-select first set
    local firstSets = WW:GetSets(initClass)
    if firstSets[1] then
        C_Timer.After(0, function()
            refreshItems(firstSets[1])
            -- Highlight first row in the set list
            if setRows[1] then
                setRows[1].label:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
                selectedSet = firstSets[1]
            end
        end)
    end

    panel._refreshSets  = refreshSets
    panel._refreshItems = refreshItems
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
    -- Load the player character into the model each time the panel opens
    if _G.WicksWardrobeModel then
        _G.WicksWardrobeModel:SetUnit("player")
    end
end

-- Open and navigate to a specific class + set name. Called by other Wick
-- addons (BIS Tracker) to land on the right set without extra clicks.
-- class: uppercase class key e.g. "MAGE", "PRIEST"
-- setName: exact set string from WW:GetSets(class), e.g. "T4" or a custom name
function UI:ShowWithContext(class, setName)
    self:Show()
    if not panel then return end
    C_Timer.After(0, function()
        if panel._refreshSets and class then
            panel._refreshSets(class:upper())
        end
        if panel._refreshItems and setName then
            panel._refreshItems(setName)
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
-- Always start hidden regardless of saved state. The user must
-- manually open Wardrobe each session via /wwd or the minimap icon.
WW:On("LOGIN", function()
    WW.db.ui.hidden = true
end)
