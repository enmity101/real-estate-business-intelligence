-- ============================================================
-- Table: Realstate Transaction
-- Modify column datatypes for consistency
-- ============================================================

-- Step 1: Add a temporary DATE column
ALTER TABLE realestate_transactions
ADD COLUMN Transaction_Date_clean DATE;

-- Step 2: Convert text 'DD-MM-YYYY' into proper DATE
UPDATE realestate_transactions
SET Transaction_Date_clean = STR_TO_DATE(Transaction_Date, '%d-%m-%Y');

-- Step 3: Drop old column and rename the clean one
ALTER TABLE realestate_transactions
DROP COLUMN Transaction_Date,
CHANGE COLUMN Transaction_Date_clean Transaction_Date DATE;

-- Step 4: Verify column type
ALTER TABLE realestate_transactions
MODIFY COLUMN Transaction_Date DATE;

-- Step 5: Query with formatted output (DD-MM-YYYY)
SELECT DATE_FORMAT(Transaction_Date, '%d-%m-%Y') AS Transaction_Date
FROM realestate_transactions
LIMIT 10;

-- Modified every Data Type in realestate_transactions table

ALTER TABLE realestate_transactions
MODIFY COLUMN Transaction_ID VARCHAR(30),
MODIFY COLUMN Property_ID VARCHAR(30),
MODIFY COLUMN Property_Type VARCHAR(50),
MODIFY COLUMN Location VARCHAR(100),
MODIFY COLUMN Location_Tier VARCHAR(20),
MODIFY COLUMN Property_Size_sqft DECIMAL(10,2),
MODIFY COLUMN Sale_Price_INR DECIMAL(15,2),
MODIFY COLUMN Agent_ID VARCHAR(20),
MODIFY COLUMN Agent_Name VARCHAR(100),
MODIFY COLUMN Lead_Source VARCHAR(50),
MODIFY COLUMN Client_Type VARCHAR(50),
MODIFY COLUMN Booking_Status VARCHAR(20),
MODIFY COLUMN Time_to_Close_Days INT,
MODIFY COLUMN Discount_Offered_Pct DECIMAL(5,2),
MODIFY COLUMN Payment_Status VARCHAR(20),
MODIFY COLUMN Property_Amenities TEXT,
MODIFY COLUMN Floor_Plot_Number VARCHAR(50),
MODIFY COLUMN Number_of_Bedrooms INT,
MODIFY COLUMN Agent_Commission_Pct DECIMAL(5,2),
MODIFY COLUMN Remarks_Notes TEXT,
MODIFY COLUMN Effective_Price_INR DECIMAL(15,2);

SELECT * FROM realestate_transactions;

DESCRIBE realestate_transactions;



-- ============================================================
-- Table: avg_days_to_close
-- Modify column datatypes for consistency
-- ============================================================
ALTER TABLE avg_days_to_close
MODIFY COLUMN Property_Type VARCHAR(50),
MODIFY COLUMN Booking_Status VARCHAR(20),
MODIFY COLUMN `Count` INT,
MODIFY COLUMN Avg_Days_to_Close DECIMAL(10,2),
MODIFY COLUMN Min_Days INT,
MODIFY COLUMN Max_Days INT;

-- Verify structure
DESCRIBE avg_days_to_close;

-- ============================================================
-- Table: avg_price_property_type
-- Modify column datatypes for consistency
-- ============================================================
ALTER TABLE avg_price_property_type
MODIFY COLUMN Property_Type VARCHAR(50),
MODIFY COLUMN Transactions INT,
MODIFY COLUMN Avg_Sale_Price_INR DECIMAL(15,2),
MODIFY COLUMN Median_Sale_Price_INR DECIMAL(15,2),
MODIFY COLUMN Avg_Size_sqft DECIMAL(10,2),
MODIFY COLUMN Avg_Discount_Pct DECIMAL(5,2),
MODIFY COLUMN Avg_Days_to_Close INT,
MODIFY COLUMN Total_Revenue_INR DECIMAL(15,2);

-- Verify structure
DESCRIBE avg_price_property_type;

-- Quick data check
SELECT * FROM avg_price_property_type;

