/*
Identify the employee(s) working under manager manager_id=13 who have achieved the highest target. Return each such employee’s first name alongside the target value. The goal is to display the maximum target among all employees under manager_id=13 and show which employee(s) reached that top value.

Table
salesforce_employees
*/
select first_name,target
from (
    select * ,rank() over (order by target desc) as n
    from salesforce_employees 
    where manager_id=13
) as t
where n=1;