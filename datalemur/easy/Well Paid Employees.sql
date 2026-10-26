/*Companies often perform salary analyses to ensure fair compensation practices. One useful analysis is to check if there are any employees earning more than their direct managers.

As a HR Analyst, you're asked to identify all employees who earn more than their direct managers. The result should include the employee's ID and name.

employee Schema:
column_name	type	description
employee_id	integer	The unique ID of the employee.
name	string	The name of the employee.
salary	integer	The salary of the employee.
department_id	integer	The department ID of the employee.
manager_id	integer	The manager ID of the employee.
*/

with t1 as (
SELECT e.employee_id,e.name,e.salary as  emp_salary,m.salary as manager_salary
FROM employee e 
join employee m on e.manager_id=m.employee_id
)
select distinct employee_id,name 
from t1
where emp_salary>manager_salary;