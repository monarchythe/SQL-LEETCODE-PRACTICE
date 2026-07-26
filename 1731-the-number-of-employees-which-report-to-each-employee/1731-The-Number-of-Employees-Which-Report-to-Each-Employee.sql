# Write your MySQL query statement below
with calculations as
    (
        select reports_to as manager, count(employee_id) as reports_count, 
        round(avg(age)) as average_age
        from Employees
        group by reports_to 
    )

select c.manager as employee_id, e.name, c.reports_count, c.average_age
from calculations c 
inner join Employees e
on c.manager = e.employee_id
order by c.manager 
