1-- Write your PostgreSQL query statement below
2select customer_number 
3from Orders 
4group by customer_number 
5order by count(order_number) desc 
6limit 1