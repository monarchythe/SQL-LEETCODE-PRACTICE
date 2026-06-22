1-- The key insight you just unlocked:
2
3-- Aggregate functions (SUM, COUNT, AVG, MAX, MIN) always return exactly one row — even on an empty input. COUNT returns 0, but SUM/AVG/MAX/MIN return NULL.
4
5select sum(num) as num from 
6(   
7    select num 
8    from MyNumbers 
9    group by num
10    having count(*)=1
11    order by num desc
12    limit 1
13)
14
15--# Agregate function alwas return atleat one row with NULL - try :
16--SELECT SUM(num) FROM MyNumbers WHERE 1=0 