-- ============================================================
-- Table: lead_source_analysis
-- Modify column datatypes for consistency
-- ============================================================
ALTER TABLE lead_source_analysis
MODIFY COLUMN Lead_Source VARCHAR(50),
MODIFY COLUMN Total_Leads INT,
MODIFY COLUMN Booked INT,
MODIFY COLUMN Lost INT,
MODIFY COLUMN Pending INT,
MODIFY COLUMN Conversion_Rate_Pct DECIMAL(5,2),
MODIFY COLUMN Avg_Sale_Price_INR DECIMAL(15,2),
MODIFY COLUMN Total_Revenue_INR DECIMAL(15,2);

-- ============================================================
-- Table: revenue_by_location
-- Modify column datatypes for consistency
-- ============================================================
ALTER TABLE revenue_by_location
MODIFY COLUMN Location VARCHAR(100),
MODIFY COLUMN Tier VARCHAR(20),
MODIFY COLUMN Transactions INT,
MODIFY COLUMN Total_Revenue_INR DECIMAL(15,2),
MODIFY COLUMN Avg_Price_INR DECIMAL(15,2),
MODIFY COLUMN Booked_Count INT,
MODIFY COLUMN Booking_Rate_Pct DECIMAL(5,2);

-- ============================================================
-- Table: top_agents_revenue
-- Modify column datatypes for consistency
-- ============================================================
ALTER TABLE top_agents_revenue
MODIFY COLUMN `Rank` INT,
MODIFY COLUMN Agent_ID VARCHAR(20),
MODIFY COLUMN Agent_Name VARCHAR(100),
MODIFY COLUMN Transactions_Booked INT,
MODIFY COLUMN Total_Revenue_INR DECIMAL(15,2),
MODIFY COLUMN Avg_Deal_Value_INR DECIMAL(15,2),
MODIFY COLUMN Avg_Commission_Pct DECIMAL(5,2),
MODIFY COLUMN Est_Commission_Earned_INR DECIMAL(15,2),
MODIFY COLUMN Avg_Days_to_Close INT;

-- ============================================================
-- Table: monthly_revenue_trend
-- Clean up Month column and finalize datatypes
-- ============================================================

-- Step 0: Inspect current table structure and data
SELECT * FROM monthly_revenue_trend;

-- Step 1: Attempt conversion (fails if Month is only YYYY-MM)
ALTER TABLE monthly_revenue_trend
MODIFY COLUMN Month DATE,
MODIFY COLUMN Transactions_Booked INT,
MODIFY COLUMN Total_Revenue_INR DECIMAL(15,2),
MODIFY COLUMN Avg_Sale_Price_INR DECIMAL(15,2);

-- Step 2: Adjust Month column to VARCHAR(7) to hold YYYY-MM safely
ALTER TABLE monthly_revenue_trend
MODIFY COLUMN Month VARCHAR(7);

-- Step 3: Add a clean DATE column for proper date operations
ALTER TABLE monthly_revenue_trend
ADD COLUMN Month_clean DATE;

-- Step 4: Convert 'YYYY-MM' into 'YYYY-MM-01' for valid DATE values
UPDATE monthly_revenue_trend
SET Month_clean = STR_TO_DATE(CONCAT(Month, '-01'), '%Y-%m-%d');

-- Step 5: Drop old Month column and rename Month_clean to Month (DATE type)
ALTER TABLE monthly_revenue_trend
DROP COLUMN Month,
CHANGE COLUMN Month_clean Month DATE;

-- Step 6: Add Year and Month_Num columns for easier analytics
ALTER TABLE monthly_revenue_trend
ADD COLUMN Year INT,
ADD COLUMN Month_Num INT;

-- Step 7: Populate Year and Month_Num from the Month DATE column
UPDATE monthly_revenue_trend
SET Year = YEAR(Month),
    Month_Num = MONTH(Month);

-- Step 8: Finalize datatypes for all columns
ALTER TABLE monthly_revenue_trend
MODIFY COLUMN Year INT,
MODIFY COLUMN Month_Num INT,
MODIFY COLUMN Transactions_Booked INT,
MODIFY COLUMN Total_Revenue_INR DECIMAL(15,2),
MODIFY COLUMN Avg_Sale_Price_INR DECIMAL(15,2);