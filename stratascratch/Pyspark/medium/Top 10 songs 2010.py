# Import your libraries
import pyspark

# Start writing code
df=billboard_top_100_year_end.filter(billboard_top_100_year_end["year"]==2010).select(["year_rank","group_name","song_name"]).distinct()
df=df.filter(df["year_rank"]<=10)
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()