"""
Compare each employee's salary with the average salary of the corresponding department.
Output the department, first name, and salary of employees along with the average salary of that department.

Table
employee
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import avg
# Start writing code
df1=employee.groupBy("department").agg(
    avg("salary").alias("avg_salary")
    )
df=df1.join(
    employee,
    on="department",how="inner"
    )   
df=df.select("department","first_name","salary","avg_salary").orderBy("department")

# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()