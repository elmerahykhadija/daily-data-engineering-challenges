"""
We have a table with employees and their salaries; however, some of the records are old and contain outdated salary information. Since there is no timestamp, assume salary is non-decreasing over time. You can consider the current salary for an employee is the largest salary value among their records. If multiple records share the same maximum salary, return any one of them. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

DataFrame
ms_employee_salary
"""
# Import your libraries
import pandas as pd
df=ms_employee_salary.groupby("id").agg(
    salary=("salary","max")
    ).reset_index()
# Start writing code

output=df.merge(ms_employee_salary,on=["id","salary"],how="inner",suffixes=("","_x"))[["id","first_name","last_name","salary","department_id"]]
output=output.drop_duplicates()
output