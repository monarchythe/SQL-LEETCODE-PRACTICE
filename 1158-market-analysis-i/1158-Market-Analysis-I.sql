-- Write your PostgreSQL query statement below
-- With temp as (select 
-- u.user_id, 
-- o.buyer_id,
-- o.order_date,
-- u.join_date 

-- from Users u
-- left join Orders o
-- on u.user_id = o.buyer_id 
-- AND EXTRACT(YEAR FROM o.order_date) = 2019)

-- select user_id as buyer_id, join_date , count(buyer_id) as orders_in_2019
-- from temp 
-- group by user_id, join_date;

-- ######*#*#**#*##**#*#*#*#* the above solution is fine but 
 -- you need tp tidy up 

 SELECT
    u.user_id AS buyer_id,
    u.join_date,
    COUNT(o.order_id) AS orders_in_2019
FROM Users u
LEFT JOIN Orders o
    ON u.user_id = o.buyer_id
   AND o.order_date >= DATE '2019-01-01'
   AND o.order_date < DATE '2020-01-01'
GROUP BY u.user_id, u.join_date;
