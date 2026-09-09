# Business Findings

## 1. Highest Total Payments by Country

The analysis identifies the country with the highest total payment value.

The **United States** has the highest total payment value, with **803,684.06** in payments.

This helps Finance understand where the largest payment activity is concentrated geographically.

## 2. Vendors with No Payments

The analysis identifies vendors that have no recorded payments.

There are **200 vendors with no payment records**.

These vendors may require further review to determine whether they are inactive, newly created, or missing payment activity.

## 3. Countries Exceeding 500,000 in Payments

The analysis identifies countries where total payment value exceeds **500,000**.

There are **8 countries** above this threshold.

This provides a simple way for Finance to identify countries with significant payment activity.

## 4. Vendors Above Average Total Payments

The analysis compares each vendor's total payment value with the average vendor total.

There are **236 vendors above the average vendor payment total**.

These vendors represent higher-value payment activity and may be useful for prioritization during financial monitoring and reconciliation.

## 5. Country-Level Payment Summary

The country-level analysis provides the **number of payments, total payments, minimum payment, maximum payment, and average payment** for each country.

This creates a consolidated view of payment activity and allows Finance to compare payment volume and value across countries.

## 6. Top 3 Payments per Country

The analysis ranks individual payments within each country and identifies the **top 3 payments per country**.

This helps Finance identify the largest individual payment transactions in each market and supports targeted transaction review.

## 7. Payment History and Previous Payment

The analysis compares each payment with the vendor's previous payment using sequential payment history.

This makes it possible to identify how payment amounts change over time and provides the foundation for trend and anomaly analysis.

## 8. Running Total and Payment Statistics

The analysis calculates a **running total**, as well as total, highest, lowest, and average payment values.

Running totals provide a cumulative view of payment activity over time, while the additional statistics provide context for evaluating individual transactions.

## 9. Latest Payment vs. Historical Average

The analysis identifies vendors whose latest payment is higher than their historical average payment.

There are **260 vendors** whose latest payment exceeds their historical average.

These vendors may warrant additional attention because their most recent payment represents an increase relative to their normal payment level.

## 10. Latest Payment Increased by at Least 20%

The analysis identifies vendors whose latest payment increased by at least **20%** compared with their previous payment.

There are **258 vendors** meeting this condition.

This can help Finance identify significant recent increases in vendor payment activity.

## 11. Latest Payment Is the Highest Ever

The analysis identifies vendors whose latest payment is also their highest recorded payment.

There are **396 vendors** where the latest payment is their highest payment ever.

This provides another indicator for identifying unusually high recent payment activity.

## 12. High-Value Vendors and Contact Information

The analysis identifies vendors whose total payment value exceeds the average vendor total and combines this information with their contact details.

This connects financial analysis with actionable master data by providing the **vendor name, country, contact person, email, department, payment count, and total payment value**.

This type of output can help Finance or Master Data teams quickly identify and contact relevant vendors.

## 13. Longest Increasing Payment Streak

The analysis identifies vendors with the longest sequence of consecutive payment increases.

The longest increasing streak identified is **5 increasing payment transitions**, from **2023-05-05** to **2026-01-03**.

This analysis demonstrates how sequential data can be used to identify sustained increases in vendor payment activity.

## Overall Business Value

This project demonstrates how SQL can be used to transform vendor and payment data into actionable business insights.

Key areas covered include:

- Payment concentration by country
- Vendor payment activity and gaps
- High-value vendors and transactions
- Country-level payment reporting
- Top-N transaction analysis
- Sequential payment analysis
- Running totals and cumulative calculations
- Historical average comparisons
- Payment trend detection
- Identification of significant payment increases
- Contactable vendor analysis
- Increasing payment streak analysis
- Finance monitoring and reconciliation support
