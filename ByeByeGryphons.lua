local ByeByeGryphons = LibStub("AceAddon-3.0"):NewAddon("ByeByeGryphons", "AceConsole-3.0", "AceEvent-3.0")
local AceConfig = LibStub("AceConfig-3.0")
local AceConfigDialog = LibStub("AceConfigDialog-3.0")

local defaults = {
    profile = {
        LeftGryphonHidden = true,
        RightGryphonHidden = true,
        PrintEnabled = true,
    },
}

local options = {
    name = "Bye Bye Gryphons",
    handler = ByeByeGryphons,
    type = "group",
    args = {
        PrintEnabled = {
            type = "toggle",
            name = "Enable Print Output",
            desc = "Enable or disable print output.",
            get = function(info) return ByeByeGryphons.db.profile.PrintEnabled end,
            set = function(info, value) 
                ByeByeGryphons.db.profile.PrintEnabled = value 
                ByeByeGryphons:LoadSettings()
            end,
        },
        LeftGryphonHidden = {
            type = "toggle",
            name = "Hide Left Gryphon",
            desc = "Hide or show the left gryphon.",
            get = function(info) return ByeByeGryphons.db.profile.LeftGryphonHidden end,
            set = function(info, value) 
                ByeByeGryphons.db.profile.LeftGryphonHidden = value 
                ByeByeGryphons:LoadSettings()
            end,
        },
        RightGryphonHidden = {
            type = "toggle",
            name = "Hide Right Gryphon",
            desc = "Hide or show the right gryphon.",
            get = function(info) return ByeByeGryphons.db.profile.RightGryphonHidden end,
            set = function(info, value) 
                ByeByeGryphons.db.profile.RightGryphonHidden = value 
                ByeByeGryphons:LoadSettings()
            end,
        },
    },
}

function ByeByeGryphons:OnInitialize()
    self.db = LibStub("AceDB-3.0"):New("ByeByeGryphonsDB", defaults, true)
    AceConfig:RegisterOptionsTable("ByeByeGryphons", options)
    self.optionsFrame = AceConfigDialog:AddToBlizOptions("ByeByeGryphons", "Bye Bye Gryphons")
end

function ByeByeGryphons:OnEnable()
    self:RegisterEvent("PLAYER_ENTERING_WORLD", "LoadSettings")
end

function ByeByeGryphons:LoadSettings()
    local settings = self.db.profile
    
    if MainActionBar.EndCaps.LeftEndCap and MainActionBar.EndCaps.RightEndCap then
        if settings.LeftGryphonHidden then
            MainActionBar.EndCaps.LeftEndCap:Hide()
        else
            MainActionBar.EndCaps.LeftEndCap:Show()
        end

        if settings.RightGryphonHidden then
            MainActionBar.EndCaps.RightEndCap:Hide()
        else
            MainActionBar.EndCaps.RightEndCap:Show()
        end
    else
        print("MainActionBar.EndCaps elements not found")
    end

    if settings.PrintEnabled then
        self:Print("Settings applied.")
    end
end
