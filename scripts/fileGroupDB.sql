USE master;
DROP DATABASE testdb;
DROP DATABASE prodb;
GO

-- Creating a login for the user in both databases
CREATE LOGIN scott
WITH PASSWORD = 'tiger01*';
GO

-- Creating a partially contained database with a Filegroup
/*A partially contained database allows us to create a user that can 
  connect to it without the need to create a login that matches the user.
  Useful when moving the database between servers.*/
CREATE DATABASE testdb
CONTAINMENT = PARTIAL
ON PRIMARY
(NAME = 'test1',
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\test1.mdf',
 SIZE = 1mb,
 MAXSIZE = 20mb,
 FILEGROWTH = 5%),
FILEGROUP fg_test
(NAME = 'test2',
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\test2.ndf',
 SIZE = 1mb,
 MAXSIZE = 20mb,
 FILEGROWTH = 5%),
(NAME = 'test3',
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\test3.ndf',
 SIZE = 1mb,
 MAXSIZE = 20mb,
 FILEGROWTH = 5%)
LOG ON
(NAME = 'log1',
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\log1.ldf',
 SIZE = 1mb,
 MAXSIZE = 20mb,
 FILEGROWTH = 5%);
 GO

 USE testdb;
 GO

-- Checking the created files
select * from sys.database_files;

-- Alter the default filegroup
ALTER DATABASE testdb
MODIFY FILEGROUP [fg_test] DEFAULT;

-- Adding a file to the PRIMARY filegroup
ALTER DATABASE testdb
ADD FILE
(NAME = 'test4',
 FILENAME = 'C:\Program Files\Microsoft SQL Server\MSSQL14.SQL2K17_PROD\MSSQL\DATA\test4.ndf',
 SIZE = 1mb,
 MAXSIZE = 20mb,
 FILEGROWTH = 5%)
TO FILEGROUP [PRIMARY];

CREATE TABLE prueba (ID int);
INSERT INTO prueba VALUES (1);
GO 6

-- How to create a linked server in SQL Server
EXEC master.dbo.sp_addlinkedserver   
    @server = N'WIN-25AFSPLBHNU\SQL2K17_PROD',   
    @srvproduct=N'SQL Server';  
GO  

EXEC master.dbo.sp_addlinkedsrvlogin   
     @rmtsrvname = N'WIN-25AFSPLBHNU\SQL2K17_PROD',   
     @locallogin = NULL,   
     @useself = N'False',
     @rmtuser = 'scott',
     @rmtpassword = 'tiger01*';  
GO

-- Creating a normal database
CREATE DATABASE prodb;
GO
ALTER DATABASE prodb
SET CONTAINMENT = PARTIAL;
GO

-- Creating the users in the databases
USE testdb;
CREATE USER scott FOR LOGIN scott;
USE prodb;
CREATE USER scott FOR LOGIN scott;

USE testdb;
GRANT SELECT ON prueba TO scott;
GO
USE prodb;
CREATE TABLE prueba (ID int);
INSERT INTO prueba VALUES (1);
GO 5
GRANT SELECT ON prueba TO scott;
GO