"""
Find the percentage of shipable orders.
Consider an order is shipable if the customer's address is known.

Tables
orders
customers
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import col,when,sum,avg
# Start writing code
cust=customers.select(["id","address"])
orde=orders.select(["id","cust_id"])
df=cust.alias("c").join(
    orde.alias("o"),
    col("c.id")==col("o.cust_id"),
    how="inner"
    ).withColumn(
        "is_shipable",
        when(col("c.address").isNull(),0).otherwise(1)
    ).distinct()
df=df.agg(
    100*avg(col("is_shipable")).alias("percent_shipable")
    )
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()