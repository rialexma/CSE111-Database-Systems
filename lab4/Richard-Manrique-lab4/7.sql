--7 done
SELECT n_name,
       o_orderstatus,
       count( * ) 
  FROM orders,
       customer,
       nation,
       region
 WHERE o_custkey = c_custkey AND 
       c_nationkey = n_nationkey AND 
       n_regionkey = r_regionkey AND 
       r_name = 'ASIA'
 GROUP BY n_name,
          o_orderstatus;