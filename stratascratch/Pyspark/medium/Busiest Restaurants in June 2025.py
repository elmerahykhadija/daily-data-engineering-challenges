"""
The Merchant team at a food delivery marketplace wants to spotlight its busiest restaurants in the June 2025 partner newsletter. Find the top 5 restaurants by number of delivered orders placed in June 2025. Count only orders that were delivered, and assign each order to the month in which it was placed. If restaurants tie at the cutoff, include all tied restaurants, so the result can contain more than 5 rows.


Output the restaurant ID, restaurant name, and number of delivered orders.

Tables
fooddelivery_orders
fooddelivery_restaurants
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import month,year,col,countDistinct,dense_rank
from pyspark.sql.window import Window

w=Window.orderBy(col("n").desc())
# Start writing code
df=fooddelivery_orders.filter(
    (month("placed_at")==6) & (year("placed_at")==2025) & (col("status")=='delivered')
    ).alias("o").join(
        fooddelivery_restaurants.alias("r"),col("o.restaurant_id")==col("r.restaurant_id"),how="inner"
    ).select(["o.restaurant_id","r.name","o.order_id"])
df=df.groupBy(["restaurant_id","name"]).agg(
    countDistinct("order_id").alias("n")
    ).withColumn(
    "rat",dense_rank().over(w)
    )
df=df.select(["restaurant_id","name","n"]).filter(
    col("rat")<=5
    )
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()