1--This is YOUR SOLUTION
2select distinct author_id as id
3from Views
4where author_id in(
5    select author_id 
6    from Views 
7    where author_id=viewer_id
8)
9order by id
10-- this is the simplest solution with DISTINCT 
11    -- select DISTINCT author_id AS id
12    -- from Views 
13    -- where author_id=viewer_id
14    -- order by id