1-- #Write a solution to find the users who have valid emails.
2
3-- A valid e-mail has a prefix name and a domain where:
4
5-- The prefix name is a string that may contain letters (upper or lower case), digits, underscore '_', period '.', and/or dash '-'. The prefix name must start with a letter.
6-- The domain is '@leetcode.com'.
7-- Return the result table in any order.
8
9-- The result format is in the following example.
10
11 
12
13-- Example 1:
14
15-- Input: 
16-- Users table:
17-- +---------+-----------+-------------------------+
18-- | user_id | name      | mail                    |
19-- +---------+-----------+-------------------------+
20-- | 1       | Winston   | winston@leetcode.com    |
21-- | 2       | Jonathan  | jonathanisgreat         |
22-- | 3       | Annabelle | bella-@leetcode.com     |
23-- | 4       | Sally     | sally.come@leetcode.com |
24-- | 5       | Marwan    | quarz#2020@leetcode.com |
25-- | 6       | David     | david69@gmail.com       |
26-- | 7       | Shapiro   | .shapo@leetcode.com     |
27-- +---------+-----------+-------------------------+
28-- Output: 
29-- +---------+-----------+-------------------------+
30-- | user_id | name      | mail                    |
31-- +---------+-----------+-------------------------+
32-- | 1       | Winston   | winston@leetcode.com    |
33-- | 3       | Annabelle | bella-@leetcode.com     |
34-- | 4       | Sally     | sally.come@leetcode.com |
35-- +---------+-----------+-------------------------+
36-- Explanation: 
37-- The mail of user 2 does not have a domain.
38-- The mail of user 5 has the # sign which is not allowed.
39-- The mail of user 6 does not have the leetcode domain.
40-- The mail of user 7 starts with a period.
41-- ###################################################################
42-- Breaking it down piece by piece:
43-- PartMeaning^Start of string[A-Za-z]First character must be a letter (this enforces "must start with a letter")[A-Za-z0-9_.-]*Zero or more allowed characters after that — letters, digits, underscore, period, dash@leetcode\\.comLiteral @leetcode.com — the \\. escapes the period so it means an actual dot, not "any character"$End of string
44
45-- Why escape the period?
46
47-- In regex, . normally means "any character." Since you want a literal dot in leetcode.com, you escape it with \\. (double backslash in MySQL string context, or \. in some other engines like PostgreSQL).
48
49-- Why ^ and $ matter:
50
51-- Without them, the regex would just check if the pattern exists anywhere in the string, not that the entire string matches that structure. This is what blocks user 7 (.shapo@leetcode.com) — the ^[A-Za-z] forces the very first character to be a letter, and a leading period fails that check immediately.
52
53
54
55
56SELECT 
57    user_id, 
58    name, 
59    mail
60FROM 
61    users
62WHERE 
63    mail REGEXP '^[a-zA-Z][a-zA-Z0-9_.-]*@leetcode\\.com$' 
64    AND mail LIKE BINARY '%@leetcode.com';
65
66    ###########Postgre -  WHERE mail ~ '^[A-Za-z][A-Za-z0-9_.-]*@leetcode\.com$'