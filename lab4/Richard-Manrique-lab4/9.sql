--9 done
SELECT  count(distinct o_clerk) 
  FROM orders,
       nation,
       supplier,
       partsupp,
       lineitem
 WHERE o_orderkey = l_orderkey AND 
       l_suppkey = ps_suppkey AND 
       ps_suppkey = s_suppkey AND 
       n_nationkey = s_nationkey AND 
       n_name = 'RUSSIA';