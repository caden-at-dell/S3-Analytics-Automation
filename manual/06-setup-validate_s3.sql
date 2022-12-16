select * from sys.databases

-- credential     ecsandsql2022.solarch.lab.emc.com
    CREATE CREDENTIAL [s3://sqlpool.proddc.sql]
    WITH IDENTITY = 'S3 Access Key'
    , SECRET = 'sqluser:36AoZuXf/4ZguU8uH3IJsFcQklKx1yS7Hqb05sVA'

select * from sys.credentials

--BACKUP DATABASE PolybaseDemo TO URL = 's3://sqlpool.proddc.sql/sqlbackup/PolybaseDemo.bak' WITH COMPRESSION, STATS = 1, FORMAT, INIT

BACKUP DATABASE  WideWorldImportersDW
    TO URL = 's3://sqlpool.proddc.sql/demo/backup/new_wwi_dw_full.bak'
    WITH FORMAT --this will overwrite the previous version
        ,COMPRESSION
        ,STATS = 10
        ,NAME = 'S3 backup to Dell ECS'
--================================

-- Verify logical and physical database file detials from backup file on S3
RESTORE FILELISTONLY 
FROM URL = 's3://sqlpool.proddc.sql/demo/backup/new_wwi_dw_full.bak'

-- Restore Backup from S3
RESTORE DATABASE testdb
FROM URL = 's3://sqlpool.proddc.sql/demo/backup/new_wwi_dw_full.bak'
WITH 
MOVE N'WWI_Primary' TO N'/var/opt/mssql/data/testdb_primary.mdf',
MOVE N'WWI_UserData' TO N'/var/opt/mssql/data/testdb_UserData.ndf',
MOVE N'WWI_Log' TO N'/var/opt/mssql/data/testdb.ldf',
MOVE N'WWIDW_InMemory_Data_1' TO N'/var/opt/mssql/data/testdb_InMemory_Data_1',
REPLACE, STATS = 10;

--======================================================================================================================

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

CREATE DATABASE SCOPED CREDENTIAL s3_ds 
WITH IDENTITY = 'S3 Access Key' ,SECRET = 'sqluser:36AoZuXf/4ZguU8uH3IJsFcQklKx1yS7Hqb05sVA';
GO

SELECT * FROM sys.database_scoped_credentials;

CREATE EXTERNAL DATA SOURCE weatherDS
WITH
(LOCATION = 's3://sqlpool.proddc.sql/'
,CREDENTIAL = s3_ds
)

-- if following error received, restart (drop/recreate sql pod) SQL container
--Msg 46530, Level 16, State 11, Line 37
--External data sources are not supported with type GENERIC.


SELECT * FROM sys.external_data_sources;

select City, Country, Latitude, Longitude from (
SELECT  *
FROM OPENROWSET
(    BULK '/analyticsdata/weather/csv/city_attributes.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( City varchar(50), Country varchar(50), Latitude DECIMAL(20, 6),  Longitude DECIMAL(20, 6) )
AS   [Test1]) a


select @@VERSION

--=============================

CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH(FORMAT_TYPE = PARQUET);
GO

-- DROP EXTERNAL TABLE ext_city_attributes
-- Create a new external table  
CREATE EXTERNAL TABLE ext_demo_city_attributes ( 
  City varchar(50) NULL,
  Country varchar(50) NULL,
  Latitude DECIMAL(20, 6) NULL,
  Longitude DECIMAL(20, 6) NULL
)  
WITH (   
	LOCATION = '/analyticsdata/weather/parquet/ext_city_attributes.parquet',
	DATA_SOURCE = weatherDS,  
	FILE_FORMAT = ParquetFileFormat
);

select * from ext_demo_city_attributes

-- create stats on external table
-- Multi-column statistics are not supported.
CREATE STATISTICS [stat1_ext_demo_city_attributes] ON [dbo].[ext_demo_city_attributes]([City])
CREATE STATISTICS [stat2_ext_demo_city_attributes] ON [dbo].[ext_demo_city_attributes]([Country])
CREATE STATISTICS [stat3_ext_demo_city_attributes] ON [dbo].[ext_demo_city_attributes]( [Latitude])
CREATE STATISTICS [stat4_ext_demo_city_attributes] ON [dbo].[ext_demo_city_attributes]( [Longitude])
GO


-- Enable Polybase export
exec sp_configure @configname = 'allow polybase export'
exec sp_configure @configname = 'allow polybase export', @configvalue = 1;
RECONFIGURE WITH OVERRIDE ;
GO
exec sp_configure @configname = 'allow polybase export'
GO
