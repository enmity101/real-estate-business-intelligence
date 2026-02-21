-- ============================================================
	CREATE DATABASE real_estate_analyse;
-- ============================================================
-- Creating Tables
-- ============================================================
CREATE TABLE realestate_transactions (
    Transaction_ID TEXT,
    Property_ID TEXT,
    Property_Type TEXT,
    Location TEXT,
    Location_Tier TEXT,
    Transaction_Date TEXT,
    Property_Size_sqft TEXT,
    Sale_Price_INR TEXT,
    Agent_ID TEXT,
    Agent_Name TEXT,
    Lead_Source TEXT,
    Client_Type TEXT,
    Booking_Status TEXT,
    Time_to_Close_Days TEXT,
    Discount_Offered_Pct TEXT,
    Payment_Status TEXT,
    Property_Amenities TEXT,
    Floor_Plot_Number TEXT,
    Number_of_Bedrooms TEXT,
    Agent_Commission_Pct TEXT,
    Remarks_Notes TEXT,
    Effective_Price_INR TEXT
);

-- Top Agents by Revenue
CREATE TABLE top_agents_revenue (
    `Rank` TEXT,
    Agent_ID TEXT,
    Agent_Name TEXT,
    Transactions_Booked TEXT,
    Total_Revenue_INR TEXT,
    Avg_Deal_Value_INR TEXT,
    Avg_Commission_Pct TEXT,
    Est_Commission_Earned_INR TEXT,
    Avg_Days_to_Close TEXT
);

-- Revenue by Location
CREATE TABLE revenue_by_location (
    Location TEXT,
    Tier TEXT,
    Transactions TEXT,
    Total_Revenue_INR TEXT,
    Avg_Price_INR TEXT,
    Booked_Count TEXT,
    Booking_Rate_Pct TEXT
);

-- Monthly Revenue Trend
CREATE TABLE monthly_revenue_trend (
    Month TEXT,
    Transactions_Booked TEXT,
    Total_Revenue_INR TEXT,
    Avg_Sale_Price_INR TEXT
);

-- Lead Source Analysis
CREATE TABLE lead_source_analysis (
    Lead_Source TEXT,
    Total_Leads TEXT,
    Booked TEXT,
    Lost TEXT,
    Pending TEXT,
    Conversion_Rate_Pct TEXT,
    Avg_Sale_Price_INR TEXT,
    Total_Revenue_INR TEXT
);

-- Avg Price for Property Type
CREATE TABLE avg_price_property_type (
    Property_Type TEXT,
    Transactions TEXT,
    Avg_Sale_Price_INR TEXT,
    Median_Sale_Price_INR TEXT,
    Avg_Size_sqft TEXT,
    Avg_Discount_Pct TEXT,
    Avg_Days_to_Close TEXT,
    Total_Revenue_INR TEXT
);

-- Avg Days to Close
CREATE TABLE avg_days_to_close (
    Property_Type TEXT,
    Booking_Status TEXT,
    Count TEXT,
    Avg_Days_to_Close TEXT,
    Min_Days TEXT,
    Max_Days TEXT
);

-- ============================================================
-- USE THIS FOR DATA LOAD FASTER
-- ============================================================

-- Example: Import into realestate_transactions
LOAD DATA INFILE '/path/to/realestate_transactions.csv'
INTO TABLE realestate_transactions
FIELDS TERMINATED BY '\t'        -- or ',' if CSV
ENCLOSED BY '"'                  -- handles quoted text
LINES TERMINATED BY '\n'
IGNORE 1 ROWS                    -- skip header row


