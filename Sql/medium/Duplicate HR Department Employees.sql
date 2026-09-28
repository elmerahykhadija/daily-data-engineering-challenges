/*
Generate a list of employees who work in the HR department, including only their first names and department in the output. Each employee should appear twice in the list, meaning their first name and department should be duplicated in the output.

Table
worker
*/
(select first_name,department
from worker
where department="HR")
UNION ALL
(select first_name,department
from worker
where department="HR");