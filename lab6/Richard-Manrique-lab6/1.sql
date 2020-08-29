--1 done
SELECT strftime('%m', l_shipdate) AS month,
       avg(l_quantity) 
  FROM lineitem
 WHERE l_shipdate LIKE '1996%'
 GROUP BY month
 ORDER BY month ASC;