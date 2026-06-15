1-- Write your PostgreSQL query statement below
2select player_id, event_date as first_login
3 from 
4(
5    select player_id, event_date,
6    row_number() over(partition by player_id order by event_Date) as rankk
7    from Activity
8)
9where rankk =1 