# Import your libraries
import pyspark
df = online_store_customers.join(
    online_store_orders,
    online_store_customers["customer_id"] == online_store_orders["customer_id"],
    "inner"
)

df = df.filter(online_store_orders["amount"] > 100)

df = df.select(
    online_store_customers["customer_id"],
    online_store_customers["customer_name"]
).distinct()

df.toPandas()