-- ====================================================================
-- Project 3: Healthcare Supply Chain & Inventory Optimization System
-- Description: Advanced SQL script for stockout risk auditing, reorder 
--              point triggers, expired batch detection, and valuation.
-- ====================================================================

-- 1. Create Healthcare Inventory Table
CREATE TABLE healthcare_inventory (
    ItemID VARCHAR(20) PRIMARY KEY,
    ItemName VARCHAR(100),
    Category VARCHAR(50),
    Location VARCHAR(50),
    Supplier VARCHAR(100),
    CurrentStock INT,
    ReorderLevel INT,
    UnitCost DECIMAL(10,2),
    TotalStockValue DECIMAL(12,2),
    MonthlyDemand INT,
    LeadTimeDays INT,
    ExpiryDate DATE,
    StockStatus VARCHAR(20)
);

-- 2. Identify Critical Reorder Needed & Out of Stock Items
SELECT 
    ItemID,
    ItemName,
    Category,
    Location,
    CurrentStock,
    ReorderLevel,
    Supplier,
    StockStatus
FROM healthcare_inventory
WHERE CurrentStock <= ReorderLevel
ORDER BY CurrentStock ASC;

-- 3. Expired & Near-Expiry Product Audit (Risk Management)
SELECT 
    ItemID,
    ItemName,
    Category,
    CurrentStock,
    TotalStockValue,
    ExpiryDate,
    CASE 
        WHEN ExpiryDate < CURRENT_DATE THEN 'EXPIRED'
        WHEN ExpiryDate BETWEEN CURRENT_DATE AND (CURRENT_DATE + INTERVAL '30' DAY) THEN 'EXPIRING SOON'
        ELSE 'HEALTHY'
    END AS ExpiryRiskStatus
FROM healthcare_inventory
WHERE ExpiryDate <= (CURRENT_DATE + INTERVAL '30' DAY)
ORDER BY ExpiryDate ASC;

-- 4. Category-Wise Inventory Valuation & Stock Health Summary
SELECT 
    Category,
    COUNT(ItemID) AS TotalProducts,
    SUM(CurrentStock) AS TotalUnitsInHand,
    ROUND(SUM(TotalStockValue), 2) AS CategoryValuation,
    COUNT(CASE WHEN CurrentStock <= ReorderLevel THEN 1 END) AS ReorderAlertCount
FROM healthcare_inventory
GROUP BY Category
ORDER BY CategoryValuation DESC;