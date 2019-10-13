use master;
GO

-- Creating the database
create database testdb
on
(name = 'test_1',
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\test1.mdf',
size = 10mb,
maxsize = 20mb,
filegrowth = 10mb)
log on
(name = 'log_1',
filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\log1.ldf',
size = 1mb,
maxsize = 2mb,
filegrowth = 1mb);
GO

-- Adding a file to the database
alter database testdb
add file
(name = 'test_2',
 filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\test2.mdf',
 size = 1mb,
 maxsize = 20mb,
 filegrowth = 5mb
 )
GO

-- Removing a file from the database
alter database testdb
remove file "test_2";
GO

 -- Taking the database offline and ending all connections to it to move some files
alter database testdb 
set offline with rollback immediate;
GO

-- Moving files in the database
alter database testdb
modify file
(name = 'test_1',
 filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\databases\test1.mdf')
alter database testdb
modify file
(name = 'test_2',
 filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\databases\test2.mdf')
alter database testdb
modify file
(name = 'log_1',
 filename = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\databases\log1.ldf')

-- Taking the database online to see the effects
alter database testdb set online;
GO

-- Verifying the changes
use testdb;
GO

select * from sys.database_files;