
USE retail_sales;

DROP TABLE IF EXISTS superstore;

CREATE TABLE superstore (
    `Row ID` INT,
    `Order ID` VARCHAR(30),
    `Order Date` VARCHAR(20),
    `Ship Date` VARCHAR(20),
    `Ship Mode` VARCHAR(30),
    `Customer ID` VARCHAR(20),
    `Customer Name` VARCHAR(100),
    `Segment` VARCHAR(30),
    `Country` VARCHAR(50),
    `City` VARCHAR(100),
    `State` VARCHAR(100),
    `Postal Code` VARCHAR(20),
    `Region` VARCHAR(30),
    `Product ID` VARCHAR(30),
    `Category` VARCHAR(50),
    `Sub-Category` VARCHAR(50),
    `Product Name` TEXT,
    `Sales` DECIMAL(12,4),
    `Quantity` INT,
    `Discount` DECIMAL(8,4),
    `Profit` DECIMAL(12,4)
);


LOAD DATA INFILE
'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/superstore_cleaned.csv'

INTO TABLE superstore

FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'

LINES TERMINATED BY '\r\n'

IGNORE 1 LINES

(
    `Row ID`,
    `Order ID`,
    `Order Date`,
    `Ship Date`,
    `Ship Mode`,
    `Customer ID`,
    `Customer Name`,
    `Segment`,
    `Country`,
    `City`,
    `State`,
    @postal_code,
    `Region`,
    `Product ID`,
    `Category`,
    `Sub-Category`,
    `Product Name`,
    `Sales`,
    `Quantity`,
    `Discount`,
    `Profit`
)

SET `Postal Code` = NULLIF(@postal_code, '');


SELECT
    COUNT(*) AS total_records,
    MIN(`Row ID`) AS first_id,
    MAX(`Row ID`) AS last_id
FROM superstore;

SELECT COUNT(*) AS missing_postal_codes
FROM superstore
WHERE `Postal Code` IS NULL;


-- TOTAL REVENUE
SELECT
SUM(Sales) AS Total_revenue
FROM superstore;

-- TOTAL PROFIT
SELECT
SUM(Profit) AS Total_Profit
FROM superstore;

-- TOTAL ORDER
SELECT
COUNT(distinct `Order ID`) AS Total_Order
FROM superstore;

-- TOTAL CUSTOMER
SELECT
COUNT(DISTINCT `Customer ID`) AS Total_Customer
FROM superstore;

-- AVERAGE REVENUE PER ORDER (AVERAGE ORDER VALUE (AVO))
SELECT
SUM(Sales)/COUNT(DISTINCT `Order ID`) AS AVO
FROM superstore;

-- TOTAL QUANTITY SOLD
SELECT
SUM(Quantity) AS total_quantity
FROM superstore;

SELECT
SUM(Sales) AS Total_revenue,
SUM(Profit) AS Total_Profit,
COUNT(distinct `Order ID`) AS Total_Order,
COUNT(DISTINCT `Customer ID`) AS Total_Customer,
ROUND(
SUM(Sales)/COUNT(DISTINCT `Order ID`),2 
) AS AVERAGE_ORDER_VALUE,
SUM(Quantity) AS total_quantity
FROM superstore;


-- SALES BY REGION
SELECT 
Region,
ROUND(SUM(Sales),2) AS TOTAL_SALES,
ROUND(SUM(Profit),2) AS TOTAL_PROFIT
FROM superstore
GROUP BY Region
ORDER BY TOTAL_SALES DESC;

-- SALES BY PRODUCT CATEGORY
SELECT
Category,
ROUND(SUM(Sales),2) AS TOTAL_SALES,
ROUND(SUM(Profit),2) AS TOTAL_PROFIT,
SUM(Quantity) AS UNITS_SOLD
FROM superstore
GROUP BY CATEGORY
ORDER BY TOTAL_SALES DESC;

-- TOP 10 SELLING PRODUCTS
SELECT
`Product Name`,
ROUND(SUM(Sales),2) AS TOTAL_SALES,
ROUND(SUM(Profit),2) AS TOTAL_PROFIT
FROM superstore
GROUP BY `Product Name`
ORDER BY TOTAL_SALES DESC
LIMIT 10;


-- CUSTOMER SEGMENTATION
SELECT
    Segment,
    COUNT(DISTINCT `Customer ID`) AS Total_Customers,
    COUNT(DISTINCT `Order ID`) AS Total_Orders,
    ROUND(SUM(Sales), 2) AS Total_Revenue,
    ROUND(SUM(Profit), 2) AS Total_Profit
FROM superstore
GROUP BY Segment
ORDER BY Total_Revenue DESC;


-- MONTHY SALES PERFORMANCE
SELECT
    `Order Date`
FROM superstore
LIMIT 10;

SELECT
    `Order Date`,
    STR_TO_DATE(`Order Date`, '%m-%d-%Y') AS converted_date
FROM superstore
LIMIT 10;


-- MONTHLY REVENUE ANALYSIS
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
        '%Y-%m'
    ) AS sales_month,

    ROUND(SUM(Sales), 2) AS total_revenue,

    ROUND(SUM(Profit), 2) AS total_profit,

    COUNT(DISTINCT `Order ID`) AS total_orders

FROM superstore

GROUP BY sales_month

ORDER BY sales_month;


-- BEST PERFORMING MONTH
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
        '%Y-%m'
    ) AS sales_month,

    ROUND(SUM(Sales), 2) AS total_revenue

FROM superstore

GROUP BY sales_month

ORDER BY total_revenue DESC

LIMIT 5;


-- LOWEST PERFORMING MONTH
SELECT
    DATE_FORMAT(
        STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
        '%Y-%m'
    ) AS sales_month,

    ROUND(SUM(Sales), 2) AS total_revenue

FROM superstore

GROUP BY sales_month

ORDER BY total_revenue ASC

LIMIT 5;


-- DISCOUNT IMPACT ON PROFITABILITY
SELECT
    Discount,
    COUNT(*) AS total_transactions,
    ROUND(SUM(Sales), 2) AS total_sales,
    ROUND(SUM(Profit), 2) AS total_profit,
    ROUND(AVG(Profit), 2) AS avg_profit
FROM superstore
GROUP BY Discount
ORDER BY Discount;


-- MONTH OVER MONTH REVENUE GROWTH
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            STR_TO_DATE(`Order Date`, '%m-%d-%Y'),
            '%Y-%m'
        ) AS sales_month,
        SUM(Sales) AS revenue
    FROM superstore
    GROUP BY sales_month
),

growth_analysis AS (
    SELECT
        sales_month,
        revenue,
        LAG(revenue) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM monthly_sales
)

SELECT
    sales_month,
    ROUND(revenue, 2) AS current_revenue,
    ROUND(previous_month_revenue, 2) AS previous_revenue,
    ROUND(
        (revenue - previous_month_revenue)
        / NULLIF(previous_month_revenue, 0) * 100,
        2
    ) AS growth_percentage
FROM growth_analysis
ORDER BY sales_month;
