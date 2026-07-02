      with nthsalary as (
        select 
        id,
        salary, 
        Dense_Rank() over(order by salary desc) as rankss
        from Employee 
      )
      select max(salary) as SecondHighestSalary from nthsalary where rankss = 2 limit 1