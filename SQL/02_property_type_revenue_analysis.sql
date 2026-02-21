
-- Revenue Performance by Property Type

-- Total Transactions by Property Type
SELECT 
	Property_type,
	Count(*) Total_Transactions
FROM realestate_transactions
GROUP BY Property_Type
Order by 2 DESC;

-- Revenue by Property Type
SELECT 
	Property_Type,
	SUM(Effective_Price_INR) Total_Revenue
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Property_Type
ORDER BY Total_Revenue DESC;

-- Average Sale Price by Property Type
SELECT 
	Property_Type,
	AVG(Effective_Price_INR) Total_Revenue
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Property_Type
ORDER BY Total_Revenue DESC;

-- Median Sale Price
WITH RankedData AS (
    SELECT
        Property_Type,
        Effective_Price_INR,
        ROW_NUMBER() OVER (
            PARTITION BY Property_Type
            ORDER BY Effective_Price_INR
        ) AS rn,
        COUNT(*) OVER (
            PARTITION BY Property_Type
        ) AS cnt
    FROM realestate_transactions
    WHERE Booking_Status = 'Booked'
)

SELECT
    Property_Type,
    AVG(Effective_Price_INR) AS Median_Sale_Price
FROM RankedData
WHERE rn IN (FLOOR((cnt + 1) / 2), FLOOR((cnt + 2) / 2))
GROUP BY Property_Type;