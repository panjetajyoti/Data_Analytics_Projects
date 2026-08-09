-- ====================================================================
-- Project 1: E-Commerce Customer Churn & RFM Loyalty Analytics
-- Author: Jyoti
-- Description: Advanced SQL Pipeline using CTEs and Window Functions
-- ====================================================================

-- Step 1: Base Metrics Calculation (Recency, Frequency, Monetary)
WITH Customer_RFM_Base AS (
    SELECT 
        CustomerID,
        DATEDIFF('2026-08-01', MAX(OrderDate)) AS Recency_Days,
        COUNT(DISTINCT InvoiceNo) AS Frequency,
        ROUND(SUM(TotalAmount), 2) AS Monetary
    FROM ecommerce_transactions
    GROUP BY CustomerID
),

-- Step 2: Assign RFM Scores (1 to 4 Scale) using NTILE Window Function
RFM_Scores AS (
    SELECT 
        CustomerID,
        Recency_Days,
        Frequency,
        Monetary,
        NTILE(4) OVER (ORDER BY Recency_Days DESC) AS R_Score,
        NTILE(4) OVER (ORDER BY Frequency ASC) AS F_Score,
        NTILE(4) OVER (ORDER BY Monetary ASC) AS M_Score
    FROM Customer_RFM_Base
),

-- Step 3: Combined RFM Score and Customer Segmentation
RFM_Segmented AS (
    SELECT 
        CustomerID,
        Recency_Days,
        Frequency,
        Monetary,
        R_Score,
        F_Score,
        M_Score,
        (R_Score + F_Score + M_Score) AS Total_RFM_Score,
        CASE 
            WHEN R_Score = 4 AND F_Score = 4 AND M_Score = 4 THEN 'Champions'
            WHEN R_Score >= 3 AND F_Score >= 3 THEN 'Loyal Customers'
            WHEN R_Score <= 2 AND F_Score >= 3 THEN 'At-Risk (High Churn Risk)'
            WHEN R_Score = 1 THEN 'Lost Customers'
            ELSE 'Potential Loyalists'
        END AS Customer_Segment
    FROM RFM_Scores
)

-- Step 4: Executive Summary Output
SELECT 
    Customer_Segment,
    COUNT(CustomerID) AS Total_Customers,
    ROUND(AVG(Recency_Days), 1) AS Avg_Recency_Days,
    ROUND(AVG(Frequency), 1) AS Avg_Frequency,
    ROUND(AVG(Monetary), 2) AS Avg_Monetary_Spend,
    ROUND(SUM(Monetary), 2) AS Segment_Revenue
FROM RFM_Segmented
GROUP BY Customer_Segment
ORDER BY Segment_Revenue DESC;