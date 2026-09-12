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

1. Identify countries with the highest total payment values.
2. Identify vendors with no recorded payments.
3. Identify countries where total payment value exceeds 500,000.
4. Identify vendors whose total payments exceed the average vendor total.
5. Generate a country-level payment summary including payment count, total, minimum, maximum, and average payment.
6. Identify the top 3 payment transactions within each country.
7. Generate payment history including the previous payment amount and previous payment date for each vendor using `LAG()`.
8. Generate running payment totals and vendor-level payment statistics using Window Functions.
9. Identify vendors whose latest payment exceeds their historical average payment.
10. Identify vendors whose latest payment increased by at least 20% compared to their previous payment.
11. Identify vendors whose latest payment is also their highest payment ever.
12. Identify high-value vendors above the average vendor total and provide their contact information and payment summary.
13. Identify vendors with the longest streak of consecutive payment increases.

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
- IN / NOT IN
- EXISTS / NOT EXISTS
- NULLIF()
- Sequential and trend analysis
- Running totals / cumulative calculations
- Streak analysis

---

## Tools

- SQLite
- DB Browser for SQLite
- GitHub

---

## Repository Structure

```text
SQL-Portfolio/
│
├── 01-Vendor-Payment-Analysis/
│   ├── queries.sql
│   ├── schema.sql
│   ├── findings.md
│   │
│   ├── sample_data/
│   │   ├── vendors_sample.csv
│   │   ├── payments_sample.csv
│   │   └── vendor_contacts_sample.csv
│   │
│   └── screenshots/
│       ├── 01-database-tables.png
│       ├── 02-country-payment-summary.png
│       ├── 03-top-3-payments-by-country.png
│       ├── 04a-running-payment-analysis-part1.png
│       ├── 04b-running-payment-analysis-part2.png
│       ├── 05a-increasing-streak-part1.png
│       ├── 05b-increasing-streak-part2.png
│       ├── 05c-increasing-streak-part3.png
│       ├── 05d-increasing-streak-part4.png
│       ├── 05e-increasing-streak-part5.png
│       ├── 05f-increasing-streak-part6.png
│       └── README.md
