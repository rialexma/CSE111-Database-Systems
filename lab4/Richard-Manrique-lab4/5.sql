--5 done
SELECT c_name,
       count( * ) 
  FROM customer,
       orders,
       nation
 WHERE c_nationkey = n_nationkey AND 
       o_custkey = c_custkey AND 
       n_name = 'GERMANY' AND 
       o_orderdate LIKE '1995%'
 GROUP BY c_name;