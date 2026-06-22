1-- Question - Write a solution to find the names of all the salespersons who did not have any orders related to the company with the name "RED".
2
3-- Table: SalesPerson
4
5-- +-----------------+---------+
6-- | Column Name     | Type    |
7-- +-----------------+---------+
8-- | sales_id        | int     |
9-- | name            | varchar |
10
11
12-- Table: Orders
13
14-- +-------------+------+
15-- | Column Name | Type |
16-- +-------------+------+
17-- | order_id    | int  |
18-- | order_date  | date |
19-- | com_id      | int  |
20-- | sales_id    | int  |
21
22
23-- Table: Company
24
25-- +-------------+---------+
26-- | Column Name | Type    |
27-- +-------------+---------+
28-- | com_id      | int     |
29-- | name        | varchar |
30-- | city        | varchar |
31
32-- this query is taking a lot of time due to the 3 joins ### try to get rid of joins 
33
34--    select name from 
35--    SalesPerson where name not in (select s.name
36--    from SalesPerson s 
37--    left join Orders o 
38--    on s.sales_id=o.sales_id
39--    join Company c 
40--    on o.com_id=c.com_id
41--    where c.name = RED) 
42
43select name from 
44SalesPerson 
45where sales_id not in(
46    select o.sales_id
47    from 
48    Orders o 
49    join Company c
50    on o.com_id=c.com_id
51    where c.name in('RED')
52)
53