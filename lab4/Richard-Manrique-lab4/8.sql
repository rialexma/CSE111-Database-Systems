--8 done
SELECT n_name,
       count(distinct o_orderkey ) 
  FROM region,
       nation,
       orders,
       supplier,
       lineitem
 WHERE n_regionkey = r_regionkey AND 
       n_nationkey = s_nationkey AND 
       s_suppkey = l_suppkey and
       l_orderkey = o_orderkey and
       o_orderstatus = 'F' AND 
       o_orderdate LIKE '1995%' AND 
       r_name = 'AMERICA'
 GROUP BY n_name;