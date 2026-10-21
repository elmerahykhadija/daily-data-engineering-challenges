"""
Find all Lyft rides which happened on rainy days before noon.

Table
lyft_rides
"""
# Import your libraries
import pyspark
onlyrainy=lyft_rides.filter((lyft_rides["weather"]=="rainy") & (lyft_rides["hour"] < 12))

# To validate your solution, convert your final PySpark df to a pandas df
onlyrainy.toPandas()