--1 done
SELECT strftime('%m', l_shipdate) AS month,
       avg(l_quantity) 
  FROM lineitem
 WHERE l_shipdate LIKE '1996%'
 GROUP BY month
 ORDER BY month ASC;

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

--4 done
SELECT count(s_suppkey) 
  FROM (
           SELECT count(DISTINCT p1.p_partkey) AS total,
                  s1.s_suppkey
             FROM nation,
                  partsupp,
                  part p1,
                  supplier s1
            WHERE n_nationkey = s1.s_nationkey AND 
                  s1.s_suppkey = ps_suppkey AND 
                  ps_partkey = p1.p_partkey AND 
                  n_name = 'CANADA'
            GROUP BY s1.s_suppkey
           HAVING total > 4
            ORDER BY s1.s_suppkey ASC
       );
   
--5 done
SELECT count(DISTINCT s.s_suppkey) 
  FROM (
           SELECT s1.s_suppkey,
                  min(p1.p_retailprice) AS minimum
             FROM supplier s1,
                  part p1,
                  partsupp
            WHERE s1.s_suppkey = ps_suppkey AND 
                  ps_partkey = p1.p_partkey-- GROUP BY s1.s_suppkey
           HAVING minimum = p1.p_retailprice
            ORDER BY s1.s_suppkey
       ),
       supplier s,
       partsupp,
       part
 WHERE s.s_suppkey = ps_suppkey AND 
       ps_partkey = p_partkey AND 
       p_retailprice = minimum;

--6 done
SELECT s.s_name,
       c.c_name
  FROM (
           SELECT s1.s_name,
                  c1.c_name,
                  max(o1.o_totalprice) AS max
             FROM customer c1,
                  supplier s1,
                  lineitem,
                  orders o1
            WHERE c1.c_custkey = o1.o_custkey AND 
                  s1.s_suppkey = l_suppkey AND 
                  l_orderkey = o1.o_orderkey AND 
                  o1.o_orderstatus = 'F'
           --GROUP BY s1.s_name
           HAVING o1.o_totalprice = max
            ORDER BY s1.s_name ASC
       ),
       customer c,
       supplier s,
       lineitem,
       orders o2
 WHERE c.c_custkey = o2.o_custkey AND 
       s.s_suppkey = l_suppkey AND 
       l_orderkey = o2.o_orderkey AND 
       o2.o_totalprice = max;

--7 done
SELECT count(*) 
  FROM (
           SELECT c1.c_custkey,
                  count(o1.o_orderkey) as total,
                  l_suppkey
             FROM customer c1,
                  orders o1,
                  nation,
                  lineitem
            WHERE n_nationkey = c1.c_nationkey AND 
                  c1.c_custkey = o1.o_custkey AND 
                  l_orderkey = o_orderkey AND 
                  (n_name = 'GERMANY' OR 
                   n_name = 'FRANCE') 
            GROUP BY l_suppkey
           HAVING count(DISTINCT o1.o_orderkey) < 30
            --ORDER BY l_suppkey ASC
       );--,
       --supplier s
 --where total < 30;

       
--8 done
SELECT count(distinct o_custkey) 
  FROM orders 
  where o_orderkey in (
           SELECT l_orderkey
                  FROM lineitem,
                  supplier s1,
                  nation,
                  region
            WHERE n_nationkey = s1.s_nationkey AND 
                  l_suppkey = s1.s_suppkey  AND 
                  r_regionkey = n_regionkey AND 
                  r_name = 'ASIA'
            GROUP BY l_orderkey
            
except
 SELECT l_orderkey             
            FROM lineitem,
                  supplier s1,
                  nation,
                  region
            WHERE n_nationkey = s1.s_nationkey AND 
                  l_suppkey = s1.s_suppkey  AND 
                  r_regionkey = n_regionkey AND 
                  r_name <> 'ASIA'
            GROUP BY l_orderkey
       );

--9 close
SELECT DISTINCT p_name
  FROM (
           SELECT DISTINCT p1.p_name,
                           c1.c_custkey,
                           count(DISTINCT s1.s_suppkey) AS total
             FROM region,
                  nation,
                  supplier s1,
                  partsupp,
                  customer c1,
                  part p1,
                  orders
            WHERE r_regionkey = n_regionkey AND 
                  n_nationkey = s1.s_nationkey AND 
                  n_nationkey = c1.c_nationkey AND 
                  c1.c_custkey = o_custkey AND 
                  s1.s_suppkey = ps_suppkey AND 
                  ps_partkey = p1.p_partkey
            GROUP BY c1.c_custkey
           HAVING total = 4
            ORDER BY s1.s_suppkey ASC
       );
