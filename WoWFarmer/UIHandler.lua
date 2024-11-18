-- WoW Farmer UI Handler Lua File
-- This file handles all UI interactions for the WoW Farmer add-on, including updating tables and managing user inputs.

-- Declare the UIHandler table
UIHandler = {}

-- Function to initialize the UI elements
function UIHandler:Initialize()
    -- Get references to the UI elements defined in XML
    self.frame = _G["WoWFarmerFrame"]
    self.startButton = _G["WoWFarmerStartButton"]
    self.pauseButton = _G["WoWFarmerPauseButton"]
    self.stopButton = _G["WoWFarmerStopButton"]
    self.scrollFrame = _G["WoWFarmerScrollFrame"]
    self.tableContainer = _G["WoWFarmerTable"]
    
    -- Set up button scripts
    self.startButton:SetScript("OnClick", function() WoWFarmer_StartSession() end)
    self.pauseButton:SetScript("OnClick", function() WoWFarmer_PauseSession() end)
    self.stopButton:SetScript("OnClick", function() WoWFarmer_StopSession() end)

    print("WoW Farmer UI initialized.")
end

-- Function to update the table with farming data
function UIHandler:UpdateTable(data)
    -- Clear existing content in the table container
    for _, child in ipairs({self.tableContainer:GetChildren()}) do
        child:Hide()
    end

    -- Populate the table with updated data
    local previousRow
    for i, item in ipairs(data) do
        local row = self.tableContainer:CreateFontString(nil, "OVERLAY", "GameFontNormalSmall")
        row:SetText(item.name .. " - " .. item.marketPrice .. "g per stack - " .. item.stacksPerHour .. " stacks/hour - " .. item.earningsPerHour .. "g/hour")
        
        if previousRow then
            row:SetPoint("TOPLEFT", previousRow, "BOTTOMLEFT", 0, -5)
        else
            row:SetPoint("TOPLEFT", self.tableContainer, "TOPLEFT", 10, -10)
        end
        
        row:Show()
        previousRow = row
    end
end

-- Function to handle UI scaling adjustments
function UIHandler:AdjustScaling()
    -- Adjust the scale of the UI frame based on the player's current UI scale
    local uiScale = UIParent:GetScale()
    self.frame:SetScale(uiScale)
end

-- Utility function to show or hide the main frame
function UIHandler:ToggleVisibility()
    if self.frame:IsShown() then
        self.frame:Hide()
    else
        self.frame:Show()
    end
end

-- Register a frame for handling UI events like scaling
local scaleFrame = CreateFrame("Frame")
scaleFrame:RegisterEvent("UI_SCALE_CHANGED")
scaleFrame:SetScript("OnEvent", function()
    UIHandler:AdjustScaling()
end)

-- Add comments to explain each section of the code
-- The Initialize function sets up references to UI elements and assigns button click handlers.
-- The UpdateTable function dynamically updates the UI table with current farming data.
-- The AdjustScaling function adjusts the scale of the UI to match the player's UI scale settings.
-- The ToggleVisibility function allows the user to show or hide the main frame easily.
