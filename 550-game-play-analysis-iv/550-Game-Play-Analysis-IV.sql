-- Write your PostgreSQL query statement below




WITH stg AS (
    SELECT
        *,
        -- For each row, check if this row's date is exactly 1 day after
        -- that player's first ever login date.
        -- MIN() OVER() gives first login date across ALL rows for this player
        -- without collapsing rows (unlike GROUP BY)
        -- Result is TRUE/FALSE boolean stored as is_day_after
        event_date = MIN(event_date) OVER (PARTITION BY player_id) + INTERVAL '1 day' AS is_day_after
    FROM activity
)

SELECT
    ROUND(
        -- Count players who logged in the day after their first login
        -- CASE WHEN is_day_after (TRUE) THEN return player_id ELSE NULL
        -- COUNT ignores NULLs so only TRUE rows get counted
        -- DISTINCT handles players who may have multiple rows on that day
        COUNT(DISTINCT CASE WHEN is_day_after THEN player_id END)::numeric
        /
        -- Total number of unique players
        COUNT(DISTINCT player_id)
    , 2) AS fraction
FROM stg


-- ::numeric tells PostgreSQL:

-- "treat this as a decimal number, not an integer"

-- MySQL automatically converts to decimal in most cases:
-- 1 / 3  →  0.3333  -- MySQL does this correctly by default!




--############**********************************************************************##############

-- so for now i am thinking to use the LEAD windows function to get the next date column, and then filter out with the datediff case statements

-- 540 ms Beats 35.36%

-- with next_login as 
-- (
--     select 
--         player_id,
--         event_date,
--         LEAD(event_date,1) OVER(PARTITION BY player_id ORDER BY event_date) as next_login_date,
--         ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY event_date) AS rn    
--     from Activity
-- ),
-- get_cnt as(
--     select player_id,
--         CASE WHEN next_login_date - event_Date = 1 then 1
--         ELSE 0
--         End as counts
--     from next_login
--     where rn = 1 -- ######## ***** Only check the first login per player
-- )
-- select round(sum(counts)::numeric/count(distinct player_id),2) as fraction
-- from get_cnt


--********************************************************************************************************************--

-- Date difference cheat sheet:

-- PostgreSQL:
-- sql-- Days (just subtract directly)
-- '2024-03-05'::date - '2024-03-01'::date  -- returns 4

-- -- Days (using function)
-- DATE_PART('day', '2024-03-05'::date - '2024-03-01'::date)  -- returns 4

-- -- Months
-- DATE_PART('month', AGE('2024-06-01'::date, '2024-03-01'::date))  -- returns 3

-- -- Years
-- DATE_PART('year', AGE('2026-03-01'::date, '2024-03-01'::date))  -- returns 2

-- MySQL:
-- sql-- Days
-- DATEDIFF('2024-03-05', '2024-03-01')  -- returns 4

-- -- Months
-- TIMESTAMPDIFF(MONTH, '2024-03-01', '2024-06-01')  -- returns 3

-- -- Years
-- TIMESTAMPDIFF(YEAR, '2024-03-01', '2026-03-01')  -- returns 2

-- Quick comparison:
-- GoalPostgreSQLMySQLDay differencedate1 - date2DATEDIFF(d1, d2)Month differenceDATE_PART('month', AGE(d1, d2))TIMESTAMPDIFF(MONTH, d1, d2)Year differenceDATE_PART('year', AGE(d1, d2))TIMESTAMPDIFF(YEAR, d1, d2)

-- Key things to remember:

-- PostgreSQL date - date = integer days directly — no function needed
-- MySQL uses DATEDIFF for days, TIMESTAMPDIFF for everything else
-- PostgreSQL's AGE() returns an interval — wrap with DATE_PART to extract a number
-- TIMESTAMPDIFF in MySQL is (unit, earlier_date, later_date) — order matters! 