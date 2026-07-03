-- Write your PostgreSQL query statement below

-- So here I can see that i only need to group the department and not the Employee, but in the results , eployee name must be mentioned, so we can either do it by groupby subquery or use windows function + CTE 

-- since i am a working professional i prefer CTE over subquery 

with ranked_salaries_by_dept as 
(
    select 
        d.name as Department, 
        e.name as Employee, 
        dense_rank() over(partition by d.name order by e.salary desc) as ranks,
        e.salary as Salary
    from Employee e
    join Department d
    on e.departmentId = d.id
)
select Department, Employee, Salary
from ranked_salaries_by_dept
where ranks = 1;

