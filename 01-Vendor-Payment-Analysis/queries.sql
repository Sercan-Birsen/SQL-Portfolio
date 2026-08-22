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
