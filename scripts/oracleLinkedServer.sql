/*Script generado por SSMS para la creación de un Linked Server hacia Oracle*/
USE [master]
GO

EXEC master.dbo.sp_addlinkedserver @server = N'MARS.ANTONI.COM', @srvproduct=N'Oracle', @provider=N'OraOLEDB.Oracle', @datasrc=N'PRODB'
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'MARS.ANTONI.COM',@useself=N'False',@locallogin=NULL,@rmtuser=N'sh',@rmtpassword='sh'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'collation compatible', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'data access', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'dist', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'pub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'rpc', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'rpc out', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'sub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'connect timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'collation name', @optvalue=null
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'lazy schema validation', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'query timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'use remote collation', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'MARS.ANTONI.COM', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO