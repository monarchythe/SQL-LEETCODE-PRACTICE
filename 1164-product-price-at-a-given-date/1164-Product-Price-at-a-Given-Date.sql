-- Write your PostgreSQL query statement below
-- initial price = 10 
-- so i need to filter out all the prices with changes date < = 2019-08-16 
-- may be we can use case statement 

with ranked_id as (select *,
row_number() over(partition by product_id order by change_date desc) as rk
from Products
where change_date <= '2019-08-16'),
distinct_ids as
(select distinct product_id from Products)

select d.product_id, coalesce(r.new_price,10) as price
from distinct_ids d
left join ranked_id r 
on d.product_id = r.product_id
and rk = 1 ;----############## *********** V.IMP. ##########********* dont use WHERE rk = 1, it will kill the left join AFFECT FOR NULL -----****************