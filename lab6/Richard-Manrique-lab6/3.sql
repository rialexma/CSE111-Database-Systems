--3 done
SELECT count(p_partkey) 
  FROM (
           SELECT p1.p_partkey,
                  count(s1.s_suppkey) AS total
             FROM nation,
                  partsupp,
                  supplier s1,
                  part p1
            WHERE n_nationkey = s1.s_nationkey AND 
                  s1.s_suppkey = ps_suppkey AND 
                  ps_partkey = p1.p_partkey AND 
                  n_name = 'CANADA'
            GROUP BY p1.p_partkey
           HAVING total > 1
            ORDER BY p1.p_partkey
       );