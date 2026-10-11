# Superstore Sales Performance Dashboard (SQL + Power BI)

## Business problem
A global retailer wants to know where it makes and loses money. This project answers four questions:

1. Which markets, regions and categories give the most profit?
2. Which products are losing money?
3. How do discounts affect profit?
4. What are the monthly sales trends?

## Dataset
- Global Superstore sales data from Kaggle (SuperStore Sales Dataset by Laiba Anwer)
- 51,290 order lines, 21 columns, orders from 2011 to 2014
- Key fields: order_date, market, region, category, sub_category, product_name, sales, quantity, discount, profit

## Tools
- **Power BI (Power Query):** data profiling and cleaning
- **DAX Studio:** exported the cleaned table to CSV
- **MySQL 8.0 + Workbench:** loaded the data and answered the business questions in SQL
- **Power BI Desktop:** one-page dashboard

## Process

### 1. Cleaning (Power Query)
- Checked all 21 columns across all 51,290 rows: **0 errors and 0 empty values**
- Removed duplicate rows: **none found**, the row count stayed at 51,290
- Set `order_date` and `ship_date` to Date type (day-month-year source format, so no day/month mix-ups)
- Confirmed `sales`, `quantity`, `discount`, `profit` and `shipping_cost` are numeric
- Column names were already lowercase with underscores, so no renaming was needed

### 2. Loading into MySQL
- Created the `superstore` database and an `orders` table
- Loaded the cleaned CSV with `LOAD DATA INFILE` (51,290 rows)
- Checked the load: row count matches, accented customer names are intact
- Note: 7 profit values were rounded beyond the 10th decimal place when loading

### 3. SQL analysis
All queries are in [`sql/superstore_queries.sql`](sql/superstore_queries.sql).

### 4. Dashboard
![Dashboard](screenshots/dashboard.png)

KPI cards (total sales, total profit, profit margin), a monthly trend line, profit by market and by category, and slicers for year and market.

## Key findings

**Overall:** about 12.6M in sales and 1.47M in profit, a profit margin of 11.62%.

1. **APAC is the most profitable market** at about 437.6K profit (12.2% margin), followed by EU (372.8K) and US (286.4K).
2. **EMEA has the weakest margin at 5.45%**, less than half of APAC, EU and US. Canada has the highest margin (26.6%) but small sales (66.9K).
3. **Technology and Office Supplies drive profit.** The top region and category pair is Central Technology (135.5K profit). Furniture earns the least, with a margin of roughly 6% in its best region.
4. **Discounts above 20% are associated with losses:**

   | Discount | Order lines | Avg profit per line |
   |---|---|---|
   | 0% | 29,009 | +61.04 |
   | 1-20% | 10,953 | +46.84 |
   | 21-40% | 4,367 | -42.88 |
   | Over 40% | 6,961 | -90.13 |

   Lines discounted above 20% lost about 815K in total.
5. **Loss-making products:** the worst is the Cubify CubeX 3D Printer Double Head Print (about -8.9K), then the Lexmark MX611dhe laser printer (-4.6K) and the Motorola Smart Phone, Cordless (-4.4K). Five of the ten worst products are tables.
6. **Seasonality:** sales grow year over year, with a dip in July and peaks in November and December.

## Recommendations
- Cap discounts at around 20%, or require approval above it.
- Review pricing and discounts on tables and on high-ticket items such as 3D printers.
- Investigate why EMEA margins are so low (costs, shipping or discounting).
- Plan stock and marketing around the November and December peak.

Note: discount level and product type overlap in this data, so the findings show association, not proof of cause.

## Repository structure
```
Superstore-Project/
├── data/
│   ├── raw/SuperStoreOrders.csv
│   └── cleaned/superstore_cleaned.csv
├── sql/superstore_queries.sql
├── dashboard/superstore_dashboard.pbix
├── screenshots/dashboard.png
└── README.md
```
