# Write your MySQL query statement below
with cte1_dictinct_ids as 
(
    select distinct product_id as product_id
    from Products
),
cte2_ranked_ids as 
-- this will rank 1 to all the product ids where date <= target date
-- so for the product where date > target date ONLY the row will be missing
(
    select 
        product_id,
        new_price,
        change_date,
        row_number() over(partition by product_id order by change_date desc) as rankk
    from Products
    where change_date <= '2019-08-16'
)

select 
    cte1.product_id,
    coalesce(cte2.new_price, 10) as price
from cte1_dictinct_ids cte1
left join cte2_ranked_ids cte2
on cte1.product_id = cte2.product_id
and rankk = 1

