# Write your MySQL query statement below

-- iN THIS Question I got stuck at CASE + GROUP BY, BUT MY CTE -- WINDOWS GIVE ME THE LEVERAGE TO JUST USE WHERE CLAUSE 

-- so group by + having ============> CTE+WINDOWS + WHERE 


with cte_1 as (
    select 
        *,
        count(department_id) over(partition by employee_id) as no_of_dpt
from Employee
)
select 
    employee_id,
    department_id
from cte_1
where primary_flag = 'Y' or no_of_dpt = 1


-- Case 
--         when primary_flag = 'Y' then department_id
--         else 
--         when primary_flag = 'N' and no_of_dpt = 1 then department_id
--         END as



