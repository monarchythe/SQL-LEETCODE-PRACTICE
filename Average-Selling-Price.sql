1## question--
2-- Write a solution to find the average selling price for each product. average_price should be rounded to 2 decimal places. If a product does not have any sold units, its average selling price is assumed to be 0.
3
4-- Return the result table in any order.
5
6-- The result format is in the following example.
7
8 
9
10-- Example 1:
11
12-- Input: 
13-- Prices table:
14-- +------------+------------+------------+--------+
15-- | product_id | start_date | end_date   | price  |
16-- +------------+------------+------------+--------+
17-- | 1          | 2019-02-17 | 2019-02-28 | 5      |
18-- | 1          | 2019-03-01 | 2019-03-22 | 20     |
19-- | 2          | 2019-02-01 | 2019-02-20 | 15     |
20-- | 2          | 2019-02-21 | 2019-03-31 | 30     |
21-- +------------+------------+------------+--------+
22-- UnitsSold table:
23-- +------------+---------------+-------+
24-- | product_id | purchase_date | units |
25-- +------------+---------------+-------+
26-- | 1          | 2019-02-25    | 100   |
27-- | 1          | 2019-03-01    | 15    |
28-- | 2          | 2019-02-10    | 200   |
29-- | 2          | 2019-03-22    | 30    |
30-- +------------+---------------+-------+
31-- Output: 
32-- +------------+---------------+
33-- | product_id | average_price |
34-- +------------+---------------+
35-- | 1          | 6.96          |
36-- | 2          | 16.96         |
37-- +------------+---------------+
38
39######-- NOTE --*******************************************
40-- If in JOIN b/w 2 tables, if both of the joining columns in the 2 tables has repeated values !!!!, then CROSS JOIN will happen, and you dont want that !!!
41-- ##################--************************************
42-- The key distinction — timing:
43
44-- ON clause runs DURING THE JOIN-  It decides which rows to match together. If nothing matches, LEFT JOIN still keeps the left-side row (product 1) and fills the right-side columns with NULL. This is the whole point of LEFT JOIN — it's a guarantee that doesn't get broken by ON.
45-- WHERE clause runs AFTER THE JOIN is fully complete. By this point, the row already exists (with NULLs). WHERE then asks "does this row satisfy my condition?" — and since NULL BETWEEN ... evaluates to NULL (unknown), WHERE throws the row away, because WHERE only keeps rows that are TRUE.
46
47-- This is why the  "AND instead of WHERE" question matters — when you moved the date check into ON, you stopped that NULL row from ever being evaluated by WHERE at all. There's no WHERE clause left to drop it.
48-- Then COALESCE handles a separate problem — after GROUP BY, product 1's group has only NULL units, so SUM(units) returns NULL, and dividing by NULL gives NULL. COALESCE(..., 0) just swaps that final NULL result for 0.
49-- ##################--************************************
50
51
52
53
54-- ###### WRONG SOLUTION ************************
55-- wrong where !!! and wrong CASE FOR NULL !!!!!!!!
56
57-- Select 
58--     p.product_id,
59--     CASE 
60--         when u.purchase_date is null then 0
61--     Else
62--         Round(SUM(p.price*u.units)/sum(u.units),2) 
63--     END as average_price
64
65-- from
66-- Prices p 
67-- left join UnitsSold u 
68-- on p.product_id = u.product_id
69-- WHERE u.purchase_date between p.start_date and p.end_date
70-- group by p.product_id;
71
72-- ########-- Correct Solution  --******************
73-- ########--                   --******************
74
75Select 
76    p.product_id,
77    COALESCE(Round(SUM(p.price*u.units)/sum(u.units),2),0) as average_price
78from
79Prices p 
80left join UnitsSold u 
81on p.product_id = u.product_id
82AND u.purchase_date between p.start_date and p.end_date
83group by p.product_id;
84