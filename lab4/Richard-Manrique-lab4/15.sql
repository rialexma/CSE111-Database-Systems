--15 done with views Q151 and Q152
SELECT  count( distinct o_orderkey ) 
  FROM orders,
       Q151
 WHERE o_custkey = c_custkey AND  
       c_acctbal < 0 AND
       o_orderkey in 
       (
           SELECT  o_orderkey 
             FROM Q152,
                  orders,
                  lineitem
            WHERE s_suppkey = l_suppkey AND 
                  l_orderkey = o_orderkey AND 
                  s_acctbal > 0
       );