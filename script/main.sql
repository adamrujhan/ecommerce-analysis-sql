-- This SQL script creates a table named 'zepto' with various columns to store product information.
CREATE TABLE zepto 
(
    id SERIAL PRIMARY KEY,
    category VARCHAR(120),
    name VARCHAR(120) NOT NULL,
    mrp NUMERIC(10, 2),
    discountpercent NUMERIC(8,2),
    availablequantity INT,
    discountedsellingprice NUMERIC(10, 2),
    weightingms INT,
    outofstock BOOLEAN,
    quantity INT
);


-- data exploration 
-- count of rows
SELECT COUNT(*) FROM zepto;

-- sample data
SELECT * FROM zepto LIMIT 10;

-- null values
SELECT *
FROM zepto 
WHERE 
    category IS NULL 
    OR name IS NULL 
    OR mrp IS NULL 
    OR discountpercent IS NULL 
    OR availablequantity IS NULL 
    OR discountedsellingprice IS NULL 
    OR weightingms IS NULL 
    OR outofstock IS NULL 
    OR quantity IS NULL;

-- different product categories
SELECT DISTINCT category FROM zepto;

-- product in stock vs out of stock 
SELECT 
    outofstock, 
    COUNT(id) AS product_count
FROM zepto
GROUP BY outofstock;

--product name present multiple time 
SELECT 
    name, 
    COUNT(id) AS product_count
FROM zepto
GROUP BY name
HAVING COUNT(id) > 1
ORDER BY product_count DESC;

--data cleaning

--product with price less than 0
SELECT * FROM zepto
WHERE mrp = 0 OR discountedsellingprice = 0;

DELETE FROM zepto
WHERE mrp = 0;

--convert paise to rupees
UPDATE zepto
SET mrp = mrp / 100,
    discountedsellingprice = discountedsellingprice / 100;

SELECT mrp, discountedsellingprice FROM zepto; 

--Q1. find the top 10 best-value products based on the discount percentage
SELECT DISTINCT
    name,
    mrp,
    discountpercent
FROM zepto
ORDER BY discountpercent DESC
LIMIT 10

--Q2. what are the products with high mrp (>300) but out of stock
SELECT DISTINCT
    name,
    mrp,
    outofstock
FROM zepto
WHERE outofstock = TRUE AND mrp > 300
ORDER BY mrp DESC

--Q3. calculate estimate revenue for each category
SELECT 
    category,
    SUM(discountedSellingPrice * availablequantity) AS estimated_revenue
FROM zepto
GROUP BY category
ORDER BY estimated_revenue DESC;

--Q4. find all product where mrp is greater than 500 and discount is less than 10%
SELECT DISTINCT
    name,
    mrp,
    discountpercent
FROM zepto
WHERE mrp > 500 AND discountpercent < 10
ORDER BY mrp DESC, discountpercent DESC;

--Q5. identify top 5 categories offering the highest avg discount percentage
SELECT 
    category,
    ROUND(AVG(discountpercent),2) AS avg_discount_percentage
FROM zepto
GROUP BY category
ORDER BY avg_discount_percentage DESC
LIMIT 5;

--Q6. find the price per gram for product above 100g and sort by best value
SELECT DISTINCT
    name,
    discountedsellingprice,
    weightingms,
    ROUND((discountedsellingprice / weightingms), 2) AS price_per_gram
FROM zepto
WHERE weightingms >= 100
ORDER BY price_per_gram ASC
LIMIT 10;

--Q7. group the product into cetogories like low medium, bulk
SELECT DISTINCT
    name, 
    weightingms,
    CASE 
        WHEN weightingms < 1000 THEN 'low'
        WHEN weightingms >= 1000 AND weightingms < 500 THEN 'medium'
        ELSE 'bulk'
    END AS weight_category
FROM zepto

--Q8. what is total inventory weight per catergory
SELECT  
    category,
    SUM(weightingms * availableQuantity) AS total_inventory_weight
FROM zepto
GROUP BY category
ORDER BY total_inventory_weight ASC;
