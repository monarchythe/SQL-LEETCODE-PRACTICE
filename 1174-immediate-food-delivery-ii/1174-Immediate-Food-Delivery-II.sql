-- Write your PostgreSQL query statement below
--first filet out the non needed rows 

-- the original thought -- ################**************
-- with first_ords as(
--     select *,
--     row_number() over(partition by customer_id order by order_Date) as rk_date
--     from Delivery
-- ),
-- imm_ords as (
--     select count(customer_id) as imm_ct
--     from first_ords 
--     where rk_date = 1
--     and order_date = customer_pref_delivery_date
-- )
-- select round((imm_ct/(select count(customer_id) from first_ords where rk_date=1) :: numeric )*100,2)
-- as immediate_percentage
-- from imm_ords;

-- Now we can remove the sub query with case statments 
-- #############********* CASE ---REPLACES----> SUBQUERY !!!!!!!! *********##############


with first_ords as(
    select *,
    row_number() over(partition by customer_id order by order_Date) as rk_date
    from Delivery
),
imm_ords as (
    select customer_id,
        case when order_date = customer_pref_delivery_date then 1 
        else 0
        end as is_immediate  -- #######****************
    from first_ords 
    where rk_date = 1
)
select round((sum(is_immediate):: Numeric/count(customer_id))*100,2)
as immediate_percentage
from imm_ords;