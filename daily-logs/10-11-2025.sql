What substring(trans_date, 1, 7) Does
This extracts the first 7 characters of the trans_date string.
If trans_date is '2025-11-10', then:

substring(trans_date, 1, 7) → '2025-11'

This is useful when you want to group or filter data by month, ignoring the day part.

🔹 Other Common Date Formatting Techniques (by SQL dialect)
 🔹MySQL

Extract year: YEAR(trans_date) → 2025
Extract month: MONTH(trans_date) → 11
Format as YYYY-MM: DATE_FORMAT(trans_date, '%Y-%m') → '2025-11'
Format as Month Name: DATE_FORMAT(trans_date, '%M') → 'November'

🔹PostgreSQL

Extract year: EXTRACT(YEAR FROM trans_date) → 2025
Extract month: EXTRACT(MONTH FROM trans_date) → 11
Format as YYYY-MM: TO_CHAR(trans_date, 'YYYY-MM') → '2025-11'
Format as full date: TO_CHAR(trans_date, 'DD Mon YYYY') → '10 Nov 2025'

🔹 SQL Server

Extract year: YEAR(trans_date)
Extract month: MONTH(trans_date)
Format as YYYY-MM: FORMAT(trans_date, 'yyyy-MM')

🔹 When to Use substring() vs Date Functions

Use CaseRecommended MethodGrouping by monthDATE_FORMAT() or TO_CHAR()Filtering by year/monthYEAR() and MONTH()Simple string slicingsubstring() (only if date is stored as string)

🔹 Tip
If your trans_date column is stored as a string (e.g., '2025-11-10' as VARCHAR), then substring() works fine.
But if it's stored as a DATE or DATETIME type, it's better to use proper date functions like DATE_FORMAT() or TO_CHAR() for accuracy and flexibility.
-----------------------------------------------------------------------------------------------------------------------------------
1193 leetcode
Table: Transactions

+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| id            | int     |
| country       | varchar |
| state         | enum    |
| amount        | int     |
| trans_date    | date    |
+---------------+---------+
id is the primary key of this table.
The table has information about incoming transactions.
The state column is an enum of type ["approved", "declined"].
 

Write an SQL query to find for each month and country, the number of transactions and their total amount, the number of approved transactions and their total amount.

Return the result table in any order.

The query result format is in the following example.

 

Example 1:

Input: 
Transactions table:
+------+---------+----------+--------+------------+
| id   | country | state    | amount | trans_date |
+------+---------+----------+--------+------------+
| 121  | US      | approved | 1000   | 2018-12-18 |
| 122  | US      | declined | 2000   | 2018-12-19 |
| 123  | US      | approved | 2000   | 2019-01-01 |
| 124  | DE      | approved | 2000   | 2019-01-07 |
+------+---------+----------+--------+------------+
Output: 
+----------+---------+-------------+----------------+--------------------+-----------------------+
| month    | country | trans_count | approved_count | trans_total_amount | approved_total_amount |
+----------+---------+-------------+----------------+--------------------+-----------------------+
| 2018-12  | US      | 2           | 1              | 3000               | 1000                  |
| 2019-01  | US      | 1           | 1              | 2000               | 2000                  |
| 2019-01  | DE      | 1           | 1              | 2000               | 2000                  |
+----------+---------+-------------+----------------+--------------------+-----------------------+
Solution :

SELECT 
    LEFT(trans_date, 7) AS month,
    country, 
    COUNT(id) AS trans_count,
    SUM(state = 'approved') AS approved_count,
    SUM(amount) AS trans_total_amount,
    SUM((state = 'approved') * amount) AS approved_total_amount
FROM 
    Transactions
GROUP BY 
    month, country;
