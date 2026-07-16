-- Write your PostgreSQL query statement below
-- with ids_withfirst_yr as
-- (
--     select product_id, min(year) as first_year
--     from Sales
--     group by product_id
-- )
-- select s.product_id, iy.first_year, s.quantity, s.price
-- from Sales s 
-- join ids_withfirst_yr iy
-- on iy.product_id = s.product_id 
-- and iy.first_year = s.year

-- Same problem with windows function 
-- WITH first_sale AS (
--     SELECT 
--         product_id, 
--         year,
--         quantity,
--         price,
--         ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY year) AS rn
--     FROM Sales
-- )
-- SELECT product_id, year AS first_year, quantity, price
-- FROM first_sale 
-- WHERE rn = 1;


-- postgre specific 
-- What DISTINCT ON does:
-- sql
-- SELECT DISTINCT ON (product_id) product_id, year
-- FROM Sales
-- ORDER BY product_id, year
-- It keeps only the first row per product_id based on the ORDER BY. Since you order by year ascending, the first row = earliest year.
-- It's essentially doing ROW_NUMBER() OVER (PARTITION BY product_id ORDER BY year) = 1 but in one clean line.

with first_sale as (
    select
        distinct on(product_id)
        product_id, year
    from Sales
    order by product_id, year
)

select
    first_sale.product_id, 
    first_sale.year as first_year, 
    quantity, 
    price 
from 
    first_sale 
    join 
    Sales on first_sale.product_id = Sales.product_id 
    and
    first_sale.year = Sales.year
;