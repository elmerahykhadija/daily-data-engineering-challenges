"""
Find employees who are earning more than their managers. Output the employee's first name along with the corresponding salary.

Table
employee
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import col

e=employee.alias("e")
m=employee.alias("m")

managers= e.join(
    m,col("e.id")==col("m.manager_id"),"inner").select(["m.manager_id","e.salary"]
    ).distinct().withColumnRenamed("salary","manager_salary")


man=managers.alias("man")
output=e.join(man,col("e.manager_id")==col("man.manager_id"),"inner")

output=output.filter(col("salary")>col("manager_salary")).select(["first_name","salary"]).distinct()
# To validate your solution, convert your final PySpark df to a pandas df
output.toPandas()