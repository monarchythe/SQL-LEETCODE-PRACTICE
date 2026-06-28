1-- We define query quality as:
2
3-- The average of the ratio between query rating and its position.
4
5-- We also define poor query percentage as:
6
7-- The percentage of all queries with rating less than 3.
8
9-- Write a solution to find each query_name, the quality and poor_query_percentage.
10
11-- Both quality and poor_query_percentage should be rounded to 2 decimal places.
12
13-- Return the result table in any order.
14
15-- The result format is in the following example.
16
17 
18
19-- Example 1:
20
21-- Input: 
22-- Queries table:
23-- +------------+-------------------+----------+--------+
24-- | query_name | result            | position | rating |
25-- +------------+-------------------+----------+--------+
26-- | Dog        | Golden Retriever  | 1        | 5      |
27-- | Dog        | German Shepherd   | 2        | 5      |
28-- | Dog        | Mule              | 200      | 1      |
29-- | Cat        | Shirazi           | 5        | 2      |
30-- | Cat        | Siamese           | 3        | 3      |
31-- | Cat        | Sphynx            | 7        | 4      |
32-- +------------+-------------------+----------+--------+
33-- Output: 
34-- +------------+---------+-----------------------+
35-- | query_name | quality | poor_query_percentage |
36-- +------------+---------+-----------------------+
37-- | Dog        | 2.50    | 33.33                 |
38-- | Cat        | 0.66    | 33.33                 |
39-- +------------+---------+-----------------------+
40-- Explanation: 
41-- Dog queries quality is ((5 / 1) + (5 / 2) + (1 / 200)) / 3 = 2.50
42-- Dog queries poor_ query_percentage is (1 / 3) * 100 = 33.33
43
44-- Cat queries quality equals ((2 / 5) + (3 / 3) + (4 / 7)) / 3 = 0.66
45-- Cat queries poor_ query_percentage is (1 / 3) * 100 = 33.33
46
47select 
48    query_name,
49    Round(AVG(rating/position),2) as quality,
50    Round((Count(case when rating <3 then 1 end)/count(*))*100, 2 ) as poor_query_percentage-- this was important
51from Queries
52group by query_name;