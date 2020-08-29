--3 done
SELECT n_name,
       count( * ) 
  FROM nation,
       orders,
       customer,
       region
 WHERE c_custkey = o_custkey AND 
       c_nationkey = n_nationkey AND 
       n_regionkey = r_regionkey AND 
       r_name = 'EUROPE'
 GROUP BY n_name;