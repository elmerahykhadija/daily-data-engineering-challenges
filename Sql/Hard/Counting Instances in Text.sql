/*
Find the number of times the exact words bull and bear appear in the contents column.
Count all occurrences, even if they appear multiple times within the same row. Matches should be case-insensitive and only count exact words, that is, exclude substrings like bullish or bearing.
Output the word (bull or bear) and the corresponding number of occurrences.

Table
google_file_store
*/
with t1 as(
select unnest(string_to_array(contents,' ')) as word
from google_file_store
)
select word,count(*) as n
from t1
where word='bull' or word='bear'
group by word;