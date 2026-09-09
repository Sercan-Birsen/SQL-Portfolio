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
Generate a payment history report showing each payment
alongside the previous payment and previous payment date
for every vendor to support payment trend analysis.
=========================================================*/

WITH VendorPayment AS
(
    SELECT
        v.vendor_name,
        p.payment_id_num,
        p.payment_date,
        p.payment_amount_num,

        LAG(p.payment_amount_num) OVER
        (
            PARTITION BY v.vendor_id_num
            ORDER BY
                p.payment_date,
                p.payment_id_num
        ) AS Previous_Payment,

        LAG(p.payment_date) OVER
        (
            PARTITION BY v.vendor_id_num
            ORDER BY
                p.payment_date,
                p.payment_id_num
        ) AS Previous_Payment_Date

    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
)

SELECT
    vendor_name,
    payment_date,
    payment_amount_num,
    Previous_Payment_Date,
    Previous_Payment,
    (payment_amount_num - Previous_Payment) AS Payment_Difference
FROM VendorPayment
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

/*=========================================================
Query 9
Business Question:
Identify vendors whose most recent payment exceeds
their historical average payment.
=========================================================*/

WITH Latest_Payment AS
(
    SELECT
        v.vendor_name,
        p.payment_amount_num,
        ROW_NUMBER() OVER
        (
            PARTITION BY p.vendor_id_num
            ORDER BY
                p.payment_date DESC,
                p.payment_id_num DESC
        ) AS Payment_Rank,

        AVG(p.payment_amount_num) OVER
        (
            PARTITION BY p.vendor_id_num
        ) AS Avg_Payment

    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
)

SELECT
    vendor_name,
    payment_amount_num,
    Avg_Payment
FROM Latest_Payment
WHERE
    Payment_Rank = 1
    AND payment_amount_num > Avg_Payment
ORDER BY
    payment_amount_num DESC;

/*=========================================================
Query 10
Business Question:
Identify vendors whose latest payment increased by at
least 20% compared to their previous payment.
=========================================================*/

WITH VendorPayments AS
(
    SELECT
        v.vendor_name,
        p.payment_id_num,
        p.payment_date,
        p.payment_amount_num,

        LAG(p.payment_amount_num) OVER
        (
            PARTITION BY v.vendor_id_num
            ORDER BY
                p.payment_date,
                p.payment_id_num
        ) AS Previous_Payment,

        ROW_NUMBER() OVER
        (
            PARTITION BY v.vendor_id_num
            ORDER BY
                p.payment_date DESC,
                p.payment_id_num DESC
        ) AS Payment_Rank

    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
)

SELECT
    vendor_name,
    payment_id_num,
    payment_date,
    payment_amount_num AS Latest_Payment,
    Previous_Payment,
    (payment_amount_num - Previous_Payment) AS Increase_Amount,
    ROUND
    (
        (
            (payment_amount_num - Previous_Payment)
            / NULLIF(Previous_Payment, 0)
        ) * 100,
        2
    ) AS Increase_Percentage
FROM VendorPayments
WHERE
    Payment_Rank = 1
    AND payment_amount_num >= Previous_Payment * 1.20
ORDER BY
    Increase_Percentage DESC;

/*=========================================================
Query 11
Business Question:
Identify vendors whose latest payment is also their
highest payment ever.
=========================================================*/

WITH VendorPayment AS
(
    SELECT
        v.vendor_name,
        p.payment_date,
        MAX(p.payment_amount_num) OVER
        (
            PARTITION BY v.vendor_id_num
        ) AS Highest_Payment,
        p.payment_amount_num AS Latest_Payment,
        ROW_NUMBER() OVER
        (
            PARTITION BY v.vendor_id_num
            ORDER BY
                p.payment_date DESC,
                p.payment_id_num DESC
        ) AS Payment_Rank_Date
    FROM Vendors v
    JOIN Payments p
    ON v.vendor_id_num = p.vendor_id_num
)

SELECT
    vendor_name,
    payment_date,
    Highest_Payment,
    Latest_Payment
FROM VendorPayment
WHERE
    Payment_Rank_Date = 1
    AND Highest_Payment = Latest_Payment
ORDER BY
    Highest_Payment DESC;

/*=========================================================
Query 12
Business Question:
Finance wants to contact vendors whose total payments
exceed the average vendor total. Display the vendor name,
country, primary contact, email, department, total payment,
average payment amount, and number of payments.
=========================================================*/

