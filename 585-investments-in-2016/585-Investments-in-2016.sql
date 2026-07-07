-- Write your PostgreSQL query statement below
-- so i am thinking of grouping by lat,long , so we will have unique pairs of location columns , now the trick is to check and sum all the values of the tiv_2016 where tiv_2015 is same, so then now i am thinking to first group by tiv_2015 and get all the same matching rows together , then filter by having(count>1) , now we have all the similar rows togather, by fiv_2015 , now again gropu by lat,long, so to get the unique location, but then from the sample table i will get 3 unique rows

-- so lets go for one by one conditions filtering
--####### HANDLIG EACH CONDITIONS separately #######--
-- select * 
-- from Insurance
-- where tiv_2015 in
--     (select tiv_2015
--     from Insurance 
--     group by tiv_2015
--     having count(tiv_2015)>1)

-- select * 
-- from Insurance 
-- where (lat,lon) in --tuple comparison in PostgreSQL,(lat, lon) wrapped in parentheses creates a tuple — PostgreSQL compares both columns together as a pair
--     (
--         select lat,lon
--         from Insurance
--         group by lat,lon 
--         having count(pid)=1
--     )

-- *****now again i was trying to overcomplicate it by trying to use CTE or union, ... but i just need to put both the queries togather combined with WHERE , AND  thats it 

-- ************ ####### perfect solution, ####### ************ -- |||||||||||||||||||||||||||||||
-- select round(sum(tiv_2016)::numeric,2) as tiv_2016
-- from Insurance
-- where tiv_2015 in
--     (select tiv_2015
--     from Insurance 
--     group by tiv_2015
--     having count(tiv_2015)>1)
-- and 
--      (lat,lon) in 
--     (
--         select lat,lon
--         from Insurance
--         group by lat,lon 
--         having count(pid)=1
--     )

    
--  ------------------------------------------------------------But lets try with the WNDOWS FUNCTION APPROACH ------------------------------------------------------------

WITH uniq_coords AS (
  SELECT *, 
    COUNT(*) OVER (PARTITION BY lat, lon) AS attempts,
    COUNT(*) OVER (PARTITION BY tiv_2015) AS tivs
  FROM Insurance
)

SELECT ROUND(SUM(tiv_2016)::numeric, 2) AS tiv_2016
FROM uniq_coords
WHERE attempts = 1 AND tivs > 1;