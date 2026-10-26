"""
The Applied Product team wants to compare how well users receive each model version. Calculate, for each model version, the percentage of rated responses that received a thumbs-up. Responses that were never rated are not counted, and model versions with no rated responses should not appear.


Feedback can be sent more than once for the same response, so count each response only once.


Output the model version and its thumbs-up percentage.

Table
ai_response_feedback
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import col,count,when,avg
from pyspark.sql.window import Window
# Start writing code
df=ai_response_feedback.filter(
    col("feedback").isNotNull()
    ).distinct()
df=df.withColumn(
    "isThumbsUp",
    when(col("feedback")=="thumbs_up",1).otherwise(0)
    )

df=df.groupBy("model_version").agg(
    avg("isThumbsUp").alias("thumbs_up_pct")
    )
df = df.withColumn("thumbs_up_pct", col("thumbs_up_pct") * 100)
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()