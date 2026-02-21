-- Lead Source Conversion & Revenue Efficiency

-- Total Leads by Lead Source
SELECT * FROM realestate_transactions;
SELECT * FROM lead_source_analysis;

SELECT 
Lead_Source,
Total_Leads
FROM lead_source_analysis
ORDER BY Total_Leads DESC;

-- OR

SELECT
Lead_Source,
COUNT(*) Total_Leads
FROM realestate_transactions
GROUP BY Lead_Source
ORDER BY Total_Leads DESC;

-- Booked Deals by Lead Source

SELECT 
Lead_Source,
COUNT(*) Total_Leads
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Lead_Source
ORDER BY Total_Leads DESC;

-- OR
SELECT * FROM lead_source_analysis;
SELECT 
Lead_Source,
Total_Leads,
Booked
FROM lead_source_analysis
ORDER BY Booked DESC;

-- Conversion Rate by Lead Source
SELECT * FROM realestate_transactions;

SELECT Lead_Source,
COUNT(*) Total_Leads,
SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) Booked,
ROUND(SUM(CASE WHEN Booking_Status = 'Booked' THEN 1 ELSE 0 END) * 100.0 
/ COUNT(*), 2) Conversion_Rate_Percent
FROM realestate_transactions
GROUP BY Lead_Source
ORDER BY Conversion_Rate_Percent DESC;

-- Revenue by Lead Source
SELECT 
Lead_Source,
SUM(Effective_Price_INR) as Total_Revenue
FROM realestate_transactions
WHERE Booking_Status = 'Booked'
GROUP BY Lead_Source
ORDER BY Total_Revenue DESC;

-- Revenue per Lead (Key Metric)

SELECT 
Lead_Source,
ROUND(SUM(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR ELSE 0 END) , 0 )
Total_Revenue,
ROUND(SUM(CASE WHEN Booking_Status = 'Booked' THEN Effective_Price_INR ELSE 0 END) / COUNT(*) , 0)
Revenue_per_Lead
FROM realestate_transactions
GROUP BY Lead_Source
order by Revenue_per_Lead DESC;

/*
High Leads + Low Conversion
→ Poor lead quality

Low Leads + High Conversion
→ High-quality channel

High Revenue per Lead
→ Most efficient marketing source

High Revenue + High Conversion
→ Scale this channel
*/

















