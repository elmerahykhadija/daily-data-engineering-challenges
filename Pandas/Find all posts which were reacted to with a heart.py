"""
Find all posts which were reacted to with a heart. For such posts output all columns from facebook_posts table.

DataFrames
facebook_reactions
facebook_posts
"""
# Import your libraries
import pandas as pd

df=facebook_reactions[facebook_reactions["reaction"]=="heart"].merge(facebook_posts,
on="post_id",
how="inner",
suffixes=("", "_y")
)[facebook_posts.columns]
df=df.drop_duplicates()
df.head()