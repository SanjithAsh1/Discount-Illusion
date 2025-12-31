create Database discount_illusion;
use discount_illusion;

-- Creating a table with the same no of columns from the CSV file 
CREATE TABLE superstore_raw (
    row_id INT,
    order_id VARCHAR(20),
    order_date VARCHAR(20),
    ship_date VARCHAR(20),
    ship_mode VARCHAR(50),
    customer_id VARCHAR(20),
    customer_name VARCHAR(100),
    segment VARCHAR(50),
    country_region VARCHAR(50),
    city VARCHAR(50),
    state VARCHAR(50),
    postal_code VARCHAR(10),
    region VARCHAR(20),
    product_id VARCHAR(20),
    category VARCHAR(50),
    sub_category VARCHAR(50),
    product_name VARCHAR(150),
    sales DECIMAL(10,3),
    quantity INT,
    discount DECIMAL(5,2),
    profit DECIMAL(10,4)
);

-- our csv file contains non-UTF8 characters but expects utf8mb4 so It throws and error
LOAD DATA INFILE "C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv" INTO TABLE superstore_raw FIELDS TERMINATED BY ',' ENCLOSED BY '"' LINES TERMINATED BY '\n' IGNORE 1 ROWS;

SHOW VARIABLES LIKE 'secure_file_priv'; -- to find the trusted path of MYSQL to upload the csv file.

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/Sample - Superstore.csv'
INTO TABLE superstore_raw
CHARACTER SET latin1
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS; -- based on the previous error we specify the character set in LOAD DATA to convert form latin1 to utf8mb4

CREATE TABLE superstore_clean AS
SELECT
    row_id,
    order_id,
    STR_TO_DATE(order_date,'%m/%d/%Y') AS order_date,
    STR_TO_DATE(ship_date,'%m/%d/%Y') AS ship_date,
    ship_mode,
    customer_id,
    customer_name,
    segment,
    country_region,
    city,
    state,
    postal_code,
    region,
    product_id,
    category,
    sub_category,
    product_name,
    sales,
    quantity,
    discount,
    profit
FROM superstore_raw; -- conversion from string to Date for 2 columns (order_date & ship_date)

select * from superstore_clean; -- Displaying the data to crossverify the data

-- --------------------------------------------------------------------------------------------------------------------------------
-- Finding the Core Metrices

SELECT 
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 4) AS profit_margin,-- Profit/Sales for finding the profit margin
    ROUND(AVG(discount), 3) AS avg_discount
FROM superstore_clean
GROUP BY sub_category
ORDER BY total_sales DESC; -- Grouping by Sub-Category and finding the top 3 subcategories with highest sales and their profit margin

-- Findings : 
-- Top 3 sub categories(Phones,Chairs,Storage)
-- Chairs has the lowest Profit Margin with the average discount of 1.170




SELECT 
    CASE
        WHEN discount = 0 THEN 'No Discount'
        WHEN discount <= 0.20 THEN 'Low Discount'
        WHEN discount <= 0.50 THEN 'Medium Discount'
        ELSE 'High Discount'
    END AS discount_bucket,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 4) AS profit_margin
FROM superstore_clean
GROUP BY discount_bucket
ORDER BY profit_margin; -- Bucketing the discount into 4 categories to find the breaking point of the profit Margin

-- Findings : 
-- we can find that profit Margin in the medium and high discount Buckets remains approx same (-0.197 & -0.192)
-- We can find a sharp drop in profit margin in the medium bucket at the point (discount = 0.30)
-- we can find that Medium Discount is the Bucket with the break point & when move from low to medium the profit margin moves from (0.119 to -0.197)





SELECT 
    category,
    ROUND(AVG(discount), 3) AS avg_discount,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 4) AS profit_margin
FROM superstore_clean
GROUP BY category
ORDER BY avg_discount DESC; -- Finding if the dependence of Category on the profit margin

-- Findings : 
-- We find that Furniture Category has the highest avg discount and also the least Profit Margin
-- We also find that Technology Category with the least avg discount has the highest Profit Margin






SELECT 
    region,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(SUM(profit), 2) AS total_profit,
    ROUND(SUM(profit) / NULLIF(SUM(sales), 0), 4) AS profit_margin
FROM superstore_clean
GROUP BY region
ORDER BY total_sales DESC; -- Finding if the dependence of Region on the Profit Margin

-- Findings :
-- we find that South Region with than Central Region sales has profit Margin Higher than Central Region with more sales.
-- we also find that West region has the Highest Sales with high profit Margin


-- ------------------------------------------------------------------------------------------------------------------------------------------------------------
-- END REPORT

-- Sub-category Tables generates high revenue but shows negative profit margins due to heavy discounting.

-- Profit margins drop significantly beyond the medium discount range, indicating discount-driven revenue inflation.

-- Category Furniture relies heavily on discounts to maintain sales, making it financially risky.

-- Central Region appears strong in sales but underperforms in profitability.