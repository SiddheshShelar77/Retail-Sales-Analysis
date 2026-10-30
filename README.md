\# Retail Sales Analysis



\## Project Overview

An end-to-end retail sales analysis project using MySQL and Microsoft Excel. The objective is to analyze retail sales performance, identify profitability trends, and generate actionable business insights.



\## Business Objectives

\- Analyze overall sales and profit performance.

\- Identify high-performing regions and product categories.

\- Understand customer segment performance.

\- Analyze monthly sales trends.

\- Evaluate the relationship between discounts and profitability.



\## Tools \& Technologies

\- \*\*MySQL:\*\* Data storage, querying, and analysis.

\- \*\*Microsoft Excel:\*\* Data cleaning, PivotTables, charts, and dashboard creation.

\- \*\*SQL:\*\* Aggregations, joins where applicable, date functions, CTEs, and window functions.



\## Dataset

Sample Superstore retail sales dataset containing order, customer, product, shipping, sales, discount, and profit information.



\## Data Cleaning

\- Removed completely empty rows.

\- Identified missing Postal Code values.

\- Preserved unknown Postal Codes as NULL rather than assuming values.

\- Retained repeated Order IDs because an order can contain multiple product line items.

\- Prepared the cleaned CSV for MySQL import.



\## SQL Analysis

The following analyses were performed:

1\. Overall business KPIs.

2\. Regional sales and profit analysis.

3\. Category-wise performance analysis.

4\. Top-performing products.

5\. Customer segment analysis.

6\. Monthly sales and profit trends.

7\. Discount impact on profitability.

8\. Month-over-month sales growth.



\## Dashboard KPIs



| Metric | Result |

|---|---:|

| Total Revenue | $2,297,200.86 |

| Total Profit | $286,397.02 |

| Total Orders | 5,009 |

| Total Customers | 793 |

| Average Order Value | $458.61 |

| Profit Margin | 12.46% |



\## Key Business Insights

\- The West region generated the highest revenue and profit.

\- Technology was the most profitable product category.

\- Furniture generated comparatively low profit despite substantial revenue.

\- Consumer customers contributed the highest revenue among customer segments.

\- Some products generated negative or very low profits.

\- Discount levels were analyzed to understand their relationship with profitability.



\## Project Structure

```text

Retail-Sales-Analysis/

├── Dataset/

│   └── superstore\_cleaned.csv

├── SQL/

│   └── analysis\_queries.sql

├── Excel/

│   └── Retail\_Sales\_Dashboard.xlsx

└── Documentation/

&#x20;   └── data\_cleaning\_notes.md

```



\## Conclusion

This project demonstrates practical skills in SQL-based data analysis, Excel dashboard development, data cleaning, KPI reporting, and business insight generation.

