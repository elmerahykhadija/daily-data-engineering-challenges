"""
ind the total cost of each customer's orders. Output customer's id, first name, and the total order cost. Order records by customer's first name alphabetically.

Tables
customers
orders
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import sum
df=customers.join(
    orders,
    customers["id"]==orders["cust_id"],
    how="inner"
    )
output=df.groupBy("cust_id","first_name").agg(
    sum("total_order_cost").alias("total")
    )
output=output.select("cust_id","first_name","total")
output=output.orderBy(output["first_name"])
# To validate your solution, convert your final PySpark df to a pandas df
output.toPandas()