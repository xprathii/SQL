✅ 1. CURDATE()

Returns the current date (without time).
Example:
SQLSELECT CURDATE();
Output: 2025-11-16 (today’s date).
Use case: Instead of hardcoding '2019-07-27', 


✅ 2. NOW()

Returns the current date and time.
Example:
SQLSELECT NOW();
Output: 2025-11-16 21:08:00.
Use case: Useful when you need both date and time for logging or filtering.


✅ 3. DATE_ADD(date, INTERVAL n unit)

Adds a time interval to a date.
Example:
SQLSELECT DATE_ADD('2025-11-16', INTERVAL 10 DAY);
Output: 2025-11-26.
Opposite of DATE_SUB.


✅ 4. DATEDIFF(date1, date2)

Returns the difference in days between two dates.
Example:
SQLSELECT DATEDIFF('2025-11-16', '2025-11-01');
Output: 15.


✅ 5. LAST_DAY(date)

Returns the last day of the month for the given date.
Example:
SQLSELECT LAST_DAY('2025-11-16');
Output: 2025-11-30.


✅ 6. DAY(date), MONTH(date), YEAR(date)

Extracts parts of a date.
Example:
SQLSELECT DAY('2025-11-16'), MONTH('2025-11-16'), YEAR('2025-11-16');
Output: 16 | 11 | 2025.


✅ 7. DATE_FORMAT(date, format)

Formats a date into a custom string.
Example:
SQLSELECT DATE_FORMAT(NOW(), '%d-%m-%Y %H:%i:%s');
Output: 16-11-2025 21:08:00.
-------------------------------------------------------------------------------------------------------------

Table: Activity
+---------------+---------+
| Column Name   | Type    |
+---------------+---------+
| user_id       | int     |
| session_id    | int     |
| activity_date | date    |
| activity_type | enum    |
+---------------+---------+
This table may have duplicate rows.
The activity_type column is an ENUM (category) of type ('open_session', 'end_session', 'scroll_down', 'send_message').
The table shows the user activities for a social media website. 
Note that each session belongs to exactly one user.
Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.
Return the result table in any order.
The result format is in the following example.
Note: Any activity from ('open_session', 'end_session', 'scroll_down', 'send_message') will be considered valid activity for a user to be considered active on a day.

 

Example 1:

Input: 
Activity table:
+---------+------------+---------------+---------------+
| user_id | session_id | activity_date | activity_type |
+---------+------------+---------------+---------------+
| 1       | 1          | 2019-07-20    | open_session  |
| 1       | 1          | 2019-07-20    | scroll_down   |
| 1       | 1          | 2019-07-20    | end_session   |
| 2       | 4          | 2019-07-20    | open_session  |
| 2       | 4          | 2019-07-21    | send_message  |
| 2       | 4          | 2019-07-21    | end_session   |
| 3       | 2          | 2019-07-21    | open_session  |
| 3       | 2          | 2019-07-21    | send_message  |
| 3       | 2          | 2019-07-21    | end_session   |
| 4       | 3          | 2019-06-25    | open_session  |
| 4       | 3          | 2019-06-25    | end_session   |
+---------+------------+---------------+---------------+
Output: 
+------------+--------------+ 
| day        | active_users |
+------------+--------------+ 
| 2019-07-20 | 2            |
| 2019-07-21 | 2            |
+------------+--------------+ 
Explanation: Note that we do not care about days with zero active users.

# Write your MySQL query statement below
SELECT 
    a.activity_date AS day,
    COUNT(DISTINCT user_id) AS active_users
FROM activity a
WHERE activity_date BETWEEN DATE_SUB('2019-07-27', INTERVAL 29 DAY) AND '2019-07-27'
GROUP BY activity_date;
