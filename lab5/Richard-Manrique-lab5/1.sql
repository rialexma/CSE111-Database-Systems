--1 done
SELECT count(DISTINCT c_name) 
  FROM region,
       nation,
       customer
 WHERE r_regionkey = n_regionkey AND 
       n_nationkey = c_nationkey AND 
       r_name NOT IN ('EUROPE', 'AFRICA');