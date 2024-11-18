-- WoW Farmer Data Manager Lua File
-- This file handles the management of data, including saving, loading, and calculating moving averages for farming drop rates.

-- Require DefaultData
require("DefaultData")

-- Declare the DataManager table
DataManager = {}

-- Load SavedVariables
function DataManager:Load()
    if not WoWFarmerCharSaved then
        -- Create a new data table for the character and copy the default drop rates
        WoWFarmerCharSaved = {
            dropRates = {},
            sessions = {}
        }

        -- Copy pre-populated data from DefaultData.lua
        for itemID, itemInfo in pairs(DefaultData.items) do
            WoWFarmerCharSaved.dropRates[itemID] = {
                sessions = {},
                movingAverage = itemInfo.defaultDropRate
            }
        end

        print("WoW Farmer data initialized with default values.")
    end

    self.data = WoWFarmerCharSaved
    print("WoW Farmer data loaded for the character.")
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
    local itemData = DefaultData.items[itemID]
    if itemData then
        return itemData.defaultDropRate
    else
        return 0  -- Return 0 if the item is not found in the default data
    end
end

-- Utility function to clear session data (for testing or resetting purposes)
function DataManager:ClearData()
    self.data.dropRates = {}
    print("All session data cleared.")
end

return DataManager
