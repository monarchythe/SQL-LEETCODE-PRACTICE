-- Write your PostgreSQL query statement below

-- so first i frame the inner query and store the results in a CTE,THEN i query the CTE and aplly coditions to get the desired results



with windows_ranking as (
    select id, num,
    LAG(num,1) over(order by id) as prev,
    LEAD(num,1) over(order by id) as nextt
    from logs
    )
select distinct num as ConsecutiveNums 
from windows_ranking 
where prev = num and nextt = num; 