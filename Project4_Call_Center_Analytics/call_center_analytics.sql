-- ====================================================================
-- Project 4: Call Center Operations & CSAT Analytics
-- Description: SQL queries for First Call Resolution (FCR), Average Handling Time (AHT), 
--              Agent Efficiency, and Customer Sentiment Analysis.
-- ====================================================================

-- 1. Create Call Center Table
CREATE TABLE call_center_logs (
    CallID VARCHAR(20) PRIMARY KEY,
    AgentID VARCHAR(20),
    CallDate DATE,
    Channel VARCHAR(20),
    Topic VARCHAR(50),
    CallCenter VARCHAR(50),
    DurationMinutes DECIMAL(5,2),
    CSATScore INT,
    IsResolved VARCHAR(5),
    Sentiment VARCHAR(20)
);

-- 2. Overall KPI Summary Metrics
SELECT 
    COUNT(CallID) AS TotalCalls,
    ROUND(AVG(CSATScore), 2) AS AverageCSAT,
    ROUND(AVG(DurationMinutes), 2) AS AvgHandlingTimeMinutes,
    ROUND((COUNT(CASE WHEN IsResolved = 'Yes' THEN 1 END) * 100.0 / COUNT(CallID)), 2) AS ResolutionRatePercentage
FROM call_center_logs;

-- 3. Agent Performance Scorecard (FCR & CSAT Leaderboard)
SELECT 
    AgentID,
    COUNT(CallID) AS TotalCallsHandled,
    ROUND(AVG(CSATScore), 2) AS AvgCSAT,
    ROUND(AVG(DurationMinutes), 2) AS AvgDurationMinutes,
    ROUND((COUNT(CASE WHEN IsResolved = 'Yes' THEN 1 END) * 100.0 / COUNT(CallID)), 2) AS FCRPercentage
FROM call_center_logs
GROUP BY AgentID
HAVING COUNT(CallID) >= 50
ORDER BY AvgCSAT DESC;

-- 4. Channel & Topic Breakdown Analysis
SELECT 
    Channel,
    Topic,
    COUNT(CallID) AS CallVolume,
    ROUND(AVG(CSATScore), 2) AS AvgCSAT,
    ROUND(AVG(DurationMinutes), 2) AS AvgAHT
FROM call_center_logs
GROUP BY Channel, Topic
ORDER BY CallVolume DESC;