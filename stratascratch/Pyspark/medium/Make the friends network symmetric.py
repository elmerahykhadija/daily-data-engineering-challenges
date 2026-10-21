# Import your libraries
import pyspark
from pyspark.sql.functions import col
df1=google_friends_network.select(
    col("user_id").alias("u1"),
    col("friend_id").alias("u2")
    )
# Start writing code
df2=google_friends_network.select(
    col("friend_id").alias("u1"),
    col("user_id").alias("u2")
    )
df=df1.unionByName(df2).distinct()

# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()