-- 4 done
SELECT s_name,
       count( distinct p_partkey ) 
  FROM part,
       supplier,
       lineitem,
       nation
 WHERE p_partkey = l_partkey AND 
       s_suppkey = l_suppkey AND 
       s_nationkey = n_nationkey AND 
       p_size < 20 AND 
       n_name = 'BRAZIL'
 GROUP BY s_name;