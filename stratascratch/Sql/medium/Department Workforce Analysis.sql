with t0 as(
select * from techcorp_workforce
WHERE joining_date >= '2020-01-01'
),
t1 as(
select department,salary,
    count(*) over(partition by department) as number_emp
from t0
),
t2 as (
select department,number_emp,
    sum(salary) over (partition by department) as total,
    avg(salary) over (partition by department) as average
from t1
where number_emp >= 5
)
select distinct * 
from t2;