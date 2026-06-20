1-- Write your PostgreSQL query statement below
2select e.name,b.bonus
3from Employee e
4left join Bonus b
5on b.empId = e.empId
6where b.bonus is null 
7or b.bonus<1000
8