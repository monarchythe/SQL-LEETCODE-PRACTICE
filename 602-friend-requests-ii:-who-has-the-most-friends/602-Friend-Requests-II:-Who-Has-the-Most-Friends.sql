-- Write your PostgreSQL query statement below

-- ***********************************I have solved his question and I aksed - What SQL operation stacks two result sets into one column?- UNION ***********************************
with combined_tb as(
    select 
        requester_id as id,
        count(requester_id) as cnt_ids
    from RequestAccepted
    group by requester_id

    union all 

    select 
        accepter_id as id,
        count(accepter_id) as cnt_ids
    from RequestAccepted 
    group by accepter_id 
    )

select id,
sum(cnt_ids) as num
from combined_tb
group by id
order by num desc
limit 1 

-- Follow up: In the real world, multiple people could have the same most number of friends. Could you find all these people in this case?

-- WITH ... -- the existing CTE 
-- final AS ( 
--     SELECT id, SUM(cnt_ids) AS num
--     FROM combined_tb
--     GROUP BY id
-- )
-- SELECT id, num 
-- FROM final
-- WHERE num = (SELECT MAX(num) FROM final);-- to get them all 