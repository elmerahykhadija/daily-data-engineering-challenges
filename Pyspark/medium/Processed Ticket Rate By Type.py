# Import your libraries
import pyspark
from pyspark.sql.window import Window
from pyspark.sql.functions import col,sum,count
window=Window.partitionBy("type")
# Start writing code
df=facebook_complaints.withColumns(
    {
    "prc":sum(col("processed").cast("int")).over(window),
    "total":count("*").over(window)
    }
    )
df=df.withColumns({
    "type":col("type"),
    "processed_rate":col("prc")/col("total")
})
out=df.select(["type","processed_rate"]).distinct()

# To validate your solution, convert your final PySpark df to a pandas df
out.toPandas()