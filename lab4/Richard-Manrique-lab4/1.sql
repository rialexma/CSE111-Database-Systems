--1 done
SELECT c_name,
       round(sum(o_totalprice), 2),
       n_name
  FROM orders,
       nation,
       customer
 WHERE o_custkey = c_custkey AND 
       c_nationkey = n_nationkey AND 
       n_name = 'FRANCE'
 GROUP BY c_name;