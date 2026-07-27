# Write your MySQL query statement below
# partion by Department, order by Salary desc

with rank_cte as(
    select departmentID, name as Employee, salary,
    dense_rank() over(partition by departmentID order by salary desc) as rnk
from Employee 
)
select d.name as Department,
    rkcte.Employee,
    rkcte.salary as Salary
from Department d 
inner join rank_cte rkcte
on d.id = rkcte.departmentID
where rnk <=3;

