--11 near
SELECT r_name,
       s_name
  FROM region,
       nation,
       supplier
 WHERE r_regionkey = n_regionkey AND 
       n_nationkey = s_nationkey
group by r_name
HAVING max(s_acctbal);