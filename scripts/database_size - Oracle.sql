--Not related to SQL Server but I didn't want to lose this useful script
SELECT a.tablespace_name,
       TRUNC (a.free_bytes / POWER (1024, 2), 2)       free_mb,
       TRUNC (b.total_bytes / POWER (1024, 2), 2)      total_mb,
       TRUNC ((a.free_bytes / b.total_bytes) * 100, 2) "FREE_%",
       CEIL (b.max_bytes / power(1024,3)) "MAX_SIZE (GB)"
  FROM (  SELECT dt.tablespace_name, SUM (bytes) free_bytes
            FROM dba_free_space dfs, dba_tablespaces dt
           WHERE dfs.tablespace_name = dt.tablespace_name
        GROUP BY dt.tablespace_name) a,
       (  SELECT dt.tablespace_name, SUM (bytes) total_bytes, sum(maxbytes) max_bytes
            FROM dba_data_files ddf, dba_tablespaces dt
           WHERE ddf.tablespace_name = dt.tablespace_name
        GROUP BY dt.tablespace_name) b
 WHERE a.tablespace_name = b.tablespace_name