/*
Find employees who earn the same salary.
Output the worker id along with the first name and the salary in descending order.

Table
worker
*/
select worker_id,first_name,salary
from (
select worker_id,first_name,salary,count(*) over(partition by salary) as n
from worker
) as cte
where n > 1
order by salary desc;