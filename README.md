# 🛒 E-Commerce Analysis (SQL)

This project performs **data exploration, cleaning, and analysis** on a sample e-commerce dataset using PostgreSQL.  
The dataset represents products sold on the `Zepto` platform, containing details like category, price, discounts, stock availability, and weight.

---

## 📂 Project Structure
- **Table Creation** – Defines the `zepto` table schema.
- **Data Exploration** – Queries to inspect, count, and understand the dataset.
- **Data Cleaning** – Removes invalid values, fixes units, and formats prices.
- **Analysis Queries** – Extracts useful business insights from the dataset.

---

## 🗄 Table Schema
```sql
CREATE TABLE zepto (
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
