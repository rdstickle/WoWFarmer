-- WoW Farmer Settings Manager Lua File
-- This file handles loading, saving, and applying settings for the WoW Farmer add-on.

-- Declare the SettingsManager table
SettingsManager = {}

-- Default settings values
local defaultSettings = {
    undercutPercentage = 15,    -- Max undercut percentage
    baseUndercutValue = 5       -- Base undercut in copper
}

-- Load Settings from SavedVariables
function SettingsManager:Load()
    if not WoWFarmerSaved then
        WoWFarmerSaved = {}
    end

    -- Initialize settings with defaults if they are missing
    self.settings = WoWFarmerSaved.settings or {}

    for key, value in pairs(defaultSettings) do
        if self.settings[key] == nil then
            self.settings[key] = value
        end
    end

    -- Save back the settings (in case any defaults were missing)
    WoWFarmerSaved.settings = self.settings
    print("WoW Farmer settings loaded.")
end

-- Save Settings to SavedVariables
function SettingsManager:Save()
    WoWFarmerSaved.settings = self.settings
    print("WoW Farmer settings saved.")
end

-- Set a specific setting value
function SettingsManager:SetSetting(key, value)
    if self.settings[key] ~= nil then
        self.settings[key] = value
        print("Setting updated: " .. key .. " set to " .. tostring(value))
    else
        print("Invalid setting key: " .. key)
    end
end

-- Get a specific setting value
function SettingsManager:GetSetting(key)
    return self.settings[key] or defaultSettings[key]
end

-- Apply Settings (e.g., after saving)
function SettingsManager:ApplySettings()
    -- Here you can add any logic needed to apply settings to other parts of the add-on
    print("Applying settings...")
end

-- Utility function to handle settings UI interaction
function SettingsManager:SaveFromUI()
    local undercutValue = WoWFarmerUndercutSlider:GetValue()
    self:SetSetting("undercutPercentage", undercutValue)

    -- Save the settings after updating them
    self:Save()
    self:ApplySettings()

    WoWFarmer_HideSettings()
end

return SettingsManager
