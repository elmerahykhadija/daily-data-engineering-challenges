/*
Given a single column of numbers, consider all possible permutations of two numbers with replacement, assuming that pairs of numbers (x,y) and (y,x) are two different permutations. Then, for each permutation, find the maximum of the two numbers.
Output three columns: the first number, the second number and the maximum of the two.

Table
deloitte_numbers

*/
select a.number as n1 , b.number as n2,GREATEST(a.number,b.number) as maximum
from deloitte_numbers a
cross join deloitte_numbers b ;