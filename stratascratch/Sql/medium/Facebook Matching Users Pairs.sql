/*
Meta's HR analytics team wants to find employees who could be paired for a cross-level mentorship program based on shared background. Find all pairs of employees who are based in the same location, are the same gender, are different ages, and are at different seniority levels (one senior, one non-senior).


For every valid match between a senior and a non-senior employee, output both orderings of the pair - once with the senior employee listed first, and once with the non-senior employee listed first.


Output the ID of the first employee and the ID of the second employee in each pair.

Table
facebook_employees
*/
select e1.id as emp_1,e2.id as emp_2
from facebook_employees e1
join facebook_employees e2 
on  (e1.location=e2.location) and (e1.gender=e2.gender) 
and (e1.age!=e2.age) and (e1.is_senior!=e2.is_senior);