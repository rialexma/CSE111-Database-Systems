--1
SELECT count(DISTINCT c_name) 
  FROM region,
       nation,
       customer
 WHERE r_regionkey = n_regionkey AND 
       n_nationkey = c_nationkey AND 
       r_name NOT IN ('EUROPE', 'AFRICA');


--2 close
SELECT r_name,
       count(s_name) 
  FROM region r1,
       nation,
       supplier,
       (
           SELECT avg(s_acctbal) as s_avg 
             FROM supplier,
                  nation,
                  region r2
            WHERE r_regionkey = n_regionkey AND 
                  n_nationkey = s_nationkey
            GROUP BY r_name
       ) avg_acctbal
 WHERE r1.r_regionkey = n_regionkey AND 
       n_nationkey = s_nationkey AND 
       r1.r_name = avg_acctbal.r_name AND
       s_acctbal > avg_acctbal.s_acctbal
 GROUP BY r_name
 ORDER BY r_name ASC;



--3 done
SELECT max(l_discount) 
  FROM lineitem,
       orders
 WHERE l_orderkey = o_orderkey AND 
       o_orderdate LIKE '1995-05-%' AND 
       l_discount < (
                        SELECT avg(l_discount) 
                          FROM lineitem
                    );




--4 done
SELECT distinct n_name as nation,
       count(DISTINCT c_name) AS cust,
       count(DISTINCT s_name) AS supp
  FROM region r1,
       region r2,
       nation n1,
       nation n2,
       customer,
       supplier
 WHERE r1.r_regionkey = n1.n_regionkey AND 
       r2.r_regionkey = n2.n_regionkey AND
       n1.n_nationkey = n2.n_nationkey AND 
       n1.n_nationkey = s_nationkey AND 
       n2.n_nationkey = c_nationkey AND 
       r1.r_name = 'EUROPE' AND 
       r2.r_name = 'EUROPE'
 GROUP BY  n1.n_name, n2.n_name;
 
--5 close
SELECT s_name,
       p_size,
       min(ps_supplycost) 
  FROM supplier,
       part,
       partsupp,
       nation,
       region
 WHERE r_regionkey = n_regionkey AND 
       n_nationkey = s_nationkey AND 
       s_suppkey = ps_suppkey AND 
       ps_partkey = p_partkey AND 
       r_name = 'AMERICA' AND
       p_type LIKE '%STEEL'
       group by s_name
       order by s_name asc;


--6 ?????
SELECT DISTINCT p_mfgr
  FROM part,
       partsupp,
       supplier
 WHERE s_suppkey = ps_suppkey AND 
       ps_partkey = p_partkey AND 
       s_name = 'Supplier#000000053' AND 
       ps_availqty < (
                         SELECT ps_availqty
                           FROM partsupp
                           
                     );

       --HAVING min(ps_availqty) = ps_avilqty

--7 done
select distinct o_orderpriority, count (p_partkey)
from orders, lineitem, part
where l_orderkey = o_orderkey AND 
p_partkey = l_partkey AND
o_orderdate like '1996%' AND
l_receiptdate < l_commitdate
group by o_orderpriority;

--8 done
SELECT count(DISTINCT s_name) 
  FROM supplier,
       part,
       partsupp
 WHERE s_suppkey = ps_suppkey AND 
       ps_partkey = p_partkey AND 
       p_type LIKE 'MEDIUM POLISHED%' 
       AND 
       p_size in (3,23,26,49);


--9
SELECT count(distinct ps_suppkey) 
  FROM partsupp,
       nation,
       supplier
 WHERE n_nationkey = s_nationkey AND 
       s_suppkey = ps_suppkey AND 
       n_name = ('CANADA') 
 LIMIT 0.03 < (
                   SELECT count( * )  
                     FROM partsupp
               );


--10
SELECT r_name,
       count(DISTINCT c_custkey) 
  FROM region,
       nation,
       customer,
       orders
 WHERE r_regionkey = n_regionkey AND 
       n_nationkey = c_nationkey AND 
       c_custkey = o_custkey AND 
       o_orderdate  not IN (
           SELECT o_orderdate
             FROM orders
       )
AND 
       c_acctbal > (
                       SELECT avg( c_acctbal) 
                         FROM customer
                   )
 GROUP BY r_name;

        



--11 done
SELECT max(l_extendedprice * (1 - l_discount) ) 
  FROM lineitem
 WHERE l_shipdate NOT IN ('1997-10-02');


--12
SELECT sum(p_retailprice) 
  FROM part,
       supplier,
       lineitem
 WHERE s_suppkey = l_suppkey AND 
       p_partkey = l_partkey AND 
       p_retailprice < 1000 AND 
       l_shipdate = '1996%';


--13 close
SELECT o_orderpriority,
       count(DISTINCT o_orderkey) 
  FROM orders,
       customer
 WHERE c_custkey = o_custkey AND 
       o_orderdate >= '1996-10-01' AND 
       o_orderdate <= '1996-12-31' AND 
       EXISTS (
           SELECT *
             FROM lineitem,
                  orders
            WHERE o_orderkey = l_orderkey AND 
                  o_orderdate < l_commitdate
                  
       )
 GROUP BY o_orderpriority
 order by o_orderpriority asc;



--14
SELECT r1.r_name,
       r2.r_name,
       strftime('%Y', l_shipdate) AS year,
       sum(l_extendedprice * (1 - l_discount) ) 
  FROM lineitem,
       customer,
       region r1,
       region r2,
       nation n1,
       nation n2,
       supplier,
       orders,
       part,
       partsupp
 WHERE r1.r_regionkey = n1.n_regionkey AND 
       r2.r_regionkey = n2.n_regionkey AND 
       n1.n_nationkey = s_nationkey AND 
       n2.n_nationkey = c_nationkey AND 
       c_custkey = o_custkey AND 
       s_suppkey = l_suppkey AND 
       o_orderkey = l_orderkey AND 
       p_partkey = ps_partkey AND 
       ps_partkey = l_partkey AND 
       l_shipdate = '1995%' AND 
       l_shipdate = '1996'
 GROUP BY r1.r_name,
          r2.r_name
 ORDER BY year ASC;



--15
SELECT sum(l_extendedprice * (1 - l_discount) ) 
  FROM lineitem,
       nation,
       region,
       supplier
 WHERE n_regionkey = r_regionkey AND 
       n_nationkey = s_nationkey AND 
       s_suppkey = l_suppkey AND 
       n_name = 'UNITED STATES' AND 
       r_name = 'EUROPE' AND 
       l_shipdate = '1996%';
