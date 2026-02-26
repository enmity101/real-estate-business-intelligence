# Time-to-Close Analysis (Sales Cycle Efficiency)
/*
Business Objective

Identify sales cycle efficiency and detect bottlenecks across:

Property types
Booking status
Deal timelines
*/

SELECT * FROM realestate_transactions;

-- Overall Average Time to Close
SELECT 
AVG(Time_to_Close_Days)  Avg_days_to_close
FROM realestate_transactions
WHERE Booking_status = 'Booked';

-- Time to Close by Property Type
SELECT
    Property_Type,
    AVG(Time_to_Close_Days) AS Avg_Days_To_Close
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Property_Type
ORDER BY Avg_Days_To_Close DESC;

-- Min / Max / Avg Days (Detailed View)
SELECT 
Property_Type,
COUNT(*) Total_Deal,
MIN(Time_to_Close_Days) Min_Days,
MAX(Time_to_Close_Days) Max_Days,
AVG(Time_to_Close_Days) Avg_Days
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Property_Type
ORDER BY Avg_Days DESC;

-- Time to Close by Booking Status
SELECT
    Booking_Status,
    COUNT(*) AS Count_Deals,
    AVG(Time_to_Close_Days) AS Avg_Days
FROM realestate_transactions
GROUP BY Booking_Status;

-- Aging Bucket Analysis
SELECT
    CASE
        WHEN Time_to_Close_Days <= 30 THEN '0-30 Days'
        WHEN Time_to_Close_Days <= 60 THEN '31-60 Days'
        WHEN Time_to_Close_Days <= 90 THEN '61-90 Days'
        ELSE '90+ Days'
    END AS Time_Bucket,
    COUNT(*) AS Total_Deals,
    SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) AS Booked,
    SUM(CASE WHEN Booking_Status = 'Pending' THEN 1 ELSE 0 END) AS Pending,
    SUM(CASE WHEN Booking_Status = 'Lost' THEN 1 ELSE 0 END) AS Lost
FROM realestate_transactions
GROUP BY Time_Bucket
ORDER BY Time_Bucket;