1
2
3--QUESTION
4-- Write a solution to find the daily active user count for a period of 30 days ending 2019-07-27 inclusively. A user was active on someday if they made at least one activity on that day.
5
6-- Return the result table in any order.
7
8-- The result format is in the following example.
9
10-- Note: Any activity from ('open_session', 'end_session', 'scroll_down', 'send_message') will be considered valid activity for a user to be considered active on a day.
11
12 
13
14-- Example 1:
15
16-- Input: 
17-- Activity table:
18-- +---------+------------+---------------+---------------+
19-- | user_id | session_id | activity_date | activity_type |
20-- +---------+------------+---------------+---------------+
21-- | 1       | 1          | 2019-07-20    | open_session  |
22-- | 1       | 1          | 2019-07-20    | scroll_down   |
23-- | 1       | 1          | 2019-07-20    | end_session   |
24-- | 2       | 4          | 2019-07-20    | open_session  |
25-- | 2       | 4          | 2019-07-21    | send_message  |
26-- | 2       | 4          | 2019-07-21    | end_session   |
27-- | 3       | 2          | 2019-07-21    | open_session  |
28-- | 3       | 2          | 2019-07-21    | send_message  |
29-- | 3       | 2          | 2019-07-21    | end_session   |
30-- | 4       | 3          | 2019-06-25    | open_session  |
31-- | 4       | 3          | 2019-06-25    | end_session   |
32-- +---------+------------+---------------+---------------+
33-- Output: 
34-- +------------+--------------+ 
35-- | day        | active_users |
36-- +------------+--------------+ 
37-- | 2019-07-20 | 2            |
38-- | 2019-07-21 | 2            |
39-- +------------+--------------+ 
40-- Explanation: Note that we do not care about days with zero active users.
41
42
43
44
45-- this is in mysql
46select activity_date as day,count(distinct user_id) as active_users
47from Activity
48where activity_date>'2019-06-27' and activity_date<='2019-07-27'
49group by activity_date
50
51--this is in postgreSQL:
52--  PostgreSQL query statement below
53-- SELECT activity_date AS day, COUNT(DISTINCT user_id) AS active_users  
54-- FROM Activity 
55-- WHERE activity_date > '2019-07-27'::date - INTERVAL '30 days' AND activity_date <= '2019-07-27'
56-- GROUP BY activity_date
57
58
59--this is in Bigquery 
60-- 
61-- WHERE activity_date > DATE_SUB('2019-07-27', INTERVAL 30 DAY)  AND activity_date <= '2019-07-27'