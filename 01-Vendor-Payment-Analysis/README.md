# SQL Business Analytics Portfolio

## Project 1 – Vendor Payment Analysis

## Project Overview

This project demonstrates SQL-based business analysis using a relational database containing vendor, payment, and vendor contact data.

The objective is to solve realistic finance and master data reporting scenarios commonly encountered in enterprise environments while showcasing practical SQL techniques used in Data Analyst and Master Data Analyst roles.

---

## Database

The project uses three related tables:

- Vendors
- Payments
- Vendor Contacts

---

## Business Scenarios

This project answers the following business questions:

1. Summarize total payments for each vendor.
2. Identify vendors whose total payments exceed the average vendor total.
3. Display the top 3 highest payments by country.
4. Identify the highest payment within each country.
5. Generate running payment totals and vendor payment statistics.
6. Find vendors with payments within a specified payment range.
7. Generate a payment history report including previous payment amount and previous payment date for each vendor using `LAG()`.
8. Create a financial payment dashboard using Window Functions.
9. Identify vendors whose latest payment exceeds their historical average payment.
10. Identify vendors whose latest payment increased by at least 20% compared to their previous payment.
11. Identify vendors whose latest payment is also their highest payment ever.

---

## SQL Concepts Demonstrated

### SQL Fundamentals

- SELECT
- WHERE
- ORDER BY
- DISTINCT
- LIMIT / OFFSET
- GROUP BY
- HAVING
- CASE

### Joins

- INNER JOIN
- LEFT JOIN

### Aggregate Functions

- SUM()
- AVG()
- COUNT()
- MIN()
- MAX()

### Window Functions

- ROW_NUMBER()
- RANK()
- DENSE_RANK()
- LAG()
- LEAD()
- SUM() OVER()
- AVG() OVER()
- MAX() OVER()
- MIN() OVER()

### Advanced SQL

- Common Table Expressions (CTEs)
- Nested Subqueries
- Correlated Subqueries
- IN / NOT IN
- EXISTS / NOT EXISTS
- NULLIF()

---

## Tools

- SQLite
- DB Browser for SQLite
- GitHub

---

## Repository Structure

```
Vendor-Payment-Analysis/
│
├── queries.sql
├── README.md
├── findings.md
├── screenshots/
└── sample_results/
```

---

## Skills Demonstrated

- SQL Query Development
- Business Data Analysis
- Financial Reporting
- Master Data Analysis
- Window Functions
- Data Aggregation
- Ranking & Trend Analysis
- Analytical Problem Solving

---

## Status

✅ 11 business-oriented SQL reporting scenarios completed.

The repository will continue expanding with additional SQL case studies, Python (Pandas), and Power BI projects.
