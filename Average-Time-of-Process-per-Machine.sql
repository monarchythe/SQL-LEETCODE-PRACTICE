1-- There is a factory website that has several machines each running the same number of processes. Write a solution to find the average time each machine takes to complete a process.
2
3-- The time to complete a process is the 'end' timestamp minus the 'start' timestamp. The average time is calculated by the total time to complete every process on the machine divided by the number of processes that were run.
4
5-- The resulting table should have the machine_id along with the average time as processing_time, which should be rounded to 3 decimal places.
6
7-- Return the result table in any order.
8
9-- The result format is in the following example.
10
11 
12
13-- Example 1:
14
15-- Input: 
16-- Activity table:
17-- +------------+------------+---------------+-----------+
18-- | machine_id | process_id | activity_type | timestamp |
19-- +------------+------------+---------------+-----------+
20-- | 0          | 0          | start         | 0.712     |
21-- | 0          | 0          | end           | 1.520     |
22-- | 0          | 1          | start         | 3.140     |
23-- | 0          | 1          | end           | 4.120     |
24-- | 1          | 0          | start         | 0.550     |
25-- | 1          | 0          | end           | 1.550     |
26-- | 1          | 1          | start         | 0.430     |
27-- | 1          | 1          | end           | 1.420     |
28-- | 2          | 0          | start         | 4.100     |
29-- | 2          | 0          | end           | 4.512     |
30-- | 2          | 1          | start         | 2.500     |
31-- | 2          | 1          | end           | 5.000     |
32-- +------------+------------+---------------+-----------+
33-- Output: 
34-- +------------+-----------------+
35-- | machine_id | processing_time |
36-- +------------+-----------------+
37-- | 0          | 0.894           |
38-- | 1          | 0.995           |
39-- | 2          | 1.456           |
40-- +------------+-----------------+
41-- Explanation: 
42-- There are 3 machines running 2 processes each.
43-- Machine 0's average time is ((1.520 - 0.712) + (4.120 - 3.140)) / 2 = 0.894
44-- Machine 1's average time is ((1.550 - 0.550) + (1.420 - 0.430)) / 2 = 0.995
45-- Machine 2's average time is ((4.512 - 4.100) + (5.000 - 2.500)) / 2 = 1.456
46
47
48
49SELECT machine_id,
50ROUND(AVG(CASE WHEN activity_type = 'end' THEN timestamp END) - 
51      AVG(CASE WHEN activity_type = 'start' THEN timestamp END), 3) as processing_time
52FROM Activity
53GROUP BY machine_id;
54
55-- It works because of basic math — averaging then subtracting equals subtracting then averaging:
56-- (a + b)/2 - (c + d)/2 = ((a-c) + (b-d)) / 2