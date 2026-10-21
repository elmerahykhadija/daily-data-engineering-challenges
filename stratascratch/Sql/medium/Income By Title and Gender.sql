/*
Find the average total compensation based on employee titles and gender. Total compensation is calculated by adding both the salary and bonus of each employee. However, not every employee receives a bonus so disregard employees without bonuses in your calculation. Employee can receive more than one bonus.
Output the employee title, gender (i.e., sex), along with the average total compensation.

Tables
sf_employee
sf_bonus
*/
with t1 as (
select distinct e.id,e.salary,sum(b.bonus) over(partition by e.id) as total_bonus,e.sex,e.employee_title
from sf_employee e
join sf_bonus b on b.worker_ref_id=e.id
)
select employee_title,sex,avg(salary+total_bonus) as average

from t1
group by employee_title,sex
order by employee_title;