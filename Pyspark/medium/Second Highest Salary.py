"""
Find the second highest salary of employees.
"""
# Import your libraries
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import dense_rank

# Start writing code
window=Window.orderBy(employee["salary"].desc())
df=employee.withColumn(
    "ranking",
    dense_rank().over(window)
    )
df=df.filter(df["ranking"]==2).select("salary")
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()