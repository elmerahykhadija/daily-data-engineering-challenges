/*
Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.

Table
employee
*/
with managers as (
select distinct m.manager_id ,e.salary
from employee m
join employee e on e.id=m.manager_id
),
employees as(
select e.first_name,e.salary,m.salary as manager_salary
from employee e
join managers m on e.manager_id=m.manager_id
)
select first_name ,salary
from employees
where salary>manager_salary;