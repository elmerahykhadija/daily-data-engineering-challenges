"""
Find wine varieties tasted by 'Roger Voss' and with a value in the 'region_1' column of the dataset. Output unique variety names only.

Table
winemag_p2

"""
# Import your libraries
import pyspark
byroger=winemag_p2.filter((winemag_p2["taster_name"]=="Roger Voss") & (winemag_p2["region_1"].isNotNull() ))
# Start writing code
df=byroger.select(byroger["variety"]).distinct()


# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()