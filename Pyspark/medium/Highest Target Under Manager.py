"""
Identify the employee(s) working under manager manager_id=13 who have achieved the highest target. Return each such employee’s first name alongside the target value. The goal is to display the maximum target among all employees under manager_id=13 and show which employee(s) reached that top value.

Table
salesforce_employees
"""
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import rank
# Start writing code

df=salesforce_employees.filter(salesforce_employees["manager_id"]==13)
window=Window.orderBy(df["target"].desc())
df=df.withColumn(
    "n",
    rank().over(window)
    )
df=df.select(["first_name","target"]).filter(df["n"]==1)
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()