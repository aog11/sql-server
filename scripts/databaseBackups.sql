-- Setting recovery options 
ALTER DATABASE [dbname]
SET RECOVERY [option];
GO

-- Options:
/*
Full        - All transaction logs a backed up and recovery can be made to any point in time. 
			  Also, transaction logs stay growing.
Simple      - Once transactions are written to a data file, it's replaced by a new one, so the 
			  recovery can only be made to the most recent backed up transactions.
Bulk logged - Functions like a full backup but doesn't register BULK opertaions (INSERT, SELECT INTO, etc.).
*/

-- BACKUP DATABASE command

-- Show the progress stats of the backup: WITH STATS
BACKUP DATABASE [dbname] TO DISK = 'location' WITH STATS = 1

-- Assign a password to the backup: WITH PASSWORD
BACKUP DATABASE [dbname] TO DISK = 'location' WITH PASSWORD = 'password'

-- Assign a description to the backup: WITH DESCRIPTION
BACKUP DATABASE [dbname] TO DISK = 'location' WITH DESCRIPTION = 'description'

-- Backup database to multiple disks
BACKUP DATABASE [dbname] 
TO DISK = 'location #1', 
DISK = 'location #2',
DISK = 'location #3'

-- Create a mirrored backup
BACKUP DATABASE [dbname] 
TO DISK = 'location #1'
MIRROR TO DISK = 'location #2'
--***************************************************************************--
-- Creating a full backup to a disk file
BACKUP DATABASE testdb
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\testdb.bak'
GO

-- Creating a transaction log backup to a disk file (Only works with Full recovery mode)
BACKUP LOG testdb
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\testdb.TRN'
GO

-- Adding data to the database after the full backup
create table names (name varchar(20));

insert into names values ('Antoni');
insert into names values ('Steelers');
insert into names values ('Chargers');

-- Creating a differential backup (Backs up all extents since last full backup)
BACKUP DATABASE testdb
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\testdb_diff.bak' WITH DIFFERENTIAL
GO

-- Creating a file backup
BACKUP DATABASE testdb FILE = 'test1'
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\test1.fil'
GO

-- Creating a filegroup backup
BACKUP DATABASE testdb FILEGROUP = 'fg_test'
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\fg_test.flg'
GO

-- Creating a partial backup to the read/write filegroups
BACKUP DATABASE [testdb] READ_WRITE_FLIEGROUPS
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\testdb.bak'
GO

-- Creating a differential partial backup to the read/write filegroups
BACKUP DATABASE testdb READ_WRITE_FLIEGROUPS
TO DISK = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\testdb_diff.bak' WITH DIFFERENTIAL
GO

-- Script to backup the database
USE master;
GO
DECLARE @filename varchar(1000), 
		@dbname varchar(100) = 'prodb',
		@location varchar(1000) = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\',
		@date varchar(10) = FORMAT (GETDATE(),'ddMMyyyy');
SELECT @filename = CONCAT (@location,@dbname,@date,'.bak');
BACKUP DATABASE @dbname TO DISK = @filename
GO

-- Script to restore the database
USE master;
GO
DECLARE @filename varchar(1000), 
		@dbname varchar(100) = 'prodb',
		@location varchar(1000) = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\Backup\',
		@date varchar(10) = FORMAT (GETDATE(),'ddMMyyyy');
SELECT @filename = CONCAT (@location,@dbname,@date,'.bak');
RESTORE DATABASE @dbname FROM DISK = @filename
GO