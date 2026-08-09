-- ====================================================================
-- Project 2: Financial Expenses Audit & Anomaly Detection Pipeline
-- Description: Advanced SQL script for detecting high-risk expense anomalies,
--              duplicate transactions, policy violations (> $10k), and department analytics.
-- ====================================================================

-- 1. Create Financial Expenses Table
CREATE TABLE financial_expenses (
    ExpenseID VARCHAR(20) PRIMARY KEY,
    EmployeeID VARCHAR(20),
    Department VARCHAR(50),
    ExpenseType VARCHAR(50),
    Vendor VARCHAR(100),
    Amount DECIMAL(10,2),
    ExpenseDate DATE,
    ApprovalStatus VARCHAR(20)
);

-- 2. Detect Extreme High-Risk Policy Violations (> $10,000 Threshold)
SELECT 
    ExpenseID,
    EmployeeID,
    Department,
    Vendor,
    Amount,
    ExpenseDate,
    'Policy Violation: Over $10,000 Limit' AS AnomalyFlag
FROM financial_expenses
WHERE Amount > 10000.00
ORDER BY Amount DESC;

-- 3. Detect Potential Duplicate Claims (Same Employee, Amount, Vendor & Date)
SELECT 
    EmployeeID,
    Vendor,
    Amount,
    ExpenseDate,
    COUNT(*) AS DuplicateCount
FROM financial_expenses
GROUP BY EmployeeID, Vendor, Amount, ExpenseDate
HAVING COUNT(*) > 1
ORDER BY DuplicateCount DESC;

-- 4. Department-Wise Expense & Risk Audit Summary
SELECT 
    Department,
    COUNT(ExpenseID) AS TotalTransactions,
    SUM(Amount) AS TotalSpend,
    ROUND(AVG(Amount), 2) AS AverageExpense,
    COUNT(CASE WHEN Amount > 10000 THEN 1 END) AS HighRiskAnomalyCount,
    ROUND(SUM(CASE WHEN Amount > 10000 THEN Amount ELSE 0 END), 2) AS HighRiskTotalExposure
FROM financial_expenses
GROUP BY Department
ORDER BY TotalSpend DESC;

-- 5. Vendor Anomaly Audit (Detect High-Spend & Unknown Vendors)
SELECT 
    Vendor,
    COUNT(ExpenseID) AS ClaimCount,
    SUM(Amount) AS TotalVendorSpend,
    COUNT(CASE WHEN Amount > 10000 THEN 1 END) AS OutlierClaims
FROM financial_expenses
GROUP BY Vendor
ORDER BY TotalVendorSpend DESC;