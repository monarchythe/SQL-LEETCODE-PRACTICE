-- Write your PostgreSQL query statement below
select max(salary) as SecondHighestSalary 
from (
    SELECT DISTINCT salary 
    FROM Employee
    ORDER BY salary DESC
    LIMIT 1 OFFSET 1
    );
