-- WoW Farmer Session Manager Lua File
-- This file handles the logic for managing farming sessions, including starting, pausing, and stopping sessions.

-- Declare the SessionManager table
SessionManager = {}

-- Start a new farming session
function SessionManager:Start()
    if self.startTime then
        print("A session is already active.")
        return
    end
    
    self.startTime = GetTime()  -- Record the current time as the start time
    self.totalTimePaused = 0    -- Initialize total paused time to zero
    self.isPaused = false       -- Session is active, not paused
    self.pauseStartTime = nil   -- Reset pause start time
    
    print("Farming session started.")
end

-- Pause the current farming session
function SessionManager:Pause()
    if not self.startTime then
        print("No active session to pause.")
        return
    end
    
    if self.isPaused then
        print("Session is already paused.")
        return
    end
    
    self.isPaused = true
    self.pauseStartTime = GetTime()  -- Record the time when the session was paused
    
    print("Farming session paused.")
end

-- Resume a paused farming session
function SessionManager:Resume()
    if not self.startTime then
        print("No active session to resume.")
        return
    end
    
    if not self.isPaused then
        print("Session is not paused.")
        return
    end
    
    local pausedDuration = GetTime() - self.pauseStartTime  -- Calculate how long the session was paused
    self.totalTimePaused = self.totalTimePaused + pausedDuration
    self.isPaused = false
    self.pauseStartTime = nil
    
    print("Farming session resumed.")
end

-- Stop the current farming session
function SessionManager:Stop()
    if not self.startTime then
        print("No active session to stop.")
        return
    end
    
    local endTime = GetTime()  -- Record the current time as the end time
    local totalSessionTime = endTime - self.startTime  -- Calculate the total session time
    
    if self.isPaused then
        -- If the session was paused when stopped, adjust the total time
        totalSessionTime = totalSessionTime - (endTime - self.pauseStartTime)
    end
    
    local activeTime = totalSessionTime - self.totalTimePaused  -- Calculate the active farming time
    
    print("Farming session stopped. Total active time: " .. activeTime .. " seconds.")
    
    -- Reset session variables
    self.startTime = nil
    self.totalTimePaused = 0
    self.isPaused = false
    self.pauseStartTime = nil
end

-- Utility function to get the current session duration
function SessionManager:GetSessionDuration()
    if not self.startTime then
        return 0
    end
    
    local currentTime = GetTime()
    local totalSessionTime = currentTime - self.startTime
    
    if self.isPaused then
        totalSessionTime = totalSessionTime - (currentTime - self.pauseStartTime)
    end
    
    return totalSessionTime - self.totalTimePaused
end

-- Add comments to explain each function
-- The Start function begins a new session, recording the start time.
-- The Pause function pauses the session and records the time at which it was paused.
-- The Resume function resumes a paused session and calculates the paused duration.
-- The Stop function ends the session and calculates the total active time.
-- The GetSessionDuration function returns the total elapsed time, accounting for pauses.
