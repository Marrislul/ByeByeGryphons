-- Event handling frame
local frame = CreateFrame("Frame")
frame:RegisterEvent("ADDON_LOADED")
frame:RegisterEvent("PLAYER_LOGIN")
frame:RegisterEvent("PLAYER_LOGOUT")

-- Initialize global settings variable
_G.ByeByeGryphons_Settings = _G.ByeByeGryphons_Settings or { LeftGryphonHidden = true, RightGryphonHidden = true, PrintEnabled = true }

-- Function to update the checkboxes based on the loaded settings
local function updateCheckboxes()
    ByeByeGryphonsLeftCheckBox:SetChecked(_G.ByeByeGryphons_Settings.LeftGryphonHidden)
    ByeByeGryphonsRightCheckBox:SetChecked(_G.ByeByeGryphons_Settings.RightGryphonHidden)
    ByeByeGryphonsPrintCheckBox:SetChecked(_G.ByeByeGryphons_Settings.PrintEnabled)
end

-- Function to load and apply settings based on the current configuration
local function loadSettings()
    -- Apply the settings to the main menu end caps
    if _G.ByeByeGryphons_Settings.LeftGryphonHidden then
        MainMenuBar.EndCaps.LeftEndCap:Hide()
    else
        MainMenuBar.EndCaps.LeftEndCap:Show()
    end

    if _G.ByeByeGryphons_Settings.RightGryphonHidden then
        MainMenuBar.EndCaps.RightEndCap:Hide()
    else
        MainMenuBar.EndCaps.RightEndCap:Show()
    end

    if _G.ByeByeGryphons_Settings.PrintEnabled then
        print("Bye Bye Gryphons: Settings applied.")
    end
end

-- Function to create the options panel
local function createOptionsPanel()
    local panel = CreateFrame("Frame", "ByeByeGryphonsPanel")
    panel.name = "Bye Bye Gryphons"
    InterfaceOptions_AddCategory(panel)

    -- Title for the options panel
    local title = panel:CreateFontString(nil, "ARTWORK", "GameFontNormalLarge")
    title:SetPoint("TOPLEFT", 16, -16)
    title:SetText("Bye Bye Gryphons Settings")

    local checkBoxPrint = CreateFrame("CheckButton", "ByeByeGryphonsPrintCheckBox", panel, "UICheckButtonTemplate")
    checkBoxPrint:SetPoint("TOPLEFT", title, "BOTTOMLEFT", 0, -10)
    checkBoxPrint:SetScript("OnClick", function(self)
        _G.ByeByeGryphons_Settings.PrintEnabled = self:GetChecked()
        loadSettings()  -- Update settings immediately
    end)
    checkBoxPrint:SetChecked(_G.ByeByeGryphons_Settings.PrintEnabled)
    checkBoxPrint.text = checkBoxPrint:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    checkBoxPrint.text:SetPoint("LEFT", checkBoxPrint, "RIGHT", 8, 0)
    checkBoxPrint.text:SetText("Enable Print Output")

    local checkBoxLeft = CreateFrame("CheckButton", "ByeByeGryphonsLeftCheckBox", panel, "UICheckButtonTemplate")
    checkBoxLeft:SetPoint("TOPLEFT", checkBoxPrint, "BOTTOMLEFT", 0, -8)
    checkBoxLeft:SetScript("OnClick", function(self)
        _G.ByeByeGryphons_Settings.LeftGryphonHidden = self:GetChecked()
        loadSettings()  -- Update settings immediately
    end)
    checkBoxLeft:SetChecked(_G.ByeByeGryphons_Settings.LeftGryphonHidden)
    checkBoxLeft.text = checkBoxLeft:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    checkBoxLeft.text:SetPoint("LEFT", checkBoxLeft, "RIGHT", 8, 0)
    checkBoxLeft.text:SetText("Hide Left Gryphon")

    local checkBoxRight = CreateFrame("CheckButton", "ByeByeGryphonsRightCheckBox", panel, "UICheckButtonTemplate")
    checkBoxRight:SetPoint("TOPLEFT", checkBoxLeft, "BOTTOMLEFT", 0, -8)
    checkBoxRight:SetScript("OnClick", function(self)
        _G.ByeByeGryphons_Settings.RightGryphonHidden = self:GetChecked()
        loadSettings()  -- Update settings immediately
    end)
    checkBoxRight:SetChecked(_G.ByeByeGryphons_Settings.RightGryphonHidden)
    checkBoxRight.text = checkBoxRight:CreateFontString(nil, "ARTWORK", "GameFontNormal")
    checkBoxRight.text:SetPoint("LEFT", checkBoxRight, "RIGHT", 8, 0)
    checkBoxRight.text:SetText("Hide Right Gryphon")
end

-- Create the options panel as soon as the addon is loaded
local optionsPanel = createOptionsPanel()

-- Event handling function
frame:SetScript("OnEvent", function(self, event, arg1, ...)
    if event == "ADDON_LOADED" and arg1 == "ByeByeGryphons" then
        updateCheckboxes()  -- Update checkboxes after loading settings
    elseif event == "PLAYER_LOGIN" then
        updateCheckboxes()  -- Update checkboxes after loading settings
        loadSettings()  -- Load settings on login
    elseif event == "PLAYER_LOGOUT" then
        -- Settings are automatically saved by WoW
    end
end)
