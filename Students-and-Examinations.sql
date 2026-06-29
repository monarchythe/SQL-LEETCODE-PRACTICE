1-- ####QUESTION ####################
2-- Write a solution to find the number of times each student attended each exam.
3
4-- Return the result table ordered by student_id and subject_name.
5
6-- The result format is in the following example.
7
8 
9
10-- Example 1:
11
12-- Input: 
13-- Students table:
14-- +------------+--------------+
15-- | student_id | student_name |
16-- +------------+--------------+
17-- | 1          | Alice        |
18-- | 2          | Bob          |
19-- | 13         | John         |
20-- | 6          | Alex         |
21-- +------------+--------------+
22-- Subjects table:
23-- +--------------+
24-- | subject_name |
25-- +--------------+
26-- | Math         |
27-- | Physics      |
28-- | Programming  |
29-- +--------------+
30-- Examinations table:
31-- +------------+--------------+
32-- | student_id | subject_name |
33-- +------------+--------------+
34-- | 1          | Math         |
35-- | 1          | Physics      |
36-- | 1          | Programming  |
37-- | 2          | Programming  |
38-- | 1          | Physics      |
39-- | 1          | Math         |
40-- | 13         | Math         |
41-- | 13         | Programming  |
42-- | 13         | Physics      |
43-- | 2          | Math         |
44-- | 1          | Math         |
45-- +------------+--------------+
46-- Output: 
47-- +------------+--------------+--------------+----------------+
48-- | student_id | student_name | subject_name | attended_exams |
49-- +------------+--------------+--------------+----------------+
50-- | 1          | Alice        | Math         | 3              |
51-- | 1          | Alice        | Physics      | 2              |
52-- | 1          | Alice        | Programming  | 1              |
53-- | 2          | Bob          | Math         | 1              |
54-- | 2          | Bob          | Physics      | 0              |
55-- | 2          | Bob          | Programming  | 1              |
56-- | 6          | Alex         | Math         | 0              |
57-- | 6          | Alex         | Physics      | 0              |
58-- | 6          | Alex         | Programming  | 0              |
59-- | 13         | John         | Math         | 1              |
60-- | 13         | John         | Physics      | 1              |
61-- | 13         | John         | Programming  | 1              |
62-- +------------+--------------+--------------+----------------+
63-- Explanation: 
64-- The result table should contain all students and all subjects.
65-- Alice attended the Math exam 3 times, the Physics exam 2 times, and the Programming exam 1 time.
66-- Bob attended the Math exam 1 time, the Programming exam 1 time, and did not attend the Physics exam.
67-- Alex did not attend any exams.
68-- John attended the Math exam 1 time, the Physics exam 1 time, and the Programming exam 1 time.
69
70-- #######imp - Why COUNT(e.subject_name) and not COUNT(*) — important detail: COUNT(*) counts rows regardless of NULL, but COUNT(e.subject_name) only counts non-NULL matches. For Alex, the LEFT JOIN produces one row with e.subject_name = NULL per subject — COUNT(*) would wrongly give 1, but COUNT(e.subject_name) correctly gives 0 ###########
71
72SELECT s.student_id, s.student_name, sub.subject_name, 
73       COUNT(e.subject_name) AS attended_exams
74FROM Students s
75CROSS JOIN Subjects sub
76LEFT JOIN Examinations e 
77  ON s.student_id = e.student_id AND sub.subject_name = e.subject_name
78GROUP BY s.student_id, s.student_name, sub.subject_name
79ORDER BY s.student_id, sub.subject_name;
80
81-- AND sub.subject_name = e.subject_name
82-- Without it, you'd be joining Examinations only on student_id, which means Alice's single Math exam row would get duplicated across Math, Physics, AND Programming rows incorrectly