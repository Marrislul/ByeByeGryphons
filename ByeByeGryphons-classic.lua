--Local function to set the variables
local function loadSettings(self, event, ...)
	MainMenuBarLeftEndCap:Hide() --left
	MainMenuBarRightEndCap:Hide() --right
end

--Create frame, needed for trigger & changing the variables.
local frame = CreateFrame("Frame")
--Trigger for event, entering the world in this case.
frame:RegisterEvent("PLAYER_ENTERING_WORLD")
--Loads settings one the event is triggered.
frame:SetScript("OnEvent", loadSettings)
--Prints info (personal preference). If you check this code and don't want this, just remove it.
print("Bye Bye Gryphons: Gryphons removed.")