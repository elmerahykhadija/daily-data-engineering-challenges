"""
Make a report showing the number of survivors and non-survivors by passenger class. Classes are categorized based on the pclass value as:


•	First class: pclass = 1
•	Second class: pclass = 2
•	Third class: pclass = 3


Output one row per survival status, with a column for the number of passengers in each class.

Table
titanic
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import when,sum
df=titanic.select(["survived","pclass"])
df=df.withColumn(
    "first_class",
    when(df["pclass"]==1,1).otherwise(0)
    )
df=df.withColumn(
    "second_class",
    when(df["pclass"]==2,1).otherwise(0)
    )
df=df.withColumn(
    "third_class",
    when(df["pclass"]==3,1).otherwise(0)
    )
df=df.groupby("survived").agg(
    sum("first_class").alias("first_class"),
    sum("second_class").alias("second_class"),
    sum("third_class").alias("third_class")
    )
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()