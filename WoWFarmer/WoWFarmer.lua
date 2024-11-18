-- WoW Farmer Main Lua File
-- This is the core logic file for the WoW Farmer add-on.
-- It initializes the add-on, handles UI interactions, and manages session tracking.

-- Declare the main table for WoW Farmer
WoWFarmer = {}

-- OnLoad function to initialize the add-on when it's loaded
function WoWFarmer_OnLoad(self)
    print("WoW Farmer loaded successfully!")
    WoWFarmer.frame = self
    
    -- Register events
    self:RegisterEvent("ADDON_LOADED")
    self:RegisterEvent("PLAYER_ENTERING_WORLD")
end

-- OnEvent function to handle events
function WoWFarmer_OnEvent(self, event, ...)
    if event == "ADDON_LOADED" then
        local addonName = ...
        if addonName == "WoWFarmer" then
            WoWFarmer:Initialize()
        end
    elseif event == "PLAYER_ENTERING_WORLD" then
        -- Additional initialization if needed when player enters the world
    end
end

-- Initialize function to set up saved variables and prepare the add-on
function WoWFarmer:Initialize()
    -- Load saved variables
    if not WoWFarmerSaved then
        WoWFarmerSaved = {}
    end
    
    -- Load character-specific saved variables
    if not WoWFarmerCharSaved then
        WoWFarmerCharSaved = {}
    end
    
    -- Initialize other components if needed
    print("WoW Farmer initialized.")
end

-- Function to start a farming session
function WoWFarmer_StartSession()
    print("Session started!")
    -- Call SessionManager to handle session start logic
    SessionManager:Start()
end

-- Function to pause a farming session
function WoWFarmer_PauseSession()
    print("Session paused!")
    -- Call SessionManager to handle session pause logic
    SessionManager:Pause()
end

-- Function to stop a farming session
function WoWFarmer_StopSession()
    print("Session stopped!")
    -- Call SessionManager to handle session stop logic
    SessionManager:Stop()
end

-- Create the main frame and set up scripts
local frame = CreateFrame("Frame", "WoWFarmerMainFrame", UIParent)
frame:SetScript("OnLoad", WoWFarmer_OnLoad)
frame:SetScript("OnEvent", WoWFarmer_OnEvent)

-- Assign global functions to be used in XML
WoWFarmer_OnLoad = WoWFarmer_OnLoad
WoWFarmer_StartSession = WoWFarmer_StartSession
WoWFarmer_PauseSession = WoWFarmer_PauseSession
WoWFarmer_StopSession = WoWFarmer_StopSession

-- Add comments to explain each section of the code
-- The above code initializes the add-on, registers events, and provides functions for starting, pausing, and stopping sessions.
-- Each function is responsible for calling appropriate methods from other modules, such as SessionManager, to manage the state of the farming session.
