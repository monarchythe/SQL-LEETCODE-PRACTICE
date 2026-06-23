1-- you can't chain two separate set...where clauses like that in a single UPDATE. SQL needs one SET clause that decides the value per-row
2
3
4-- We will use case inside SET 
5
6Update salary 
7Set sex = CASE sex 
8            When 'm' then 'f'
9            when 'f' then 'm'
10            end;