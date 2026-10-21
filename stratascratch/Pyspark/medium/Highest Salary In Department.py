"""
A business wants to identify its highest-paid employee in each department for compensation benchmarking and review. Find the employee with the highest salary in each department.


Output the department name, the employee's first name and their salary. If multiple employees share the highest salary in a department, return all of them.

Table
employee
"""
# Import your libraries
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import rank

window=Window.partitionBy(employee["department"]).orderBy(employee["salary"].desc())
df=employee.withColumn(
    "n",
    rank().over(window)
    )
df=df.filter(df["n"]==1).select(["department","first_name","salary"])

# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()