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
- 1148-article-views-i - ***the distinction b/w SELF join and same select query = .***

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

Suggested order (easiest to hardest, so momentum builds):

- [x] 1193 Monthly Transactions I — conditional aggregation
- [x] 1164 Product Price at a Given Date — latest-value-as-of  <- 🔴 **REVISIT** 
- [x] 602 Friend Requests II — UNION ALL + group
- [x] 1045 Customers Who Bought All Products — relational division  <- 🔴 **REVISIT** 
- [x] 626 Exchange Seats — CASE with row arithmetic
- [x] 180 Consecutive Numbers — LAG/LEAD  <- 🔴 **REVISIT** 
- [x] 550 Game Play Analysis IV — self-join date logic. <- 🔴 **REVISIT** 
- [x] 185 Department Top Three Salaries — DENSE_RANK, the hard one

# Imp Notes 

How to handle NULL printing in the final result:

| Expression | Counts |
|---|---|
| COUNT(*) |	all rows |
| COUNT(col) |	rows where col IS NOT NULL |
| COUNT(DISTINCT col)	| distinct non-null values |

LeetCode seeds null-heavy test cases specifically to catch COUNT(col). Default to COUNT(*) unless you deliberately want to exclude nulls.

## LEFT JOIN: `ON` vs `WHERE`

> [!WARNING]
> Putting a condition on the **right** table in `WHERE` silently turns your
> `LEFT JOIN` into an `INNER JOIN`.

### Why

A `LEFT JOIN` keeps every left row. Unmatched left rows get `NULL` in all
right-table columns. `WHERE` runs **after** the join, and `NULL = anything`
is never true — so those rescued rows get filtered right back out.

### The rule

| Condition on | Goes in |
|---|---|
| Left table | `WHERE` (or `ON` — both work) |
| Right table | `ON` only |

### Example — LC 1164

```sql
-- BROKEN: products with no price change get dropped
LEFT JOIN ranked r ON d.product_id = r.product_id
WHERE r.rankk = 1

-- CORRECT: filter restricts matching, doesn't filter output
LEFT JOIN ranked r
    ON d.product_id = r.product_id
   AND r.rankk = 1
```

### Mental model

- `ON` = "which right rows am I allowed to match?"
- `WHERE` = "which result rows do I keep?"

For a `LEFT JOIN`, anything that describes the right side belongs in `ON`.

### The one exception

`WHERE right_col IS NULL` after a `LEFT JOIN` is deliberate — that's the
anti-join pattern for "find left rows with no match."

```sql
SELECT c.id
FROM Customers c
LEFT JOIN Orders o ON c.id = o.customer_id
WHERE o.id IS NULL;   -- customers who never ordered
```

## 550 Game Play Analysis IV — Revision Notes

> [!TIP]
> **Pattern:** "Did X happen right after the FIRST event?" →
> `ROW_NUMBER` to isolate the first row + `LEAD` to see the next one.

### The 6 lessons

**1. "First" means isolate it.**
Counting every consecutive pair overcounts. Use `ROW_NUMBER() = 1` to keep only each player's first row, *then* check its neighbor.

**2. Many window functions, one SELECT.**
Each is just another column.

```sql
LEAD(event_date) OVER w AS next,
ROW_NUMBER()     OVER w AS rn
...
WINDOW w AS (PARTITION BY player_id ORDER BY event_date)
```

**3. Can't filter a window function in the same `WHERE`.**
Window functions run after `WHERE`. Wrap in a CTE, filter outside.

**4. Never subtract dates directly — use `DATEDIFF`.**

| Expression | Mar 31 → Apr 1 |
|---|---|
| `next - event_date` | `70` ❌ |
| `DATEDIFF(next, event_date)` | `1` ✅ |

**5. `SELECT` without `FROM` is valid.**
Evaluates the expression once, returns one row. Scalar subqueries bring their own `FROM`.

```sql
SELECT ROUND((SELECT ...) / (SELECT ...), 2) AS fraction
```

**6. Watch integer division across dialects.**

| Dialect | `1 / 3` |
|---|---|
| MySQL | `0.3333` |
| Postgres / SQL Server | `0` ❌ → use `1.0 * a / b` |

### One-liner to remember

> **Rank to find the first, lead to see the next, DATEDIFF to measure the gap.**
