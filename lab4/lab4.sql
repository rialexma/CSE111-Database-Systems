--1
select count(c_name)
from region, nation, customer
where r_regionkey = n_regionkey
AND n_nationkey = c_nationkey
AND r_name <> 'EUROPE'
and r_name <> 'AMERICA';

--2
SELECT r_name,
       count(DISTINCT s_name) 
  FROM region,
       nation,
       supplier
 WHERE r_regionkey = n_regionkey AND 
       n_nationkey = s_nationkey
 GROUP BY r_name
HAVING avg(s_acctbal) < s_acctbal;



--3
SELECT max(l_discount) 
  FROM lineitem,
       orders
 WHERE l_orderkey = o_orderkey AND 
       o_orderdate LIKE '1995-05-%'
HAVING avg(l_discount) <= l_discount;


--4
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
 GROUP BY  n1.n_name, n2.n_name
 
--5
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
       r_name = 'AMERICA'
HAVING p_type LIKE 'STEEL';


--6
SELECT DISTINCT p_mfgr
  FROM part,
       partsupp,
       supplier
 WHERE s_suppkey = ps_suppkey AND 
       ps_partkey = p_partkey AND 
       s_name = 'Supplier#000000053'
HAVING min(ps_availqty) = ps_avilqty;
