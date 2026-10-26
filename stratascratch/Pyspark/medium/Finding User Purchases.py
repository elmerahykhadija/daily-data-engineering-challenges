"""
Identify returning active users by finding users who made a second purchase within 1 to 7 days after their first purchase. Ignore same-day purchases. Output a list of these user_ids.

Table
amazon_transactions
"""
# Import your libraries
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import max,min,col,lead,row_number,datediff
window=Window.partitionBy("user_id").orderBy("created_at")

df=amazon_transactions.withColumn(
    "second_purchase",lead("created_at").over(window)
    )
    
df=df.withColumn(
    "n",row_number().over(window)).filter(
    (col("n")==1) & (col("second_purchase").isNotNull())
    ).select(
        ["user_id","created_at","second_purchase"]
    )
df=df.withColumn(
    "days_between",
    datediff(col("second_purchase"),col("created_at"))
    ).filter(
        (col("days_between")>=1) & (col("days_between")<=7)
    ).select("user_id")

# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()