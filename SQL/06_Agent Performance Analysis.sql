# Agent Performance Analysis

/*
Business Objective:

Evaluate agent effectiveness based on:
Revenue generation
Deal size
Sales efficiency (speed)
*/


SELECT * FROM realestate_transactions;

-- Transactions by Agent

SELECT 
Agent_ID,
Agent_Name,
COUNT(*) Total_transaction
FROM realestate_transactions
GROUP BY Agent_ID, Agent_Name
ORDER BY Total_transaction DESC;

-- Booked Deals by Agent
SELECT 
Agent_ID,
Agent_Name,
COUNT(*) Total_transaction
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Agent_ID, Agent_Name
ORDER BY Total_transaction DESC;

-- Total Revenue by Agent
SELECT 
Agent_ID,
Agent_Name,
SUM(Effective_Price_INR) Total_Revenue
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Agent_ID, Agent_Name
ORDER BY Total_Revenue DESC;

-- Average Deal Value
SELECT 
Agent_ID,
Agent_Name,
AVG(Effective_Price_INR) Avg_Deal_Value_INR
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Agent_ID, Agent_Name
ORDER BY Avg_Deal_Value DESC;

-- Average Days to Close (Efficiency)
SELECT 
Agent_ID,
Agent_Name,
AVG(Time_to_Close_Days) Avg_Day_to_close
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Agent_ID, Agent_Name
ORDER BY Avg_Day_to_close ;

-- Estimated Commission Earned
SELECT 
Agent_ID,
Agent_Name,
ROUND(SUM(Effective_Price_INR * Agent_Commission_Pct / 100.0) , 2) AS Estimated_Commission
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Agent_ID, Agent_Name
ORDER BY Estimated_Commission DESC;

-- Combined Agent Performance View
SELECT
    Agent_ID,
    Agent_Name,

    COUNT(*) AS Total_Transactions,

    SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) AS Booked_Deals,

    ROUND(
        SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) * 100.0
        / COUNT(*),
        2
    ) AS Conversion_Rate_Percent,

    SUM(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR ELSE 0 END)
        AS Total_Revenue_INR,

    AVG(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR END)
        AS Avg_Deal_Value_INR,

    AVG(CASE WHEN Booking_Status = 'Booked' THEN Time_to_Close_Days END)
        AS Avg_Days_To_Close

FROM realestate_transactions
GROUP BY Agent_ID, Agent_Name
ORDER BY Total_Revenue_INR DESC;

/*
High Revenue + High Conversion
→ Top performer

High Revenue + Low Conversion
→ Works on high-value deals

Low Revenue + Fast Closing
→ Volume-driven agent

Slow Closing + Low Conversion
→ Underperformer
*/