WITH VendorPayments AS
(
    SELECT
        v.vendor_id_num,
        v.vendor_name,
        v.country,
        SUM(p.payment_amount_num) AS Total_Payment,
        ROUND(AVG(p.payment_amount_num), 2) AS Average_Payment,
        COUNT(p.payment_id_num) AS Number_Of_Payments
    FROM Vendors v
    JOIN Payments p
        ON v.vendor_id_num = p.vendor_id_num
    GROUP BY
        v.vendor_id_num,
        v.vendor_name,
        v.country
)

SELECT
    vp.vendor_name,
    vp.country,
    vc.contact_name,
    vc.email,
    vc.department,
    vp.Number_Of_Payments,
    vp.Total_Payment,
    vp.Average_Payment
FROM VendorPayments vp
LEFT JOIN Vendor_Contacts vc
    ON vp.vendor_id_num = vc.vendor_id_num
WHERE vp.Total_Payment >
(
    SELECT AVG(Total_Payment)
    FROM VendorPayments
)
ORDER BY
    vp.Total_Payment DESC,
    vp.vendor_name;

/*=========================================================
Query 13
Business Question:
Finance wants to identify vendors with the longest streak
of consecutive payments where each payment was higher than
the previous payment. Display the vendor name, vendor ID,
length of the longest increasing streak, start date, and
end date. If multiple streaks have the same maximum length,
select the most recent streak.
=========================================================*/

WITH VendorPayment AS (
    SELECT
        v.vendor_name,
        v.vendor_id_num,
        p.payment_amount_num,
        p.payment_date,
        p.payment_id_num,

        LAG(p.payment_amount_num) OVER (
            PARTITION BY v.vendor_id_num
            ORDER BY p.payment_date, p.payment_id_num
        ) AS Previous_payment

    FROM Vendors v
    JOIN Payments p
        ON v.vendor_id_num = p.vendor_id_num
),

IncreasingTable AS (
    SELECT
        vendor_name,
        vendor_id_num,
        payment_amount_num,
        payment_date,
        payment_id_num,
        Previous_payment,

        CASE
            WHEN payment_amount_num > Previous_payment
            THEN 1
            ELSE 0
        END AS Is_increasing

    FROM VendorPayment
),

IncreasingTable_ AS (
    SELECT
        vendor_name,
        vendor_id_num,
        payment_amount_num,
        payment_date,
        payment_id_num,
        Previous_payment,
        Is_increasing,

        LAG(Is_increasing) OVER (
            PARTITION BY vendor_id_num
            ORDER BY payment_date, payment_id_num
        ) AS Previous_is_increasing

    FROM IncreasingTable
),

StreakTable AS (
    SELECT
        vendor_name,
        vendor_id_num,
        payment_amount_num,
        payment_date,
        payment_id_num,
        Previous_payment,
        Is_increasing,
        Previous_is_increasing,

        CASE
            WHEN Is_increasing = 1
                 AND (
                     Previous_is_increasing = 0
                     OR Previous_is_increasing IS NULL
                 )
            THEN 1
            ELSE 0
        END AS Streak_start

    FROM IncreasingTable_
),

StreakTable_ AS (
    SELECT
        vendor_name,
        vendor_id_num,
        payment_id_num,
        payment_amount_num,
        payment_date,
        Previous_payment,
        Is_increasing,
        Previous_is_increasing,
        Streak_start,

        SUM(Streak_start) OVER (
            PARTITION BY vendor_id_num
            ORDER BY payment_date, payment_id_num
        ) AS Streak_ID

    FROM StreakTable
),

StreakLengths AS (
    SELECT
        vendor_name,
        vendor_id_num,
        Streak_ID,
        COUNT(*) AS Streak_Length,
        MIN(payment_date) AS Start_Date,
        MAX(payment_date) AS End_Date

    FROM StreakTable_

    WHERE Is_increasing = 1

    GROUP BY
        vendor_name,
        vendor_id_num,
        Streak_ID
),

RankedStreaks AS (
    SELECT
        vendor_name,
        vendor_id_num,
        Streak_ID,
        Streak_Length,
        Start_Date,
        End_Date,

        ROW_NUMBER() OVER (
            PARTITION BY vendor_id_num
            ORDER BY
                Streak_Length DESC,
                End_Date DESC,
                Streak_ID DESC
        ) AS Streak_Rank

    FROM StreakLengths
)

SELECT
    vendor_name,
    vendor_id_num,
    Streak_Length AS Longest_Increasing_Streak,
    Start_Date,
    End_Date

FROM RankedStreaks

WHERE Streak_Rank = 1

ORDER BY Longest_Increasing_Streak DESC;
