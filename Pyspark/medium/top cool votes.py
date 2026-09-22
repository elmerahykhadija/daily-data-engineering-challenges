"""
Top Cool Votes

Find the review_text that received the highest number of  cool votes.
Output the business name along with the review text with the highest number of cool votes.

Table
yelp_reviews
"""
# Import your libraries
import pyspark
from pyspark.sql.functions import sum,max

# Start writing code
df=yelp_reviews.groupby(["business_name","review_text"]).agg(
    sum("cool").alias("total_cool")
    )
maximum=df.agg(max("total_cool")).collect()[0][0]
# To validate your solution, convert your final PySpark df to a pandas df
df=df.filter(df["total_cool"]==maximum).select(["business_name","review_text"])
df.toPandas()