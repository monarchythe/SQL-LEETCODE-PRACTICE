1-- Question !!!! - REFORMATING THE ENTRE TABBLE 
2-- eformat the table such that there is a department id column and a revenue column for each month.
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
13-- Department table:
14-- +------+---------+-------+
15-- | id   | revenue | month |
16-- +------+---------+-------+
17-- | 1    | 8000    | Jan   |
18-- | 2    | 9000    | Jan   |
19-- | 3    | 10000   | Feb   |
20-- | 1    | 7000    | Feb   |
21-- | 1    | 6000    | Mar   |
22-- +------+---------+-------+
23-- Output: 
24-- +------+-------------+-------------+-------------+-----+-------------+
25-- | id   | Jan_Revenue | Feb_Revenue | Mar_Revenue | ... | Dec_Revenue |
26-- +------+-------------+-------------+-------------+-----+-------------+
27-- | 1    | 8000        | 7000        | 6000        | ... | null        |
28-- | 2    | 9000        | null        | null        | ... | null        |
29-- | 3    | null        | 10000       | null        | ... | null        |
30-- +------+-------------+-------------+-------------+-----+-------------+
31-- Explanation: The revenue from Apr to Dec is null.
32-- Note that the result table has 13 columns (1 for the department id + 12 for the months).
33
34    -- Solution - 
35    -- The core idea — think conditional aggregation again:
36    -- with SUM(CASE WHEN ... THEN ... END)?
37    -- just repeated 12 times — once per month:
38
39    -- we need group by because the ids are same for each month, they start with the value 1,2,3,, for JAN then 1,2,3,4-- for FEB, so if we GROUP BY id the for id = 1 ->(FEB,JAN,MAR....) GROUP togather, now do the case and create all the columns !!!!!!!!!!!!!!!!!!!!!!!!!!!!! V.V.V.V, imP GROUPING THEM!!!!!!!!!!!!!!!!!!!!!!!!
40
41    -- Then you have to use SUM!!!!!!
42
43SELECT
44    id,
45    SUM(CASE WHEN month = 'Jan' THEN revenue END) AS Jan_Revenue,
46    SUM(CASE WHEN month = 'Feb' THEN revenue END) AS Feb_Revenue,
47    SUM(CASE WHEN month = 'Mar' THEN revenue END) AS Mar_Revenue,
48    SUM(CASE WHEN month = 'Apr' THEN revenue END) AS Apr_Revenue,
49    SUM(CASE WHEN month = 'May' THEN revenue END) AS May_Revenue,
50    SUM(CASE WHEN month = 'Jun' THEN revenue END) AS Jun_Revenue,
51    SUM(CASE WHEN month = 'Jul' THEN revenue END) AS Jul_Revenue,
52    SUM(CASE WHEN month = 'Aug' THEN revenue END) AS Aug_Revenue,
53    SUM(CASE WHEN month = 'Sep' THEN revenue END) AS Sep_Revenue,
54    SUM(CASE WHEN month = 'Oct' THEN revenue END) AS Oct_Revenue,
55    SUM(CASE WHEN month = 'Nov' THEN revenue END) AS Nov_Revenue,
56    SUM(CASE WHEN month = 'Dec' THEN revenue END) AS Dec_Revenue
57FROM Department
58GROUP BY id
59    