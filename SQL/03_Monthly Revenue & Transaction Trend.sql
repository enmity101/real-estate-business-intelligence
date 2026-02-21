-- Monthly Revenue & Transaction Trend

SELECT * FROM realestate_transactions;

UPDATE realestate_transactions
SET Transaction_Date = STR_TO_DATE(Transaction_Date, '%d-%m-%Y');

ALTER TABLE realestate_transactions
MODIFY COLUMN Transaction_Date DATE;

-- Extract Year & Month From Original table

SELECT 
YEAR(transaction_date) transaction_year,
Month(transaction_date) transaction_month,
COUNT(*) total_transaction
FROM `realestate_transactions`
GROUP BY YEAR(transaction_date) , Month(transaction_date)
ORDER BY transaction_year , transaction_month;

-- Monthly Revenue (Booked Only)

SELECT 
YEAR(transaction_date) transaction_year,
Month(transaction_date) transaction_month,
SUM(Effective_Price_INR) total_revenue
FROM `realestate_transactions`
WHERE Booking_Status = 'Booked'
GROUP BY YEAR(transaction_date) , Month(transaction_date)
ORDER BY transaction_year , transaction_month;

-- Monthly Average Sale Price

SELECT 
YEAR(transaction_date) transaction_year,
Month(transaction_date) transaction_month,
AVG(Effective_Price_INR) average_sale_price
FROM `realestate_transactions`
WHERE Booking_Status = 'Booked'
GROUP BY YEAR(transaction_date) , Month(transaction_date)
ORDER BY transaction_year , transaction_month;

-- Increasing transactions + stable price
-- → Demand growth

-- Increasing revenue + rising avg price
-- → Premium shift

-- Falling transactions + high pending
-- → Sales slowdown

-- Revenue spikes in specific months
-- → Seasonal effect







