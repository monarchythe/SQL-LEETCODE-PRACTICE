# Write your MySQL query statement below
####################### RUNNING SUM #######################

 -- -- ORDER BY WEIGHT KAROGE TO KAISE HOGA -- -- -- -- -- -- -- -- -- -- -- Jike order me sum chahiye vahi loge na -- -- -- -- 
with running_sum as 
 (
    select *, 
 sum(Weight) over(order by Turn) as Total_Weight
from Queue
)
select person_name from running_sum
 -- where turn = (select max(turn) from running_sum where Total_Weight <=1000)
where Total_Weight<=1000
order by turn desc limit 1