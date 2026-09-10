"""
Calculate each user's average session time, where a session is defined as the time difference between a page_load and a page_exit. Assume each user has only one session per day. If there are multiple page_load or page_exit events on the same day, use only the latest page_load and the earliest page_exit. Only consider sessions where the page_load occurs before the page_exit on the same day. Output the user_id and their average session time.

Table
facebook_web_log
"""
from pyspark.sql.functions import to_date, max, min, avg, unix_timestamp

df = facebook_web_log.withColumn(
    "day",
    to_date("timestamp")
)

df_page_exit = (
    df.filter(df["action"] == "page_exit")
    .groupBy("user_id", "day")
    .agg(min("timestamp").alias("page_exit"))
)

df_page_load = (
    df.filter(df["action"] == "page_load")
    .groupBy("user_id", "day")
    .agg(max("timestamp").alias("page_load"))
)

joining = df_page_exit.join(
    df_page_load,
    (df_page_load["user_id"] == df_page_exit["user_id"]) &
    (df_page_load["day"] == df_page_exit["day"]),
    "inner"
).select(
        df_page_exit["user_id"].alias("user_id"),
        df_page_exit["day"].alias("day"),
        df_page_load["page_load"],
        df_page_exit["page_exit"]
    )

joining = joining.filter(
    joining["page_load"] < joining["page_exit"]
)

joining = joining.withColumn(
    "session",
    joining["page_exit"]-joining["page_load"]
)

output = (
    joining
    .groupBy("user_id")
    .agg(avg("session").alias("average"))
)

output.toPandas()