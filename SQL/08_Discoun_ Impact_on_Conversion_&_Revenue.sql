/*
Discount Impact on Conversion & Revenue
Business Objective

Evaluate whether higher discounts:
Improve conversion rates
Increase or reduce revenue efficiency
Impact deal value
*/
-- Create Discount Buckets
SELECT 
CASE
	WHEN Discount_Offered_Pct = 0 THEN '0%'
	WHEN Discount_Offered_Pct <= 4 THEN '1-4%'
    WHEN Discount_Offered_Pct <= 8 THEN '5-8%'
    WHEN Discount_Offered_Pct <= 10 THEN '9-10%'
ELSE '11%+'
END AS Discount_Bucket,
COUNT(*) TotalLeads
FROM realestate_transactions
GROUP BY Discount_Bucket
ORDER BY Discount_Bucket;

-- Conversion Rate by Discount Bucket
SELECT
CASE
	WHEN Discount_Offered_Pct = 0 THEN '0%'
	WHEN Discount_Offered_Pct <= 4 THEN '1-4%'
    WHEN Discount_Offered_Pct <= 8 THEN '5-8%'
    WHEN Discount_Offered_Pct <= 10 THEN '9-10%'
ELSE '11%+'
END AS Discount_Bucket,
COUNT(*) TotalLeads,
SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) Booked,
ROUND(
		SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) * 100
        / COUNT(*),
        2) Conversion_Rate_Percentage
FROM realestate_transactions
GROUP BY Discount_Bucket
ORDER BY Conversion_Rate_Percentage;

-- Revenue by Discount Bucket
SELECT
CASE
	WHEN Discount_Offered_Pct = 0 THEN '0%'
	WHEN Discount_Offered_Pct <= 4 THEN '1-4%'
    WHEN Discount_Offered_Pct <= 8 THEN '5-8%'
    WHEN Discount_Offered_Pct <= 10 THEN '9-10%'
ELSE '11%+'
END AS Discount_Bucket,
ROUND(SUM(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR ELSE 0 END) , 2) Total_Revenue,
ROUND(AVG(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR ELSE 0 END) , 2) Avg_Deal_Value
FROM realestate_transactions
GROUP BY Discount_Bucket
ORDER BY Total_Revenue DESC;

-- Revenue per Deal
SELECT
CASE
	WHEN Discount_Offered_Pct = 0 THEN '0%'
	WHEN Discount_Offered_Pct <= 4 THEN '1-4%'
    WHEN Discount_Offered_Pct <= 8 THEN '5-8%'
    WHEN Discount_Offered_Pct <= 10 THEN '9-10%'
ELSE '11%+'
END AS Discount_Bucket,
COUNT(*) TotalLeads,
SUM(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR  ELSE 0 END) Total_Revenue_INR,
ROUND(
		SUM(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR  ELSE 0 END)
        / COUNT(*),
        0) Revenue_Per_Deal_INR
FROM realestate_transactions
GROUP BY Discount_Bucket
ORDER BY Revenue_Per_Deal_INR DESC;

/*
Business Interpretation Framework

Higher Discount + Higher Conversion
→ Effective incentive

Higher Discount + Lower Revenue per Deal
→ Margin erosion

Low Discount + High Revenue per Deal
→ Premium pricing power

Optimal Bucket
→ Best balance of conversion + revenue
*/




