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

/*=========================================================
Query 6
Business Question:
Show the top 3 highest payment transactions within each
country using a window function.
=========================================================*/

WITH RankedPayments AS
(
    SELECT
        v.country,
        v.vendor_name,
        p.payment_amount_num,
        RANK() OVER
        (
            PARTITION BY v.country
            ORDER BY p.payment_amount_num DESC
        ) AS Payment_Rank
    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
)

SELECT
    country,
    vendor_name,
    payment_amount_num,
    Payment_Rank
FROM RankedPayments
WHERE Payment_Rank <= 3
ORDER BY
    country,
    Payment_Rank,
    payment_amount_num DESC;

/*=========================================================
Query 7
Business Question:
For each vendor, display every payment together with the
previous payment and calculate the difference between them
using the LAG() window function.
=========================================================*/

WITH VendorPayments AS
(
    SELECT
        v.vendor_name,
        p.payment_id_num,
        p.payment_date,
        p.payment_amount_num AS Payment_Amount,
        LAG(p.payment_amount_num) OVER
        (
            PARTITION BY v.vendor_id_num
            ORDER BY
                p.payment_date,
                p.payment_id_num
        ) AS Previous_Payment
    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
)

SELECT
    vendor_name,
    payment_id_num,
    payment_date,
    Payment_Amount,
    Previous_Payment,
    (Payment_Amount - Previous_Payment) AS Difference_From_Previous_Payment
FROM VendorPayments
ORDER BY
    vendor_name,
    payment_date DESC,
    payment_id_num DESC;

/*=========================================================
Query 8
Business Question:
Create a financial payment summary report that displays
every payment together with the vendor's running total,
total payments, highest payment, lowest payment, and
average payment without collapsing individual records.
=========================================================*/

SELECT
    v.vendor_name,
    p.payment_date,
    p.payment_amount_num,

    SUM(p.payment_amount_num) OVER
    (
        PARTITION BY v.vendor_id_num
        ORDER BY
            p.payment_date,
            p.payment_id_num
    ) AS Running_Total,

    SUM(p.payment_amount_num) OVER
    (
        PARTITION BY v.vendor_id_num
    ) AS Total_Payments,

    MAX(p.payment_amount_num) OVER
    (
        PARTITION BY v.vendor_id_num
    ) AS Highest_Payment,

    MIN(p.payment_amount_num) OVER
    (
        PARTITION BY v.vendor_id_num
    ) AS Lowest_Payment,

    ROUND
    (
        AVG(p.payment_amount_num) OVER
        (
            PARTITION BY v.vendor_id_num
        ),
        2
    ) AS Average_Payment

FROM Vendors v
JOIN Payments p
ON v.vendor_id_num = p.vendor_id_num

ORDER BY
    v.vendor_name,
    p.payment_date,
    p.payment_id_num;
