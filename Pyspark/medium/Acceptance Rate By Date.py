"""
A social platform's growth team wants to understand how often friend requests result in accepted connections. For each date when friend requests were sent, calculate the proportion of those requests that were accepted.


A request is considered accepted when a matching acceptance record exists for the same sender and receiver. If no matching acceptance record exists, treat the request as not accepted. The acceptance may occur on any date after the request was sent.


Exclude dates on which none of the requests sent were accepted.


Output the request date and the acceptance rate, sorted by date in ascending order.

Table
fb_friend_requests
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import when,max,avg
df=fb_friend_requests.select(
    "user_id_sender","user_id_receiver",
    when(fb_friend_requests["action"]=="sent",fb_friend_requests["date"]).alias("date_sending"),
    when(fb_friend_requests["action"]=="accepted",fb_friend_requests["date"]).alias("date_accepting")
    )
df=df.groupby(["user_id_sender","user_id_receiver"]).agg(
    max(df["date_sending"]).alias("date_sending"),
    max(df["date_accepting"]).alias("date_accepting")
    )
df=df.withColumn(
        "n",
        when(df["date_accepting"].isNotNull() ,1).otherwise(0)
        )
df=df.groupby("date_sending").agg(
    avg("n").alias("average")
    )
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()