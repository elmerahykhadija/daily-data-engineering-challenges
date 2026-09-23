"""
Calculate number of reviews for every business category. Output the category along with the total number of reviews. Order by total reviews in descending order.

Table
yelp_business

"""
# Import your libraries
import pyspark
from pyspark.sql.functions import split,explode,sum
# Start writing code
df=yelp_business.withColumn(
    "categories",
    split(yelp_business["categories"],";")
    )
df=df.withColumn(
    "categories",
    explode(df["categories"])
    )
df=df.groupby("categories").agg(
    sum("review_count").alias("total")
    )
df=df.orderBy(df["total"].desc())
# To validate your solution, convert your final PySpark df to a pandas df
df.toPandas()