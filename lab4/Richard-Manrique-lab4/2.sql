--2 done
SELECT n_name,
       count( * ) 
  FROM nation,
       supplier
 WHERE n_nationkey = s_nationkey
 GROUP BY n_name;