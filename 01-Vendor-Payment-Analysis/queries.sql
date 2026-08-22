/*=========================================================
Project: Vendor Payment Analysis
Database: SQLite
Author: Sercan Birsen
=========================================================*/


/*=========================================================
Query 1
Business Question:
Which countries have received the highest total payments?
=========================================================*/

SELECT
    v.country,
    SUM(p.payment_amount_num) AS Total_Payment
FROM Vendors v
JOIN Payments p
ON v.vendor_id_num = p.vendor_id_num
GROUP BY v.country
ORDER BY Total_Payment DESC;

/*=========================================================
Query 2
Business Question:
Which vendors have not received any payments?
=========================================================*/

SELECT
    v.vendor_name,
    v.country,
    v.status
FROM Vendors v
LEFT JOIN Payments p
ON v.vendor_id_num = p.vendor_id_num
WHERE p.vendor_id_num IS NULL
ORDER BY v.vendor_name;

/*=========================================================
Query 3
Business Question:
Which countries have received more than 500,000 in total payments?
=========================================================*/

WITH CountryPayments AS
(
    SELECT
        v.country,
        SUM(p.payment_amount_num) AS Total_Payment
    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
    GROUP BY v.country
)

SELECT *
FROM CountryPayments
WHERE Total_Payment > 500000
ORDER BY Total_Payment DESC;

/*=========================================================
Query 4
Business Question:
Which vendors have total payments above the average
vendor total payment?
=========================================================*/

WITH VendorPayments AS
(
    SELECT
        v.vendor_id_num,
        v.vendor_name,
        SUM(p.payment_amount_num) AS Total_Payment
    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
    GROUP BY
        v.vendor_id_num,
        v.vendor_name
)

SELECT *
FROM VendorPayments
WHERE Total_Payment >
(
    SELECT AVG(Total_Payment)
    FROM VendorPayments
)
ORDER BY Total_Payment DESC;

/*=========================================================
Query 5
Business Question:
Provide a payment summary for each country, including the
number of payments, total payment amount, minimum payment,
maximum payment, and average payment.
=========================================================*/

SELECT
    v.country,
    COUNT(p.payment_id_num) AS Payment_Count,
    SUM(p.payment_amount_num) AS Total_Payment,
    MIN(p.payment_amount_num) AS Minimum_Payment,
    MAX(p.payment_amount_num) AS Maximum_Payment,
    ROUND(AVG(p.payment_amount_num), 2) AS Average_Payment
FROM Vendors v
JOIN Payments p
ON v.vendor_id_num = p.vendor_id_num
GROUP BY v.country
ORDER BY Total_Payment DESC;
