/*
A business wants to identify its highest-paid employee in each department for compensation benchmarking and review. Find the employee with the highest salary in each department.


Output the department name, the employee's first name and their salary. If multiple employees share the highest salary in a department, return all of them.

Table
employee
*/
select department,first_name,salary
from 
(select department,first_name,salary,rank() over (partition by department order by salary desc) as ranking
from employee
) as t
where ranking=1;