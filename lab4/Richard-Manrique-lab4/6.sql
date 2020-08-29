--6 done
SELECT p_mfgr,
       o_orderpriority,
       count( * ) 
  FROM part,
       orders,
       lineitem
 WHERE p_partkey = l_partkey AND 
       l_orderkey = o_orderkey
 GROUP BY p_mfgr,
          o_orderpriority;