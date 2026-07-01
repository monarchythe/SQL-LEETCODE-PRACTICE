1-- -- Write a solution to find the IDs of the users who visited without making any transactions and the number of times they made these types of visits.
2
3-- Return the result table sorted in any order.
4
5-- The result format is in the following example.
6
7 
8
9-- Example 1:
10
11-- Input: 
12-- Visits
13-- +----------+-------------+
14-- | visit_id | customer_id |
15-- +----------+-------------+
16-- | 1        | 23          |
17-- | 2        | 9           |
18-- | 4        | 30          |
19-- | 5        | 54          |
20-- | 6        | 96          |
21-- | 7        | 54          |
22-- | 8        | 54          |
23-- +----------+-------------+
24-- Transactions
25-- +----------------+----------+--------+
26-- | transaction_id | visit_id | amount |
27-- +----------------+----------+--------+
28-- | 2              | 5        | 310    |
29-- | 3              | 5        | 300    |
30-- | 9              | 5        | 200    |
31-- | 12             | 1        | 910    |
32-- | 13             | 2        | 970    |
33-- +----------------+----------+--------+
34-- Output: 
35-- +-------------+----------------+
36-- | customer_id | count_no_trans |
37-- +-------------+----------------+
38-- | 54          | 2              |
39-- | 30          | 1              |
40-- | 96          | 1              |
41-- +-------------+----------------+
42-- Explanation: 
43-- Customer with id = 23 visited the mall once and made one transaction during the visit with id = 12.
44-- Customer with id = 9 visited the mall once and made one transaction during the visit with id = 13.
45-- Customer with id = 30 visited the mall once and did not make any transactions.
46-- Customer with id = 54 visited the mall three times. During 2 visits they did not make any transactions, and during one visit they made 3 transactions.
47-- Customer with id = 96 visited the mall once and did not make any transactions.
48-- As we can see, users with IDs 30 and 96 visited the mall one time without making any transactions. Also, user 54 visited the mall twice and did not make any transactions
49
50select customer_id,count(*) as count_no_trans
51from Visits v
52left join Transactions t
53on v.visit_id=t.visit_id
54where t.transaction_id is null
55group by customer_id
56
57
58-- LEFT JOIN Transactions t
59-- ON v.visit_id = t.visit_id AND t.transaction_id IS NULL
60
61-- This tells the join: "only match rows where transaction_id is already NULL" — which makes no sense since Transactions rows always have real transaction_ids. So every visit gets no match and everything shows as NULL — wrong result.