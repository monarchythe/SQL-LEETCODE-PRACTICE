# SQL-LEETCODE-PRACTICE

After completing SQL STRIVERS SHEET of 110 Questions, I am diving into LEETCODE. Excited to solve the New and challenging questions

***uptill now i have practiced enough questions to clear 2 data engineering SQL interview rounds***

## Question Difficulty Breakdown

### Easy (19)

- 511 Game Play Analysis I
- 577 Employee Bonus
- 584 Find Customer Referee
- 586 Customer Placing the Largest Number of Orders
- 607 Sales Person
- 619 Biggest Single Number
- 627 Swap Salary
- 1084 Sales Analysis III
- 1141 User Activity for the Past 30 Days I
- 1148 Article Views I
- 1179 Reformat Department Table
- 1211 Queries Quality and Percentage
- 1251 Average Selling Price
- 1280 Students and Examinations
- 1517 Find Users With Valid E-Mails
- 1581 Customer Who Visited but Did Not Make Any Transactions
- 1661 Average Time of Process per Machine
- 1731 The Number of Employees Which Report to Each Employee
- 1789 Primary Department for Each Employee

### Medium (18)

- 176 Second Highest Salary
- 177 Nth Highest Salary
- 180 Consecutive Numbers
- 184 Department Highest Salary
- 550 Game Play Analysis IV
- 570 Managers with at Least 5 Direct Reports
- 585 Investments in 2016
- 602 Friend Requests II: Who Has the Most Friends
- 608 Tree Node
- 626 Exchange Seats
- 1045 Customers Who Bought All Products
- 1070 Product Sales Analysis III
- 1158 Market Analysis I
- 1164 Product Price at a Given Date
- 1174 Immediate Food Delivery II
- 1193 Monthly Transactions I
- 1204 Last Person to Fit in the Bus
- 1907 Count Salary Categories

### Hard (1)

- 185 Department Top Three Salaries

### High-Value Revision Set

Eight questions covering distinct patterns rather than variations:

| Problem | Pattern |
|---|---|
| 185 Department Top Three Salaries | `DENSE_RANK` window, top-N per group |
| 180 Consecutive Numbers | `LAG`/`LEAD` or self-join for consecutive rows |
| 550 Game Play Analysis IV | Self-join on date arithmetic, retention logic |
| 1045 Customers Who Bought All Products | Relational division ("has ALL of X") |
| 626 Exchange Seats | `CASE` with row arithmetic, conditional swap |
| 1164 Product Price at a Given Date | Latest-value-as-of-date |
| 1193 Monthly Transactions I | Conditional aggregation with `SUM(CASE WHEN …)` |
| 602 Friend Requests II | `UNION ALL` then group, bidirectional relationships |
