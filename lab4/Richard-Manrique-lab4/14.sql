--14  done
SELECT r1.r_name AS s_region,
       r2.r_name AS c_region,
       round(sum(l_extendedprice),7)
  FROM region r1,
       region r2,
       nation n1,
       nation n2,
       supplier,
       customer,
       lineitem,
       orders
 WHERE r1.r_regionkey = n1.n_regionkey AND
       r2.r_regionkey = n2.n_regionkey AND 
       n1.n_nationkey = s_nationkey AND 
       n2.n_nationkey = c_nationkey AND 
       c_custkey = o_custkey AND 
       o_orderkey = l_orderkey AND 
       s_suppkey = l_suppkey
 GROUP BY r1.r_regionkey, r2.r_regionkey;