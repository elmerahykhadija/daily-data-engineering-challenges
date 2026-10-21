"""
Find all possible varieties which occur in either of the winemag datasets.
Output unique variety values only.
Sort records based on the variety in ascending order.

Tables
winemag_p1
winemag_p2
"""
# Import your libraries
import pyspark
df1=winemag_p1.select("variety").distinct()
df2=winemag_p2.select("variety").distinct()
output=df1.unionByName(df2)
output=output.orderBy(output["variety"])


output.toPandas()