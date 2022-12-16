USE WideWorldImportersDW
GO

SELECT name FROM sys.database_scoped_credentials;
CREATE EXTERNAL DATA SOURCE weatherDS WITH (LOCATION = 's3://sqlpool.proddc.sql/',CREDENTIAL = s3_ecs);
SELECT name FROM sys.external_data_sources;

CREATE EXTERNAL FILE FORMAT ParquetFileFormat WITH(FORMAT_TYPE = PARQUET);

-- DROP EXTERNAL TABLE ext_city_attributes
-- Create a new external table  

-- Enable Polybase export
exec sp_configure @configname = 'allow polybase export'
exec sp_configure @configname = 'allow polybase export', @configvalue = 1;
RECONFIGURE WITH OVERRIDE ;
GO
exec sp_configure @configname = 'allow polybase export'
GO
