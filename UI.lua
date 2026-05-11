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
-- Panel dimensions
-- ============================================================
local MIN_W    = 560
local MIN_H    = 420
local HEADER_H = 26
local SIDE_W   = 180    -- class + set list column
local ITEM_W   = 160    -- item list column
local MODEL_MIN= 180    -- minimum model viewer width

-- Column layout (SIDE_W | ITEM_W | MODEL fill)
-- All three columns share the full height minus header + footer.

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
        setScroll(scrollY - delta * rowH * 3)
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

    -- Border + L-brackets
    UI:AddBorder(panel)
    UI:AddCornerAccents(panel)

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
    header:EnableMouse(true)
    header:SetScript("OnMouseDown", function(self, btn)
        if btn == "LeftButton" then panel:StartMoving() end
    end)
    header:SetScript("OnMouseUp", function()
        panel:StopMovingOrSizing()
        local p, _, rp, x, y = panel:GetPoint()
        db.ui.x = x; db.ui.y = y
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

    local setList  -- forward ref
    local function refreshSets(class)
        selectedClass = class
        db.lastClass  = class
        highlightClass(class)
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

    -- Divider between class list and set list
    local setDivY = -(#WW.CLASS_ORDER * classBtnH + 20)
    local setDivLine = UI:NewTexture(bodyFrame, "BORDER", UI.C_BORDER)
    setDivLine:SetHeight(1)
    setDivLine:SetPoint("TOPLEFT",  bodyFrame, "TOPLEFT",  0, setDivY)
    setDivLine:SetPoint("TOPRIGHT", div1,      "TOPLEFT",  0, setDivY)

    -- "Set" label
    local setLabel = UI:NewText(bodyFrame, 10, UI.C_TEXT_DIM)
    setLabel:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 8, setDivY - 6)
    setLabel:SetText("SET")

    local setListTopY  = setDivY - 18
    local setListH     = bodyH + setListTopY   -- remaining height
    local setContent   = MakeScrollList(bodyFrame, SIDE_W - 4, math.max(80, -setListTopY - 4), 18)
    setContent.clip:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", 2, setListTopY)

    local selectedSet   = nil
    local itemContent   = nil   -- forward ref

    local function refreshItems(setName)
        selectedSet   = setName
        db.lastSetIdx = setName
        if itemContent then itemContent.populate(selectedClass, setName) end
    end

    local setRows = {}
    function setList(class) end   -- dummy replaced below
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

    -- "Preview All" button at the bottom of item column
    local previewAllBtn = CreateFrame("Button", nil, bodyFrame)
    previewAllBtn:SetSize(ITEM_W - 12, 20)
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

    local ITEM_LIST_BOT_PAD = 30  -- space for Preview All button
    local itemListH = bodyH - 20 - ITEM_LIST_BOT_PAD
    local itemScrollContent = MakeScrollList(bodyFrame, ITEM_W - 4, itemListH, 20)
    itemScrollContent.clip:SetPoint("TOPLEFT", bodyFrame, "TOPLEFT", SIDE_W + 2, -18)

    local itemRows = {}
    local model    = nil   -- forward ref

    local function tryOnItem(link)
        if model then
            model:TryOn(link)
        end
    end

    itemContent = {}
    itemContent.populate = function(class, setName)
        for _, row in ipairs(itemRows) do row:Hide() end
        wipe(itemRows)
        itemScrollContent:resetScroll()
        local items = WW:GetSetItems(class, setName)
        local contentH = #items * 22 + 4
        itemScrollContent:SetHeight(math.max(80, contentH))
        for i, item in ipairs(items) do
            local row = CreateFrame("Button", nil, itemScrollContent)
            row:SetSize(ITEM_W - 8, 20)
            row:SetPoint("TOPLEFT", itemScrollContent, "TOPLEFT", 2, -(i - 1) * 22 - 2)

            -- Slot label (dim, left)
            local slotLbl = UI:NewText(row, 9, UI.C_TEXT_DIM)
            slotLbl:SetPoint("LEFT", row, "LEFT", 2, 0)
            slotLbl:SetText(item.slot)
            slotLbl:SetWidth(48)

            -- Item name (right of slot)
            local nameLbl = UI:NewText(row, 10, UI.C_TEXT_NORMAL)
            nameLbl:SetPoint("LEFT", slotLbl, "RIGHT", 4, 0)
            nameLbl:SetPoint("RIGHT", row, "RIGHT", -2, 0)
            nameLbl:SetText(item.name)
            nameLbl:SetWordWrap(false)
            nameLbl:SetNonSpaceWrap(false)

            row:SetScript("OnClick", function()
                tryOnItem(item.link)
            end)
            row:SetScript("OnEnter", function()
                nameLbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1)
                GameTooltip:SetOwner(row, "ANCHOR_RIGHT")
                GameTooltip:SetHyperlink(item.link)
                GameTooltip:Show()
            end)
            row:SetScript("OnLeave", function()
                nameLbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1)
                GameTooltip:Hide()
            end)
            table.insert(itemRows, row)
        end

        -- Wire preview-all to current set
        previewAllBtn:SetScript("OnClick", function()
            local setItems = WW:GetSetItems(class, setName)
            if model then
                model:Undress()
                for _, it in ipairs(setItems) do
                    model:TryOn(it.link)
                end
            end
        end)
    end

    -- --------------------------------------------------------
    -- Right column: DressUpModel (inline character preview)
    -- --------------------------------------------------------
    local modelFrame = CreateFrame("DressUpModel", "WicksWardrobeModel", bodyFrame)
    model = modelFrame
    modelFrame:SetPoint("TOPLEFT",     bodyFrame, "TOPLEFT",     SIDE_W + ITEM_W + 2, 0)
    modelFrame:SetPoint("BOTTOMRIGHT", bodyFrame, "BOTTOMRIGHT", 0, 0)

    -- Model controls strip along the bottom of the model pane
    local modelCtrlH = 22
    local ctrlStrip = CreateFrame("Frame", nil, bodyFrame)
    ctrlStrip:SetPoint("BOTTOMLEFT",  bodyFrame, "BOTTOMLEFT",  SIDE_W + ITEM_W + 2, 0)
    ctrlStrip:SetPoint("BOTTOMRIGHT", bodyFrame, "BOTTOMRIGHT", 0, 0)
    ctrlStrip:SetHeight(modelCtrlH)
    local ctrlBg = UI:NewTexture(ctrlStrip, "BACKGROUND", UI.C_HEADER_BG)
    ctrlBg:SetAllPoints()

    -- Undress button
    local undressBtn = CreateFrame("Button", nil, ctrlStrip)
    undressBtn:SetSize(60, 18)
    undressBtn:SetPoint("LEFT", ctrlStrip, "LEFT", 4, 0)
    local ubg = UI:NewTexture(undressBtn, "BACKGROUND", { 0.14, 0.09, 0.22, 1 })
    ubg:SetAllPoints()
    UI:AddBorder(undressBtn)
    local uLbl = UI:NewText(undressBtn, 9, UI.C_TEXT_NORMAL)
    uLbl:SetPoint("CENTER")
    uLbl:SetText("Undress")
    undressBtn:SetScript("OnClick", function() modelFrame:Undress() end)
    undressBtn:SetScript("OnEnter", function() uLbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1) end)
    undressBtn:SetScript("OnLeave", function() uLbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1) end)

    -- Reset-to-equipped button
    local resetBtn = CreateFrame("Button", nil, ctrlStrip)
    resetBtn:SetSize(72, 18)
    resetBtn:SetPoint("LEFT", undressBtn, "RIGHT", 4, 0)
    local rbg = UI:NewTexture(resetBtn, "BACKGROUND", { 0.14, 0.09, 0.22, 1 })
    rbg:SetAllPoints()
    UI:AddBorder(resetBtn)
    local rLbl = UI:NewText(resetBtn, 9, UI.C_TEXT_NORMAL)
    rLbl:SetPoint("CENTER")
    rLbl:SetText("Reset Gear")
    resetBtn:SetScript("OnClick", function() modelFrame:DressUp() end)
    resetBtn:SetScript("OnEnter", function() rLbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1) end)
    resetBtn:SetScript("OnLeave", function() rLbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1) end)

    -- "Save Outfit" button (right side of ctrl strip)
    local saveBtn = CreateFrame("Button", nil, ctrlStrip)
    saveBtn:SetSize(72, 18)
    saveBtn:SetPoint("RIGHT", ctrlStrip, "RIGHT", -4, 0)
    local sbg = UI:NewTexture(saveBtn, "BACKGROUND", { 0.10, 0.19, 0.13, 1 })
    sbg:SetAllPoints()
    UI:AddBorder(saveBtn)
    local sLbl = UI:NewText(saveBtn, 9, UI.C_TEXT_NORMAL)
    sLbl:SetPoint("CENTER")
    sLbl:SetText("Save Outfit")
    saveBtn:SetScript("OnClick", function()
        if not selectedClass or not selectedSet then return end
        local items = WW:GetSetItems(selectedClass, selectedSet)
        local outfitName = selectedClass .. " - " .. (selectedSet or "Custom")
        -- Dedupe by name: overwrite if exists
        local outfits = db.outfits
        local found = false
        for _, o in ipairs(outfits) do
            if o.name == outfitName then
                o.items = {}
                for _, it in ipairs(items) do table.insert(o.items, it.link) end
                found = true
                break
            end
        end
        if not found then
            table.insert(outfits, { name = outfitName, items = (function()
                local t = {}
                for _, it in ipairs(items) do table.insert(t, it.link) end
                return t
            end)() })
        end
        print(("|cff4FC778Wick's Wardrobe|r: saved outfit '%s'"):format(outfitName))
    end)
    saveBtn:SetScript("OnEnter", function() sLbl:SetTextColor(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 1) end)
    saveBtn:SetScript("OnLeave", function() sLbl:SetTextColor(UI.C_TEXT_NORMAL[1], UI.C_TEXT_NORMAL[2], UI.C_TEXT_NORMAL[3], 1) end)

    -- Nudge the model frame up to leave room for the ctrl strip
    modelFrame:SetPoint("BOTTOMRIGHT", bodyFrame, "BOTTOMRIGHT", 0, modelCtrlH)

    -- --------------------------------------------------------
    -- Resize grip (BOTTOMRIGHT corner)
    -- --------------------------------------------------------
    local grip = CreateFrame("Frame", nil, panel)
    grip:SetSize(16, 16)
    grip:SetPoint("BOTTOMRIGHT", panel, "BOTTOMRIGHT", 0, 0)
    grip:EnableMouse(true)
    local gripTex = grip:CreateTexture(nil, "OVERLAY")
    gripTex:SetAllPoints()
    gripTex:SetColorTexture(UI.C_GREEN[1], UI.C_GREEN[2], UI.C_GREEN[3], 0.3)
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

    panel:SetMinResize(MIN_W, MIN_H)

    -- --------------------------------------------------------
    -- Restore position from saved vars
    -- --------------------------------------------------------
    if db.ui.x and db.ui.y then
        panel:SetPoint("TOPLEFT", UIParent, "BOTTOMLEFT", db.ui.x, db.ui.y)
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

    panel:Hide()
end

-- ============================================================
-- Public API
-- ============================================================
function UI:Show()
    buildPanel()
    panel:Show()
    WW.db.ui.hidden = false
    -- Load player on the model
    if panel and _G.WicksWardrobeModel then
        _G.WicksWardrobeModel:SetUnit("player")
    end
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

function UI:Reset()
    WW.db.ui.x = nil
    WW.db.ui.y = nil
    if panel then
        panel:ClearAllPoints()
        panel:SetPoint("CENTER", UIParent, "CENTER")
    end
end

-- ============================================================
-- Boot on LOGIN
-- ============================================================
WW:On("LOGIN", function()
    if not WW.db.ui.hidden then
        UI:Show()
    end
end)
