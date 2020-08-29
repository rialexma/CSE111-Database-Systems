--10 done
SELECT p_type,
       max(l_discount) 
  FROM part,
       lineitem
 WHERE p_partkey = l_partkey AND 
       p_type LIKE 'ECONOMY%'
 GROUP BY p_type;