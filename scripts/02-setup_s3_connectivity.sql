USE [master]
GO
ALTER DATABASE [WideWorldImporters] SET COMPATIBILITY_LEVEL = 160;
ALTER DATABASE [WideWorldImportersDW] SET COMPATIBILITY_LEVEL = 160;
-- credential     ecsandsql2022.solarch.lab.emc.com
    CREATE CREDENTIAL [s3://sqlpool.proddc.sql]
    WITH IDENTITY = 'S3 Access Key'
    , SECRET = 'sqluser:36AoZuXf/4ZguU8uH3IJsFcQklKx1yS7Hqb05sVA'

select * from sys.credentials;
--================================
SELECT SERVERPROPERTY ('IsPolyBaseInstalled') AS IsPolyBaseInstalled;
exec sp_configure @configname = 'polybase enabled'
exec sp_configure @configname = 'polybase enabled', @configvalue = 1;
RECONFIGURE WITH OVERRIDE ;
GO
exec sp_configure @configname = 'polybase enabled'
GO
-- ====================
USE WideWorldImportersDW
GO

CREATE MASTER KEY ENCRYPTION BY PASSWORD = '@Vantage4'; 

CREATE DATABASE SCOPED CREDENTIAL s3_ecs 
WITH IDENTITY = 'S3 Access Key' ,SECRET = 'sqluser:36AoZuXf/4ZguU8uH3IJsFcQklKx1yS7Hqb05sVA';
GO

