/*This is the same question as problem #8 in the SQL Chapter of Ace the Data Science Interview!

Assume you're given a table containing job postings from various companies on the LinkedIn platform. Write a query to retrieve the count of companies that have posted duplicate job listings.

Definition:

Duplicate job listings are defined as two job listings within the same company that share identical titles and descriptions.
job_listings Table:
Column Name	Type
job_id	integer
company_id	integer
title	string
description	string*/

SELECT count(*) as duplicate_companies
from (
  SELECT company_id,title,description,count(*)
  FROM job_listings
  GROUP by company_id,title,description
  HAVING count(*)>=2
) as helper;