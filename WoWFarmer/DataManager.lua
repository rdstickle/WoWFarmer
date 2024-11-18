-- WoW Farmer Data Manager Lua File
-- This file handles the management of data, including saving, loading, and calculating moving averages for farming drop rates.

-- Declare the DataManager table
DataManager = {}

-- Load SavedVariables
function DataManager:Load()
    if not WoWFarmerSaved then
        WoWFarmerSaved = {
            dropRates = {},
            sessions = {}
        }
    end
    self.data = WoWFarmerSaved
    print("WoW Farmer data loaded.")
end

-- Save session data to update drop rates
function DataManager:SaveSession(itemID, stacksCollected, sessionTime)
    local itemData = self.data.dropRates[itemID] or {sessions = {}, movingAverage = 0}

    -- Calculate the drop rate for the current session
    local dropRate = stacksCollected / (sessionTime / 3600)  -- stacks per hour
    table.insert(itemData.sessions, dropRate)

    -- Limit to a 5-period moving average
    if #itemData.sessions > 5 then
        table.remove(itemData.sessions, 1)
    end

    -- Update moving average
    local total = 0
    for _, rate in ipairs(itemData.sessions) do
        total = total + rate
    end
    itemData.movingAverage = total / #itemData.sessions

    self.data.dropRates[itemID] = itemData
    print("Session data saved for item ID: " .. itemID .. ". New moving average: " .. itemData.movingAverage .. " stacks/hour.")
end

-- Get the drop rate for an item
function DataManager:GetDropRate(itemID)
    local itemData = self.data.dropRates[itemID]
    if itemData then
        return itemData.movingAverage
    else
        return self:GetDefaultDropRate(itemID)
    end
end

-- Get the default drop rate for an item (used if no player data is available)
function DataManager:GetDefaultDropRate(itemID)
    -- Placeholder for default drop rates
    local defaultRates = {
        [2589] = 15,  -- Linen Cloth: 15 stacks per hour
        [2592] = 8,   -- Wool Cloth: 8 stacks per hour
    }
    return defaultRates[itemID] or 0
end

-- Utility function to clear session data (for testing or resetting purposes)
function DataManager:ClearData()
    self.data.dropRates = {}
    print("All session data cleared.")
end

-- Add comments to explain each function
-- The Load function initializes the data by loading it from SavedVariables.
-- The SaveSession function records the current session's data, updating the moving average for an item.
-- The GetDropRate function returns the current moving average for an item, falling back on default values if needed.
-- The GetDefaultDropRate function provides a default drop rate if no player-specific data is available.
-- The ClearData function allows resetting all stored session data, useful for testing or starting fresh.
