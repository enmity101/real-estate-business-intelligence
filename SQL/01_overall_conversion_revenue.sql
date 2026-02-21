-- Overall Booking Conversion & Revenue Performance

-- Total Lead
SELECT
 	COUNT(*) 
FROM realestate_transactions;

-- Booking Status Distribution
SELECT 
	Booking_status,
	COUNT(*) as current_status
FROM realestate_transactions
GROUP BY booking_status;

-- Conversion Rate 
SELECT 
	SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) * 100.0
	/ COUNT(*)  Conversion_Rate_Percentage
FROM realestate_transactions;

-- Total Revenue (Only Booked Deals)
SELECT
	SUM(Effective_Price_INR) as Total_Revenue
FROM realestate_transactions
WHERE Booking_Status = 'Booked';

-- Average Deal Value
SELECT
	AVG(Effective_Price_INR) as Avg_Deal_Value
FROM realestate_transactions
WHERE Booking_Status = 'Booked';