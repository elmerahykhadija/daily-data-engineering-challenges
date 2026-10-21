"""
Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.

Tables
facebook_reactions
facebook_posts

"""
# Import your libraries
import pyspark
df=facebook_reactions.filter(facebook_reactions['reaction']=='heart')
joined=facebook_posts.join(
    df,
    on='post_id',
    how='inner'
    ).select(facebook_posts["*"]).distinct()

# To validate your solution, convert your final PySpark df to a pandas df
joined.toPandas()