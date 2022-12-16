--Use cases Examples
--===========================================================================
-- DATE_BUCKET
--===========================================================================
select * from  temperature_view 

-- get avg Daily temperature
select DATE_BUCKET(DAY,1, DateOf) dayTemp, City, state, 
avg(temperature) avgDailyTemp 
from temperature_view
GROUP BY DATE_BUCKET(DAY,1, DateOf), City, state
ORDER BY dayTemp asc

-- get avg monthly temperature
select DATE_BUCKET(MONTH,1, DateOf) dayTemp, City, state, 
avg(temperature) avgMonthlyTemp from temperature_view
GROUP BY DATE_BUCKET(MONTH,1, DateOf), City, state
--HAVING City = 'Dallas'

-- the number of customers for each week from my Invoice table
SELECT DATE_BUCKET(week,1, InvoiceDate) as InvoiceWeek, 
    COUNT(CustomerId) as CustomerCount
  FROM WideWorldImporters.Sales.Invoices
  GROUP BY DATE_BUCKET(week,1, InvoiceDate)
  ORDER BY InvoiceWeek

--===========================================================================
--GREATEST / LEAST
--===========================================================================

select *  from ext_temperature
where datetime = '2012-10-01 13:00:00.000'

-- Find greatest and least temprature on date '2012-10-01 13:00:00.000' across  cities
select datetime,
(GREATEST(Vancouver, Portland, [San Francisco], Seattle,[Los Angeles], [San Diego], [Las Vegas], Phoenix, Albuquerque, Denver, [San Antonio], Dallas, Houston, [Kansas City], Minneapolis, [Saint Louis], Chicago, Nashville, Indianapolis, Atlanta, Detroit, Jacksonville, Charlotte , Miami , Pittsburgh , Toronto , Philadelphia ,[New York] , Montreal , Boston , Beersheba , [Tel Aviv District] , Eilat , Haifa , Nahariyya , Jerusalem)-273.15) HighTemp ,
(LEAST(Vancouver, Portland, [San Francisco], Seattle,[Los Angeles], [San Diego], [Las Vegas], Phoenix, Albuquerque, Denver, [San Antonio], Dallas, Houston, [Kansas City], Minneapolis, [Saint Louis], Chicago, Nashville, Indianapolis, Atlanta, Detroit, Jacksonville, Charlotte , Miami , Pittsburgh , Toronto , Philadelphia ,[New York] , Montreal , Boston , Beersheba , [Tel Aviv District] , Eilat , Haifa , Nahariyya , Jerusalem)-273.15) LowTemp 
from ext_temperature
where datetime = '2012-10-01 13:00:00.000'

declare @requestDate datetime = '2012-10-01 13:00:00.000'
SELECT HighTemp.datetime tempType , HighTemp.HighestTemp temp, TempUnipivot.City, 'Highest Temprature' TempType FROM 
(SELECT [datetime], GREATEST(Vancouver, Portland, [San Francisco], Seattle,[Los Angeles], [San Diego], [Las Vegas], Phoenix, Albuquerque, Denver, [San Antonio], Dallas, Houston, [Kansas City], Minneapolis, [Saint Louis], Chicago, Nashville, Indianapolis, Atlanta, Detroit, Jacksonville, Charlotte , Miami , Pittsburgh , Toronto , Philadelphia ,[New York] , Montreal , Boston , Beersheba , [Tel Aviv District] , Eilat , Haifa , Nahariyya , Jerusalem) AS HighestTemp
  FROM ext_temperature ) HighTemp INNER JOIN 
(SELECT [datetime],City,Temperature FROM ext_temperature
	  UNPIVOT ( Temperature FOR City IN (Vancouver, Portland, [San Francisco], Seattle,[Los Angeles], [San Diego], [Las Vegas], Phoenix, Albuquerque, Denver, [San Antonio], Dallas, Houston, [Kansas City], Minneapolis, [Saint Louis], Chicago, Nashville, Indianapolis, Atlanta, Detroit, Jacksonville, Charlotte , Miami , Pittsburgh , Toronto , Philadelphia ,[New York] , Montreal , Boston , Beersheba , [Tel Aviv District] , Eilat , Haifa , Nahariyya , Jerusalem)
	  ) AS CityTemp ) TempUnipivot
ON HighTemp.HighestTemp = TempUnipivot.Temperature
WHERE HighTemp.datetime = TempUnipivot.datetime
AND TempUnipivot.datetime = @requestDate
UNION
SELECT LowTemp.datetime tempType , LowTemp.LowesttTemp temp, TempUnipivot.City, 'Lowest Temprature' TempType FROM 
(SELECT [datetime], LEAST(Vancouver, Portland, [San Francisco], Seattle,[Los Angeles], [San Diego], [Las Vegas], Phoenix, Albuquerque, Denver, [San Antonio], Dallas, Houston, [Kansas City], Minneapolis, [Saint Louis], Chicago, Nashville, Indianapolis, Atlanta, Detroit, Jacksonville, Charlotte , Miami , Pittsburgh , Toronto , Philadelphia ,[New York] , Montreal , Boston , Beersheba , [Tel Aviv District] , Eilat , Haifa , Nahariyya , Jerusalem) AS LowesttTemp
  FROM ext_temperature ) LowTemp INNER JOIN 
