"""
Find the hour of the single ride with the highest gasoline cost. Assume only one ride has this maximum, so exactly one hour qualifies.

Table
lyft_rides
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import max,count


maximum=lyft_rides.select(max("gasoline_cost")).collect()[0][0]

output=lyft_rides.select(lyft_rides["hour"]).filter(lyft_rides["gasoline_cost"]==maximum).limit(1)
output.toPandas()