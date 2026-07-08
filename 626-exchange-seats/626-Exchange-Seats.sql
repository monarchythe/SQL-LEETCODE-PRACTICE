-- Write your PostgreSQL query statement below
-- S
-- Select s1.id, CASE 
--                 when s1.id%2=1 then COALESCE( (select student from Seat s2 where s2.id = s1.id+1), s1.student)
--                 when s1.id%2=0 then (select student from Seat s2 where s2.id = s1.id-1)
--                 END as student
-- from Seat s1
 

 --- ################# ******************** sO INSTED OF SWAPPING AROUND the names we can swap the ids and thats it ******************** #################--

 select 
    case
        when id % 2 = 1 and id = (select max(id) from Seat) then id
        when id % 2 = 1 then id+1
        when id % 2 = 0 then id-1
    end as id,
    student
from Seat
order by id 
