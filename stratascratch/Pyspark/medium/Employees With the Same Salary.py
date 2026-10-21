"""
Find employees who earn the same salary.
Output the worker id along with the first name and the salary in descending order.

Table
worker
"""
# Import your libraries
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import count
window=Window.partitionBy(worker["salary"])
df=worker.withColumn(
    "n",
    count("*").over(window)
    )
# Start writing code
df=df.select(["worker_id","first_name","salary"]).filter(df["n"]>1).orderBy(df["salary"].desc())

# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()