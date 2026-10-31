"""
Identify the most engaged guests by ranking them according to their overall messaging activity. The most active guest, meaning the one who has exchanged the most messages with hosts, should have the highest rank. If two or more guests have the same number of messages, they should have the same rank. Importantly, the ranking shouldn't skip any numbers, even if many guests share the same rank. Present your results in a clear format, showing the rank, guest identifier, and total number of messages for each guest, ordered from the most to least active.

Table
airbnb_contacts
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import sum, col,dense_rank
from pyspark.sql.window import Window
df = airbnb_contacts.groupBy("id_guest").agg(
    sum(col("n_messages")).alias("total_num")
)
w=Window.orderBy(col("total_num").desc())
df=df.withColumn(
    "ranking",dense_rank().over(w)
    )
df.toPandas()