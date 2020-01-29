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
 WHERE a.tablespace_name = b.tablespace_name--AVAILABLE SPACE IN THE TABLESPACES
  SELECT a.tablespace_name,
         a.free_mb,
         b.total_mb,
         ROUND ( (a.free_mb / b.total_mb) * 100, 2) "FREE_%"
    FROM (  SELECT tablespace_name,
                   ROUND (SUM (bytes) / (POWER (1024, 2)), 2) free_mb
              FROM dba_free_space
          GROUP BY tablespace_name) a,
         (  SELECT tablespace_name,
                   ROUND (SUM (bytes) / (POWER (1024, 2)), 2) total_mb
              FROM dba_data_files
          GROUP BY tablespace_name) b
   WHERE a.tablespace_name = b.tablespace_name
ORDER BY 4;

--AVAILABLE SPACE IN ASM DISKGROUPS
  SELECT name,
         free_mb,
         total_mb,
         ROUND (free_mb / total_mb * 100, 2) "FREE_%"
    FROM v$asm_diskgroup
ORDER BY 4;

--DATAFILE SIZE
  SELECT TB.NAME "TABLESPACE",
         df.file_name "DATAFILE",
         ROUND (df.BYTES / POWER (1024, 3), 2) "SIZE (GB)",
         df.AUTOEXTENSIBLE,
         ROUND (df.MAXBYTES / POWER (1024, 3), 2) "MAXSIZE (GB)"
    FROM dba_data_files df, v$tablespace tb
   WHERE df.tablespace_name = tb.name
ORDER BY tb.ts#

--LOGIFLE STRUCTURE
  SELECT l2.group#,
         l2.MEMBER,
         ROUND (l1.BYTES / POWER (1024, 3), 2) "SIZE (GB)",
         l1.members,
         l2.TYPE,
         l2.is_recovery_dest_file
    FROM v$log l1, v$logfile l2
   WHERE l1.group# = l2.group#
ORDER BY l2.group#
