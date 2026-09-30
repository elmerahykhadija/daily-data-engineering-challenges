/*
Find the best-selling item for each month (no need to separate months by year). The best-selling item is determined by the highest total sales amount, calculated as: total_paid = unitprice * quantity. A negative quantity indicates a return or cancellation (the invoice number begins with 'C'. To calculate sales, ignore returns and cancellations. Output the month, description of the item, and the total amount paid.

Table
online_retail
*/
select month,description,total_paid
from (
select  description,
    EXTRACT(MONTH FROM invoicedate) as month,
    SUM(quantity *unitprice) OVER(PARTITION BY EXTRACT(MONTH FROM invoicedate),DESCRIPTION) AS total_paid,
    rank() over (partition by EXTRACT(MONTH FROM invoicedate) order by quantity *unitprice desc) as n 
from online_retail
WHERE SUBSTRING(invoiceno,1,1)!='C'
) as t
where n=1;