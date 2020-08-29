--13 done
SELECT  count( distinct o_orderkey ) 
  FROM supplier,
       nation,
       region,
       lineitem,
       orders
 WHERE s_nationkey = n_nationkey AND 
       n_regionkey = r_regionkey AND 
       s_suppkey = l_suppkey     AND
       o_orderkey = l_orderkey and
       r_name = 'EUROPE' AND 
       o_orderkey in
       (
           SELECT  o_orderkey  
             FROM nation,
                  customer,
                  orders
            WHERE n_nationkey = c_nationkey AND 
                  o_custkey = c_custkey AND 
                  n_name = 'CANADA'
       );