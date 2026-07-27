# Write your MySQL query statement below
-- select *,
--     CASE 
--         When income < 20000 then 1 else 0
--         end as low_Sal_count,
--     CASE
--         when income >=20000 and income<=50000 then 1 else 0 
--         end as avg_sal_count,
--     CASE 
--         When income > 50000 then 1 else 0
--         end as high_Sal_count
-- from Accounts

-- SO AFTER THE ABOVE QUERY YOU NEED TO PIVOT, BUT IT WILL BE COMLICATED.
-- ############# ************************ 
 -- 
  -- WHEN you see you need an extrra column with fixed values, you can go to the UNION Part 

-- select 'Low Salary' as category,
--     SUM(CASE 
--         When income < 20000 then 1 else 0
--         end) as accounts_count 
-- from Accounts
-- union all 
-- select 'Average Salary' as category,
--     SUM(CASE
--         when income >=20000 and income<=50000 then 1 else 0 
--         end) as accounts_count 
-- from Accounts
-- union all 
-- select 'High Salary' as category,
--     SUM(CASE 
--         When income > 50000 then 1 else 0
--         end) as accounts_count 
-- from Accounts

-- ############*******************    or you can combine both ***************###################

WITH salary_counts AS (
    SELECT
        SUM(income < 20000 ) AS low_count,
        SUM(income BETWEEN 20000 AND 50000 ) AS average_count,
        SUM(income > 50000 ) AS high_count
    FROM Accounts
)

SELECT 'Low Salary' AS category, low_count AS accounts_count
FROM salary_counts

UNION ALL

SELECT 'Average Salary', average_count
FROM salary_counts

UNION ALL

SELECT 'High Salary', high_count
FROM salary_counts;
