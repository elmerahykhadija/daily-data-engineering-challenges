"""
The Data Science and Analytics team wants to see how many users progress through each stage of an AI writing feature's adoption funnel: impression (saw the feature), first_use (tried it at least once), and repeat_use (used it more than once). Count the unique users at each stage.


Because of a tracking gap, some users have a repeat_use event but no first_use event; they must still count toward first_use.


Output the stage and its number of unique users.

Table
ai_funnel_events
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import count,when,col,countDistinct,sum,lit
# Start writing code

df=ai_funnel_events.withColumns({
    "first_use":when(col("event_type")=='first_use',1).otherwise(0),
    "repeat_use":when(col("event_type")=='repeat_use',1).otherwise(0),
    "impression":when(col("event_type")=='impression',1).otherwise(0)
    })
df1 = df.select("user_id", "event_type")
df2=df.filter((df["first_use"]==0) & (df["repeat_use"]==1))
df2=df2.withColumn(
    "event_type",lit("first_use")
        ).select(["user_id","event_type"])
out=df1.unionByName(df2)
out=out.groupBy("event_type").agg(
    countDistinct("user_id").alias("unique_users")
    )    
# To validate your solution, convert your final PySpark df to a pandas df
out.toPandas()