(SELECT [datetime],City,Temperature FROM ext_temperature
	  UNPIVOT ( Temperature FOR City IN (Vancouver, Portland, [San Francisco], Seattle,[Los Angeles], [San Diego], [Las Vegas], Phoenix, Albuquerque, Denver, [San Antonio], Dallas, Houston, [Kansas City], Minneapolis, [Saint Louis], Chicago, Nashville, Indianapolis, Atlanta, Detroit, Jacksonville, Charlotte , Miami , Pittsburgh , Toronto , Philadelphia ,[New York] , Montreal , Boston , Beersheba , [Tel Aviv District] , Eilat , Haifa , Nahariyya , Jerusalem)
	  ) AS CityTemp ) TempUnipivot
ON LowTemp.LowesttTemp = TempUnipivot.Temperature
WHERE LowTemp.datetime = TempUnipivot.datetime
AND TempUnipivot.datetime = @requestDate
GO

/*
SELECT [datetime],City,Temperature
  FROM ext_temperature
  UNPIVOT ( Temperature FOR City IN (Vancouver, Portland, [San Francisco], Seattle,[Los Angeles], [San Diego], [Las Vegas], Phoenix, Albuquerque, Denver, [San Antonio], Dallas, Houston, [Kansas City], Minneapolis, [Saint Louis], Chicago, Nashville, Indianapolis, Atlanta, Detroit, Jacksonville, Charlotte , Miami , Pittsburgh , Toronto , Philadelphia ,[New York] , Montreal , Boston , Beersheba , [Tel Aviv District] , Eilat , Haifa , Nahariyya , Jerusalem)
  ) AS CityTemp
GO
*/

--===========================================================================
--GENERATE_SERIES
--===========================================================================
-- generate test data
WITH series AS (
    SELECT value as seriesId FROM GENERATE_SERIES(1,1000)
)
select top 100 'employee'+(convert (varchar(10),seriesId)) from series

-- finding first occurence of a charector position in given string
DECLARE @S VARCHAR(8000) = 'Aarrrgggh!';
SELECT value, s as charac 
FROM (
     SELECT value=1, s=LEFT(@S, 1) UNION ALL
     SELECT value, CASE WHEN SUBSTRING(@S, value-1, 1) <> SUBSTRING(@S, value, 1) 
	 THEN SUBSTRING(@S, value, 1) END 
     FROM GENERATE_SERIES(1, 100)
     WHERE value BETWEEN 2 AND LEN(@S)
) a
WHERE s IS NOT NULL;


SELECT CONVERT(DATE, (DATE_BUCKET(DAY,1, DATEADD(DAY,[value],'2013-01-01')))) AS genDate
FROM GENERATE_SERIES(0,365,1);

SELECT [Order Date Key], COUNT([Order Date Key]) AS DailySales
  FROM [WideWorldImportersDW].[Fact].[Order]
  GROUP BY [Order Date Key]
  ORDER BY DailySales asc

select gen.genDate, COUNT(fo.[Order Date Key]) orderCount 
FROM ( SELECT CONVERT(DATE, (DATE_BUCKET(DAY,1, DATEADD(DAY,[value],'2013-01-01')))) AS genDate
FROM GENERATE_SERIES(0,365,1)
) gen LEFT JOIN [Fact].[Order] fo ON gen.genDate = fo.[Order Date Key]
GROUP BY gen.genDate
HAVING COUNT(fo.[Order Date Key]) = 0
ORDER BY gen.genDate asc
--===========================================================================
-- STRING_SPLIT
--===========================================================================
select * FROM Dimension.Customer



select value as FirstName, c.[Primary Contact], c.Customer FROM Dimension.Customer c
CROSS APPLY STRING_SPLIT(c.[Primary Contact], ' ', 1)
WHERE ordinal = 1 

--To extract firstname, city of customers in customer table. 
select d.[Primary Contact], d.Customer, d.FirstName, value City from (
	select c2.[Primary Contact], c2.Customer, c2.FirstName, value c2v, ordinal c2o from (
		select b.[Primary Contact], b.Customer, b.FirstName, value bv, ordinal bo
			from ( select * from ( select value as FirstName, c.[Primary Contact], c.Customer FROM Dimension.Customer c
								CROSS APPLY STRING_SPLIT(c.[Primary Contact], ' ', 1) WHERE ordinal = 1 ) ns
					WHERE Customer <> 'Unknown' AND Customer not like '%Head Office%' ) b
					CROSS APPLY STRING_SPLIT(b.Customer, '(', 1) WHERE ordinal = 2 ) c2
			CROSS APPLY STRING_SPLIT(bv, ')', 1) WHERE ordinal = 1 ) d
		CROSS APPLY STRING_SPLIT(c2v, ',', 1) 
WHERE ordinal = 1


--===========================================================================
--FIRST_VALUE/ LAST_VALUE
--===========================================================================

select * from temperature_view

-- Least Hot city based on monthly average temprature
select DATE_BUCKET(MONTH,1, DateOf) recordDate, City, 
avg(temperature) avgMonthlyTemp ,
FIRST_VALUE(city) OVER (ORDER BY avg(temperature) ASC) AS LeastHot
from temperature_view tv
GROUP BY DATE_BUCKET(MONTH,1, DateOf), City
ORDER BY recordDate asc

select DATE_BUCKET(YEAR,1, DateOf) recordDate, City, avg(temperature) avgYearlyTemp ,
FIRST_VALUE(city) OVER (ORDER BY avg(temperature) ASC) AS LeastHot
from temperature_view tv
GROUP BY DATE_BUCKET(YEAR,1, DateOf), City

-- Most Hot city based on monthly average temprature
select DATE_BUCKET(MONTH,1, DateOf) recordDate, City, avg(temperature) avgMonthlyTemp ,
Last_VALUE(city) OVER (ORDER BY avg(temperature) DESC) AS MostHot
from temperature_view tv
GROUP BY DATE_BUCKET(MONTH,1, DateOf), City