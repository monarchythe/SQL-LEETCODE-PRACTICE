CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
      with nthsalary as (
        select 
        id,
        salary, 
        Dense_Rank() over(order by salary desc) as rankss
        from Employee 
      )
      select max(salary) as getNthHighestSalary from nthsalary where rankss = N limit 1

  );
END

-- i have to use this - max(salary) , as the leetcode wants null for no rows 