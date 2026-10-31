"""
Write a query that returns how many different apartment-type units (counted by distinct unit_id) are owned by people under 30, grouped by their nationality. Sort the results by the number of apartments in descending order.

Tables
airbnb_hosts
airbnb_units
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import col,countDistinct

under30=airbnb_hosts.filter(
    col("age")<30).select(["host_id","nationality"]
    )
# Start writing code
airbnb_units=airbnb_units.filter(
    col("unit_type")=='Apartment'
    )
df=under30.alias("u").join(
    
    airbnb_units.alias("a"),
    col("u.host_id")==col("a.host_id"),
    "inner"
    
    ).select(
        ["u.host_id","a.unit_id","a.unit_type","u.nationality"]
        )
df=df.groupBy("nationality").agg(
    countDistinct("unit_id").alias("n")
    )

# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()