-- Write your PostgreSQL query statement below

-- ###########*************** the alterntive of NOT IN- is NOT EXISTS ***************########### --
select 
    id,
    Case
        when t1.p_id is Null then 'Root'
        when not Exists (-- no rows condition becomes true here
            select 1 from Tree t2 -- this will return No row! if leaf
            where t1.id = t2.p_id
        ) then 'Leaf'
        else 'Inner'
        END as type
from Tree t1

-- ###########*************** OR we can use this condition to elemeninate NULL first ***************########### --
    -- CASE 
    --     WHEN p_id IS NOT NULL AND id NOT IN (
    --         SELECT p_id 
    --         FROM Tree
    --         WHERE p_id IS NOT NULL
    --     ) THEN 'Leaf'
    --     WHEN p_id IS NULL THEN 'Root'
    --     ELSE 'Inner'