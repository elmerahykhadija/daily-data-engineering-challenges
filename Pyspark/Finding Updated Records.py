"""
We have a table with employees and their salaries; however, some of the records are old and contain outdated salary information. Since there is no timestamp, assume salary is non-decreasing over time. You can consider the current salary for an employee is the largest salary value among their records. If multiple records share the same maximum salary, return any one of them. Output their id, first name, last name, department ID, and current salary. Order your list by employee ID in ascending order.

Table
ms_employee_salary
"""
# Import your libraries
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import row_number,col

wind=Window.partitionBy("id").orderBy(ms_employee_salary["salary"].desc())
df=ms_employee_salary.withColumn(
    "number",
    row_number().over(wind)
    )
df=df.filter(df["number"]==1)
# Start writing code
result=df.select("id","first_name","last_name","salary","department_id")

# To validate your solution, convert your final PySpark df to a pandas df
result.toPandas()