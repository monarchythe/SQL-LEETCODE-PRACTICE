-- Write your PostgreSQL query statement below

-- ###### ****** Customer bought ALL products" means the count of distinct products they bought equals the total count of products in Product table ****** ######

select customer_id 
from Customer 
group by customer_id
having count(distinct product_key) = (select count(*) from Product)


--  This is called relational division in SQL theory — finding entities that satisfy all conditions in another set. So we will see this pattern in interviews disguised in different ways:

-- "Students who took all courses"
-- "Employees who completed all training modules"
-- "Warehouses that stock all products   