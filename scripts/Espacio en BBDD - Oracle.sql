--ESPACIO DISPONIBLE EN LOS TABLESPACES
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

--ESPACIO DISPONIBLE EN LOS DISKGROUPS DE ASM
  SELECT name,
         free_mb,
         total_mb,
         ROUND (free_mb / total_mb * 100, 2) "FREE_%"
    FROM v$asm_diskgroup
ORDER BY 4;