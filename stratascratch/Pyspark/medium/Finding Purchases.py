"""
Identify returning active users by finding users who made a repeat purchase within 7 days or less of their previous transaction, excluding same-day purchases. Output a list of these user_id.

Table
amazon_transactions

"""
# Import your libraries
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import lead,col,datediff
w=Window.partitionBy("user_id").orderBy("created_at")

df=amazon_transactions.withColumn(
    "next1",lead("created_at").over(w)
    ).filter(col("next1").isNotNull())
df=df.withColumn(
    "diff",datediff(col("next1"),col("created_at"))
    ).filter((col("diff")<=7 ) & (col("diff")>=1))
output=df.select('user_id').distinct()
# To validate your solution, convert your final PySpark df to a pandas df
output.toPandas()