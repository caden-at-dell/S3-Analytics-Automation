USE WideWorldImportersDW
GO
--============= ext_city_attributes =======================
-- DROP EXTERNAL TABLE ext_city_attributes

CREATE EXTERNAL TABLE ext_city_attributes 
WITH 
(   
    LOCATION = '/demo/data/parquet/weather/city_attributes.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
select City, Country, Latitude, Longitude from (
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/weather/city_attributes.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( City varchar(50), Country varchar(50), Latitude DECIMAL(20, 6),  Longitude DECIMAL(20, 6) )
AS   [Test1]) a

-- select  * from ext_city_attributes

--============= ext_humidity.csv =======================
-- DROP EXTERNAL TABLE ext_humidity

CREATE EXTERNAL TABLE ext_humidity
WITH 
(   
    LOCATION = '/demo/data/parquet/weather/ext_humidity.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/weather/humidity.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( [datetime] datetime, Vancouver float, Portland float, [San Francisco] float, Seattle float,[Los Angeles] float, [San Diego] float, [Las Vegas] float, Phoenix float, Albuquerque float, Denver float, [San Antonio] float, Dallas float, Houston float, [Kansas City] float, Minneapolis float, [Saint Louis] float, Chicago float, Nashville float, Indianapolis float, Atlanta float, Detroit float, Jacksonville float, Charlotte float, Miami float, Pittsburgh float, Toronto float, Philadelphia float,[New York] float, Montreal float, Boston float, Beersheba float, [Tel Aviv District] float, Eilat float, Haifa float, Nahariyya float, Jerusalem float )
AS   [Test1]

-- select  * from ext_humidity
--============= ext_pressure.csv =======================
-- DROP EXTERNAL TABLE ext_pressure

CREATE EXTERNAL TABLE ext_pressure
WITH 
(   
    LOCATION = '/demo/data/parquet/weather/ext_pressure.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/weather/pressure.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( [datetime] datetime, Vancouver float, Portland float, [San Francisco] float, Seattle float,[Los Angeles] float, [San Diego] float, [Las Vegas] float, Phoenix float, Albuquerque float, Denver float, [San Antonio] float, Dallas float, Houston float, [Kansas City] float, Minneapolis float, [Saint Louis] float, Chicago float, Nashville float, Indianapolis float, Atlanta float, Detroit float, Jacksonville float, Charlotte float, Miami float, Pittsburgh float, Toronto float, Philadelphia float,[New York] float, Montreal float, Boston float, Beersheba float, [Tel Aviv District] float, Eilat float, Haifa float, Nahariyya float, Jerusalem float )
AS   [Test1]

-- select  * from ext_pressure
--============= ext_pressure.csv =======================
-- DROP EXTERNAL TABLE ext_temperature

CREATE EXTERNAL TABLE ext_temperature
WITH 
(   
    LOCATION = '/demo/data/parquet/weather/ext_temperature.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/weather/temperature.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( [datetime] datetime, Vancouver float, Portland float, [San Francisco] float, Seattle float,[Los Angeles] float, [San Diego] float, [Las Vegas] float, Phoenix float, Albuquerque float, Denver float, [San Antonio] float, Dallas float, Houston float, [Kansas City] float, Minneapolis float, [Saint Louis] float, Chicago float, Nashville float, Indianapolis float, Atlanta float, Detroit float, Jacksonville float, Charlotte float, Miami float, Pittsburgh float, Toronto float, Philadelphia float,[New York] float, Montreal float, Boston float, Beersheba float, [Tel Aviv District] float, Eilat float, Haifa float, Nahariyya float, Jerusalem float )
AS   [Test1]

-- select  * from ext_temperature
--============= ext_weather_description.csv =======================
-- DROP EXTERNAL TABLE ext_weather_description

CREATE EXTERNAL TABLE ext_weather_description
WITH 
(   
    LOCATION = '/demo/data/parquet/weather/ext_weather_description.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/weather/weather_description.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( [datetime] datetime, Vancouver varchar(200), Portland varchar(200), [San Francisco] varchar(200), Seattle varchar(200),[Los Angeles] varchar(200), [San Diego] varchar(200), [Las Vegas] varchar(200), Phoenix varchar(200), Albuquerque varchar(200), Denver varchar(200), [San Antonio] varchar(200), Dallas varchar(200), Houston varchar(200), [Kansas City] varchar(200), Minneapolis varchar(200), [Saint Louis] varchar(200), Chicago varchar(200), Nashville varchar(200), Indianapolis varchar(200), Atlanta varchar(200), Detroit varchar(200), Jacksonville varchar(200), Charlotte varchar(200), Miami varchar(200), Pittsburgh varchar(200), Toronto varchar(200), Philadelphia varchar(200),[New York] varchar(200), Montreal varchar(200), Boston varchar(200), Beersheba varchar(200), [Tel Aviv District] varchar(200), Eilat varchar(200), Haifa varchar(200), Nahariyya varchar(200), Jerusalem varchar(200) )
AS   [Test1]

-- select  * from ext_weather_description

--============= ext_wind_direction.csv =======================
-- DROP EXTERNAL TABLE ext_wind_direction

CREATE EXTERNAL TABLE ext_wind_direction
WITH 
(   
    LOCATION = '/demo/data/parquet/weather/ext_wind_direction.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/weather/wind_direction.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( [datetime] datetime, Vancouver float, Portland float, [San Francisco] float, Seattle float,[Los Angeles] float, [San Diego] float, [Las Vegas] float, Phoenix float, Albuquerque float, Denver float, [San Antonio] float, Dallas float, Houston float, [Kansas City] float, Minneapolis float, [Saint Louis] float, Chicago float, Nashville float, Indianapolis float, Atlanta float, Detroit float, Jacksonville float, Charlotte float, Miami float, Pittsburgh float, Toronto float, Philadelphia float,[New York] float, Montreal float, Boston float, Beersheba float, [Tel Aviv District] float, Eilat float, Haifa float, Nahariyya float, Jerusalem float )
AS   [Test1]

-- select  * from ext_wind_direction

--============= ext_wind_speed.csv =======================
-- DROP EXTERNAL TABLE ext_wind_speed

CREATE EXTERNAL TABLE ext_wind_speed
WITH 
(   
    LOCATION = '/demo/data/parquet/weather/ext_wind_speed.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/weather/wind_speed.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( [datetime] datetime, Vancouver float, Portland float, [San Francisco] float, Seattle float,[Los Angeles] float, [San Diego] float, [Las Vegas] float, Phoenix float, Albuquerque float, Denver float, [San Antonio] float, Dallas float, Houston float, [Kansas City] float, Minneapolis float, [Saint Louis] float, Chicago float, Nashville float, Indianapolis float, Atlanta float, Detroit float, Jacksonville float, Charlotte float, Miami float, Pittsburgh float, Toronto float, Philadelphia float,[New York] float, Montreal float, Boston float, Beersheba float, [Tel Aviv District] float, Eilat float, Haifa float, Nahariyya float, Jerusalem float )
AS   [Test1]

-- select  * from ext_wind_speed


---================================================
--============= ext_US_AQI.csv =======================
-- DROP EXTERNAL TABLE ext_US_AQI

CREATE EXTERNAL TABLE ext_US_AQI
WITH 
(   
    LOCATION = '/demo/data/parquet/aqi/ext_US_AQI.parquet',
    DATA_SOURCE = weatherDS,  
    FILE_FORMAT = ParquetFileFormat
) AS 
SELECT  *
FROM OPENROWSET
(    BULK '/demo/data/csv/aqi/US_AQI.csv'
,    FORMAT       = 'CSV'
,    DATA_SOURCE  = 'weatherDS'
,    firstrow=2
) 
WITH ( Id int,[CBSA Code] int,[Date] date,AQI int,Category varchar(50),[Defining Parameter] varchar(50),[Number of Sites Reporting] int,city_ascii varchar(50),state_id varchar(50),state_name varchar(50),lat float,lng float,[population] float,density float,timezone varchar(50))
AS   [Test1]

-- select  count(1) from ext_US_AQI


