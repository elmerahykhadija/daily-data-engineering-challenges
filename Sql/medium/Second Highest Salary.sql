/*Find the second highest salary of employees.

Table
employee
*/
select distinct salary 
from(
select salary,dense_rank() over (order by salary desc) as ranking
from employee
) as t
where ranking=2;