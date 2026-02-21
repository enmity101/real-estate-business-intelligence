-- Revenue Performance by Location & Tier

/* Business Objective

Identify high-performing micro-markets based on:

Revenue contribution
Booking efficiency
Pricing strength */

-- Transactions by Location & Tier
SELECT Location,
Location_Tier,
COUNT(*) Total_transaction
FROM realestate_transactions
GROUP BY Location,Location_Tier
ORDER BY Total_transaction DESC;

-- Booked Transactions (Demand Strength)
SELECT Location,
Location_Tier,
COUNT(*) Total_transaction
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Location,Location_Tier
ORDER BY Total_transaction DESC;

-- Booking Rate by Location
SELECT Location,
Location_Tier,
SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) Booked,
ROUND(SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) * 100 / COUNT(*), 2) Booking_Rate_Percent
FROM realestate_transactions
GROUP BY Location,Location_Tier
ORDER BY Booking_Rate_Percent DESC;

-- Revenue by Location
SELECT Location,
Location_Tier,
SUM(Effective_Price_INR) Total_Revenue
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Location,Location_Tier
ORDER BY Total_Revenue DESC;

-- Average Price by Location
SELECT Location,
Location_Tier,
AVG(Effective_Price_INR) avg_price
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Location,Location_Tier
ORDER BY avg_price DESC;

/* High Booking Rate + High Revenue
→ Prime performing location

High Revenue + Low Booking Rate
→ High-value but slow-moving inventory

Low Revenue + High Booking Rate
→ Affordable, high-demand segment

High Avg Price
→ Premium market cluster */













