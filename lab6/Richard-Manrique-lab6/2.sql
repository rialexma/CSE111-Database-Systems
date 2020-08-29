--2 done
--finding the amount of customers with orders
SELECT count(c_custkey) 
  FROM 
       (
           SELECT  c1.c_custkey,
                   count(o1.o_orderkey) AS amtOrder
             FROM orders o1,
                  customer c1
            WHERE c1.c_custkey = o1.o_custkey AND 
                  o_orderdate LIKE '1995-08%'
                  group by c1.c_custkey
                  having amtOrder < 3
                  order by c1.c_custkey asc
       );