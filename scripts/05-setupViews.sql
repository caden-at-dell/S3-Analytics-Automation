USE WideWorldImportersDW
GO

CREATE VIEW dbo.weather_view
--WITH SCHEMABINDING   (The option 'SCHEMABINDING' is not supported with external tables.)... hence indexed view is not possible ... hence statistics are not possible
AS
SELECT hum.DateOf, hum.City, hum.humidity, (((Temp.Temperature)-273.15)*1.8+32.00) as Temperature, Press.Pressure, Winddir.WindDirection, WindSpee.WindSpeed, Weather.WeatherDescription
FROM
(
	SELECT hum.DateOf, hum.City, hum.humidity
	FROM dbo.ext_humidity
	CROSS APPLY (
		VALUES 
		(ext_humidity.datetime, 'Albuquerque' ,ext_humidity.Albuquerque),
		(ext_humidity.datetime, 'Vancouver' ,ext_humidity.Vancouver),
		(ext_humidity.datetime, 'Portland' ,ext_humidity.Portland),
		(ext_humidity.datetime, 'Phoenix' ,ext_humidity.Phoenix),
		(ext_humidity.datetime, 'Denver' ,ext_humidity.Denver),
		(ext_humidity.datetime, 'Dallas' ,ext_humidity.Dallas),
		(ext_humidity.datetime, 'Houston' ,ext_humidity.Houston),
		(ext_humidity.datetime, 'Minneapolis' ,ext_humidity.Minneapolis),
		(ext_humidity.datetime, 'Chicago' ,ext_humidity.Chicago),
		(ext_humidity.datetime, 'Nashville' ,ext_humidity.Nashville),
		(ext_humidity.datetime, 'Indianapolis' ,ext_humidity.Indianapolis),
		(ext_humidity.datetime, 'Atlanta' ,ext_humidity.Atlanta),
		(ext_humidity.datetime, 'Detroit' ,ext_humidity.Detroit),
		(ext_humidity.datetime, 'Jacksonville' ,ext_humidity.Jacksonville),
		(ext_humidity.datetime, 'Charlotte' ,ext_humidity.Charlotte),
		(ext_humidity.datetime, 'Miami' ,ext_humidity.Miami),
		(ext_humidity.datetime, 'Toronto' ,ext_humidity.Toronto),
		(ext_humidity.datetime, 'Pittsburgh' ,ext_humidity.Pittsburgh),
		(ext_humidity.datetime, 'Philadelphia' ,ext_humidity.Philadelphia),
		(ext_humidity.datetime, 'Boston' ,ext_humidity.Boston),
		(ext_humidity.datetime, 'Montreal' ,ext_humidity.Montreal),
		(ext_humidity.datetime, 'San Antonio' ,ext_humidity.[San Antonio]),
		(ext_humidity.datetime, 'San Diego' ,ext_humidity.[San Diego]),
		(ext_humidity.datetime, 'San Francisco' ,ext_humidity.[San Francisco]),
		(ext_humidity.datetime, 'Kansas City' ,ext_humidity.[Kansas City]),
		(ext_humidity.datetime, 'Saint Louis' ,ext_humidity.[Saint Louis]),
		(ext_humidity.datetime, 'Las Vegas' ,ext_humidity.[Las Vegas]), 
		(ext_humidity.datetime, 'Los Angeles' ,ext_humidity.[Los Angeles]),
		(ext_humidity.datetime, 'New York' ,ext_humidity.[New York]), 
		(ext_humidity.datetime, 'Seattle' ,ext_humidity.Seattle)
	) hum(DateOf, City, humidity)
) as hum,
(
	SELECT Temp.DateOf, Temp.City, Temp.temperature
	FROM dbo.ext_temperature
	CROSS APPLY (
		VALUES (ext_temperature.datetime, 'Albuquerque' ,ext_temperature.Albuquerque), (ext_temperature.datetime, 'Vancouver' ,ext_temperature.Vancouver), (ext_temperature.datetime, 'Portland' ,ext_temperature.Portland), (ext_temperature.datetime, 'Phoenix' ,ext_temperature.Phoenix), (ext_temperature.datetime, 'Denver' ,ext_temperature.Denver), (ext_temperature.datetime, 'Dallas' ,ext_temperature.Dallas), (ext_temperature.datetime, 'Houston' ,ext_temperature.Houston), (ext_temperature.datetime, 'Minneapolis' ,ext_temperature.Minneapolis), (ext_temperature.datetime, 'Chicago' ,ext_temperature.Chicago), (ext_temperature.datetime, 'Nashville' ,ext_temperature.Nashville), (ext_temperature.datetime, 'Indianapolis' ,ext_temperature.Indianapolis), (ext_temperature.datetime, 'Atlanta' ,ext_temperature.Atlanta), (ext_temperature.datetime, 'Detroit' ,ext_temperature.Detroit), (ext_temperature.datetime, 'Jacksonville' ,ext_temperature.Jacksonville), (ext_temperature.datetime, 'Charlotte' ,ext_temperature.Charlotte), (ext_temperature.datetime, 'Miami' ,ext_temperature.Miami), (ext_temperature.datetime, 'Toronto' ,ext_temperature.Toronto), (ext_temperature.datetime, 'Pittsburgh' ,ext_temperature.Pittsburgh), (ext_temperature.datetime, 'Philadelphia' ,ext_temperature.Philadelphia), (ext_temperature.datetime, 'Boston' ,ext_temperature.Boston), (ext_temperature.datetime, 'Montreal' ,ext_temperature.Montreal), 
		(ext_temperature.datetime, 'San Antonio' ,ext_temperature.[San Antonio]),
		(ext_temperature.datetime, 'San Diego' ,ext_temperature.[San Diego]),
		(ext_temperature.datetime, 'San Francisco' ,ext_temperature.[San Francisco]),
		(ext_temperature.datetime, 'Kansas City' ,ext_temperature.[Kansas City]),
		(ext_temperature.datetime, 'Saint Louis' ,ext_temperature.[Saint Louis]),
		(ext_temperature.datetime, 'Las Vegas' ,ext_temperature.[Las Vegas]), 
		(ext_temperature.datetime, 'Los Angeles' ,ext_temperature.[Los Angeles]),
		(ext_temperature.datetime, 'New York' ,ext_temperature.[New York]), 
		(ext_temperature.datetime, 'Seattle' ,ext_temperature.Seattle)
	) Temp(DateOf, City, temperature)
) as Temp,
(
	SELECT press.DateOf, press.City, press.Pressure
	FROM dbo.ext_pressure
	CROSS APPLY (
		VALUES 
		(ext_pressure.datetime, 'Albuquerque' ,ext_pressure.Albuquerque),
		(ext_pressure.datetime, 'Vancouver' ,ext_pressure.Vancouver),
		(ext_pressure.datetime, 'Portland' ,ext_pressure.Portland),
		(ext_pressure.datetime, 'Phoenix' ,ext_pressure.Phoenix),
		(ext_pressure.datetime, 'Denver' ,ext_pressure.Denver),
		(ext_pressure.datetime, 'Dallas' ,ext_pressure.Dallas),
		(ext_pressure.datetime, 'Houston' ,ext_pressure.Houston),
		(ext_pressure.datetime, 'Minneapolis' ,ext_pressure.Minneapolis),
		(ext_pressure.datetime, 'Chicago' ,ext_pressure.Chicago),
		(ext_pressure.datetime, 'Nashville' ,ext_pressure.Nashville),
		(ext_pressure.datetime, 'Indianapolis' ,ext_pressure.Indianapolis),
		(ext_pressure.datetime, 'Atlanta' ,ext_pressure.Atlanta),
		(ext_pressure.datetime, 'Detroit' ,ext_pressure.Detroit),
		(ext_pressure.datetime, 'Jacksonville' ,ext_pressure.Jacksonville),
		(ext_pressure.datetime, 'Charlotte' ,ext_pressure.Charlotte),
		(ext_pressure.datetime, 'Miami' ,ext_pressure.Miami),
		(ext_pressure.datetime, 'Toronto' ,ext_pressure.Toronto),
		(ext_pressure.datetime, 'Pittsburgh' ,ext_pressure.Pittsburgh),
		(ext_pressure.datetime, 'Philadelphia' ,ext_pressure.Philadelphia),
		(ext_pressure.datetime, 'Boston' ,ext_pressure.Boston),
		(ext_pressure.datetime, 'Montreal' ,ext_pressure.Montreal),
		(ext_pressure.datetime, 'San Antonio' ,ext_pressure.[San Antonio]),
		(ext_pressure.datetime, 'San Diego' ,ext_pressure.[San Diego]),
		(ext_pressure.datetime, 'San Francisco' ,ext_pressure.[San Francisco]),
		(ext_pressure.datetime, 'Kansas City' ,ext_pressure.[Kansas City]),
		(ext_pressure.datetime, 'Saint Louis' ,ext_pressure.[Saint Louis]),
		(ext_pressure.datetime, 'Las Vegas' ,ext_pressure.[Las Vegas]), 
		(ext_pressure.datetime, 'Los Angeles' ,ext_pressure.[Los Angeles]),
		(ext_pressure.datetime, 'New York' ,ext_pressure.[New York]), 
		(ext_pressure.datetime, 'Seattle' ,ext_pressure.Seattle)
	) press(DateOf, City, Pressure)
) as Press,
	(
	SELECT weather.DateOf, weather.City, weather.WeatherDescription
	FROM dbo.ext_weather_description
	CROSS APPLY (
		VALUES 
		(ext_weather_description.datetime, 'Albuquerque' ,ext_weather_description.Albuquerque),
		(ext_weather_description.datetime, 'Vancouver' ,ext_weather_description.Vancouver),
		(ext_weather_description.datetime, 'Portland' ,ext_weather_description.Portland),
		(ext_weather_description.datetime, 'Phoenix' ,ext_weather_description.Phoenix),
		(ext_weather_description.datetime, 'Denver' ,ext_weather_description.Denver),
		(ext_weather_description.datetime, 'Dallas' ,ext_weather_description.Dallas),
		(ext_weather_description.datetime, 'Houston' ,ext_weather_description.Houston),
		(ext_weather_description.datetime, 'Minneapolis' ,ext_weather_description.Minneapolis),
		(ext_weather_description.datetime, 'Chicago' ,ext_weather_description.Chicago),
		(ext_weather_description.datetime, 'Nashville' ,ext_weather_description.Nashville),
		(ext_weather_description.datetime, 'Indianapolis' ,ext_weather_description.Indianapolis),
		(ext_weather_description.datetime, 'Atlanta' ,ext_weather_description.Atlanta),
		(ext_weather_description.datetime, 'Detroit' ,ext_weather_description.Detroit),
		(ext_weather_description.datetime, 'Jacksonville' ,ext_weather_description.Jacksonville),
		(ext_weather_description.datetime, 'Charlotte' ,ext_weather_description.Charlotte),
		(ext_weather_description.datetime, 'Miami' ,ext_weather_description.Miami),
		(ext_weather_description.datetime, 'Toronto' ,ext_weather_description.Toronto),
		(ext_weather_description.datetime, 'Pittsburgh' ,ext_weather_description.Pittsburgh),
		(ext_weather_description.datetime, 'Philadelphia' ,ext_weather_description.Philadelphia),
		(ext_weather_description.datetime, 'Boston' ,ext_weather_description.Boston),
		(ext_weather_description.datetime, 'Montreal' ,ext_weather_description.Montreal),
		(ext_weather_description.datetime, 'San Antonio' ,ext_weather_description.[San Antonio]),
		(ext_weather_description.datetime, 'San Diego' ,ext_weather_description.[San Diego]),
		(ext_weather_description.datetime, 'San Francisco' ,ext_weather_description.[San Francisco]),
		(ext_weather_description.datetime, 'Kansas City' ,ext_weather_description.[Kansas City]),
		(ext_weather_description.datetime, 'Saint Louis' ,ext_weather_description.[Saint Louis]),
		(ext_weather_description.datetime, 'Las Vegas' ,ext_weather_description.[Las Vegas]), 
		(ext_weather_description.datetime, 'Los Angeles' ,ext_weather_description.[Los Angeles]),
		(ext_weather_description.datetime, 'New York' ,ext_weather_description.[New York]), 
		(ext_weather_description.datetime, 'Seattle' ,ext_weather_description.Seattle)

	) weather(DateOf, City, WeatherDescription)
) as Weather,
(
	SELECT windspee.DateOf, windspee.City, windspee.WindSpeed
	FROM dbo.ext_wind_speed
	CROSS APPLY (
		VALUES 
		(ext_wind_speed.datetime, 'Albuquerque' ,ext_wind_speed.Albuquerque),
		(ext_wind_speed.datetime, 'Vancouver' ,ext_wind_speed.Vancouver),
		(ext_wind_speed.datetime, 'Portland' ,ext_wind_speed.Portland),
		(ext_wind_speed.datetime, 'Phoenix' ,ext_wind_speed.Phoenix),
		(ext_wind_speed.datetime, 'Denver' ,ext_wind_speed.Denver),
		(ext_wind_speed.datetime, 'Dallas' ,ext_wind_speed.Dallas),
		(ext_wind_speed.datetime, 'Houston' ,ext_wind_speed.Houston),
		(ext_wind_speed.datetime, 'Minneapolis' ,ext_wind_speed.Minneapolis),
		(ext_wind_speed.datetime, 'Chicago' ,ext_wind_speed.Chicago),
		(ext_wind_speed.datetime, 'Nashville' ,ext_wind_speed.Nashville),
		(ext_wind_speed.datetime, 'Indianapolis' ,ext_wind_speed.Indianapolis),
		(ext_wind_speed.datetime, 'Atlanta' ,ext_wind_speed.Atlanta),
		(ext_wind_speed.datetime, 'Detroit' ,ext_wind_speed.Detroit),
		(ext_wind_speed.datetime, 'Jacksonville' ,ext_wind_speed.Jacksonville),
		(ext_wind_speed.datetime, 'Charlotte' ,ext_wind_speed.Charlotte),
		(ext_wind_speed.datetime, 'Miami' ,ext_wind_speed.Miami),
		(ext_wind_speed.datetime, 'Toronto' ,ext_wind_speed.Toronto),
		(ext_wind_speed.datetime, 'Pittsburgh' ,ext_wind_speed.Pittsburgh),
		(ext_wind_speed.datetime, 'Philadelphia' ,ext_wind_speed.Philadelphia),
		(ext_wind_speed.datetime, 'Boston' ,ext_wind_speed.Boston),
		(ext_wind_speed.datetime, 'Montreal' ,ext_wind_speed.Montreal),
		(ext_wind_speed.datetime, 'San Antonio' ,ext_wind_speed.[San Antonio]),
		(ext_wind_speed.datetime, 'San Diego' ,ext_wind_speed.[San Diego]),
		(ext_wind_speed.datetime, 'San Francisco' ,ext_wind_speed.[San Francisco]),
		(ext_wind_speed.datetime, 'Kansas City' ,ext_wind_speed.[Kansas City]),
		(ext_wind_speed.datetime, 'Saint Louis' ,ext_wind_speed.[Saint Louis]),
		(ext_wind_speed.datetime, 'Las Vegas' ,ext_wind_speed.[Las Vegas]), 
		(ext_wind_speed.datetime, 'Los Angeles' ,ext_wind_speed.[Los Angeles]),
		(ext_wind_speed.datetime, 'New York' ,ext_wind_speed.[New York]), 
		(ext_wind_speed.datetime, 'Seattle' ,ext_wind_speed.Seattle)
	) windspee(DateOf, City, WindSpeed)
) as WindSpee,
(
	SELECT winddir.DateOf, winddir.City, winddir.WindDirection
	FROM dbo.ext_wind_direction
	CROSS APPLY (
		VALUES (ext_wind_direction.datetime, 'Albuquerque' ,ext_wind_direction.Albuquerque),(ext_wind_direction.datetime, 'Vancouver' ,ext_wind_direction.Vancouver),(ext_wind_direction.datetime, 'Portland' ,ext_wind_direction.Portland),(ext_wind_direction.datetime, 'Phoenix' ,ext_wind_direction.Phoenix),(ext_wind_direction.datetime, 'Denver' ,ext_wind_direction.Denver),(ext_wind_direction.datetime, 'Dallas' ,ext_wind_direction.Dallas),(ext_wind_direction.datetime, 'Houston' ,ext_wind_direction.Houston),(ext_wind_direction.datetime, 'Minneapolis' ,ext_wind_direction.Minneapolis),(ext_wind_direction.datetime, 'Chicago' ,ext_wind_direction.Chicago),(ext_wind_direction.datetime, 'Nashville' ,ext_wind_direction.Nashville),(ext_wind_direction.datetime, 'Indianapolis' ,ext_wind_direction.Indianapolis),(ext_wind_direction.datetime, 'Atlanta' ,ext_wind_direction.Atlanta),(ext_wind_direction.datetime, 'Detroit' ,ext_wind_direction.Detroit),(ext_wind_direction.datetime, 'Jacksonville' ,ext_wind_direction.Jacksonville),(ext_wind_direction.datetime, 'Charlotte' ,ext_wind_direction.Charlotte),(ext_wind_direction.datetime, 'Miami' ,ext_wind_direction.Miami),(ext_wind_direction.datetime, 'Toronto' ,ext_wind_direction.Toronto),(ext_wind_direction.datetime, 'Pittsburgh' ,ext_wind_direction.Pittsburgh),(ext_wind_direction.datetime, 'Philadelphia' ,ext_wind_direction.Philadelphia),(ext_wind_direction.datetime, 'Boston' ,ext_wind_direction.Boston),(ext_wind_direction.datetime, 'Montreal' ,ext_wind_direction.Montreal),
		(ext_wind_direction.datetime, 'San Antonio' ,ext_wind_direction.[San Antonio]),
		(ext_wind_direction.datetime, 'San Diego' ,ext_wind_direction.[San Diego]),
		(ext_wind_direction.datetime, 'San Francisco' ,ext_wind_direction.[San Francisco]),
		(ext_wind_direction.datetime, 'Kansas City' ,ext_wind_direction.[Kansas City]),
		(ext_wind_direction.datetime, 'Saint Louis' ,ext_wind_direction.[Saint Louis]),
		(ext_wind_direction.datetime, 'Las Vegas' ,ext_wind_direction.[Las Vegas]), 
		(ext_wind_direction.datetime, 'Los Angeles' ,ext_wind_direction.[Los Angeles]),
		(ext_wind_direction.datetime, 'New York' ,ext_wind_direction.[New York]), 
		(ext_wind_direction.datetime, 'Seattle' ,ext_wind_direction.Seattle)
	) winddir(DateOf, City, WindDirection)
) as Winddir
WHERE 
Hum.DateOf = Temp.DateOf AND Hum.DateOf = Press.DateOf AND Hum.DateOf = Winddir.DateOf AND Hum.DateOf = WindSpee.DateOf AND Hum.DateOf = Weather.DateOf
AND 
Hum.City = Temp.City AND Hum.City = Press.City AND Hum.City = Winddir.City AND Hum.City = WindSpee.City AND Hum.City = Weather.City
GO

-- select * from dbo.weather_view 

-- select top 10 * from dbo.weather_view 

CREATE VIEW dbo.city_attributes_view
AS
select tab2.City, tab1.state,  tab2.Country, tab2.Latitude, tab2.Longitude
from (
select distinct city, state from(
select ca.City,aqi.state_name as state, ca.Country, ca.Latitude, ca.Longitude 
from  ext_city_attributes ca
left join ext_US_AQI aqi
on ca.City  = aqi.city_ascii
) as a
where state is not null ) tab1
left join ext_city_attributes tab2
on tab1.City = tab2.City
GO

-- select top 5 * from city_attributes_view
--===============================
CREATE VIEW humidity_view
AS
SELECT hmd.DateOf, hmd.City, cav.State, hmd.Humidity
FROM  (
SELECT hum.DateOf, hum.City, hum.humidity
	FROM dbo.ext_humidity
	CROSS APPLY (
		VALUES 
		(ext_humidity.datetime, 'Albuquerque' ,ext_humidity.Albuquerque),
		(ext_humidity.datetime, 'Vancouver' ,ext_humidity.Vancouver),
		(ext_humidity.datetime, 'Portland' ,ext_humidity.Portland),
		(ext_humidity.datetime, 'Phoenix' ,ext_humidity.Phoenix),
		(ext_humidity.datetime, 'Denver' ,ext_humidity.Denver),
		(ext_humidity.datetime, 'Dallas' ,ext_humidity.Dallas),
		(ext_humidity.datetime, 'Houston' ,ext_humidity.Houston),
		(ext_humidity.datetime, 'Minneapolis' ,ext_humidity.Minneapolis),
		(ext_humidity.datetime, 'Chicago' ,ext_humidity.Chicago),
		(ext_humidity.datetime, 'Nashville' ,ext_humidity.Nashville),
		(ext_humidity.datetime, 'Indianapolis' ,ext_humidity.Indianapolis),
		(ext_humidity.datetime, 'Atlanta' ,ext_humidity.Atlanta),
		(ext_humidity.datetime, 'Detroit' ,ext_humidity.Detroit),
		(ext_humidity.datetime, 'Jacksonville' ,ext_humidity.Jacksonville),
		(ext_humidity.datetime, 'Charlotte' ,ext_humidity.Charlotte),
		(ext_humidity.datetime, 'Miami' ,ext_humidity.Miami),
		(ext_humidity.datetime, 'Toronto' ,ext_humidity.Toronto),
		(ext_humidity.datetime, 'Pittsburgh' ,ext_humidity.Pittsburgh),
		(ext_humidity.datetime, 'Philadelphia' ,ext_humidity.Philadelphia),
		(ext_humidity.datetime, 'Boston' ,ext_humidity.Boston),
		(ext_humidity.datetime, 'Montreal' ,ext_humidity.Montreal),
		(ext_humidity.datetime, 'San Antonio' ,ext_humidity.[San Antonio]),
		(ext_humidity.datetime, 'San Diego' ,ext_humidity.[San Diego]),
		(ext_humidity.datetime, 'San Francisco' ,ext_humidity.[San Francisco]),
		(ext_humidity.datetime, 'Kansas City' ,ext_humidity.[Kansas City]),
		(ext_humidity.datetime, 'Saint Louis' ,ext_humidity.[Saint Louis]),
		(ext_humidity.datetime, 'Las Vegas' ,ext_humidity.[Las Vegas]), 
		(ext_humidity.datetime, 'Los Angeles' ,ext_humidity.[Los Angeles]),
		(ext_humidity.datetime, 'New York' ,ext_humidity.[New York]), 
		(ext_humidity.datetime, 'Seattle' ,ext_humidity.Seattle)
) hum(DateOf, City, humidity)
) as hmd left join city_attributes_view cav 
on  hmd.City = cav.City 
WHERE cav.state is not null and hmd.humidity is not null
GO

-- select *  from humidity_view

-- drop view temperature_view
CREATE VIEW temperature_view
AS
SELECT tmp.DateOf, tmp.City, cav.State,tmp.temperature
FROM  (
SELECT Temp.DateOf, Temp.City, ((Temp.Temperature)-273.15) as temperature
	FROM dbo.ext_temperature
	CROSS APPLY (
		VALUES (ext_temperature.datetime, 'Albuquerque' ,ext_temperature.Albuquerque), (ext_temperature.datetime, 'Vancouver' ,ext_temperature.Vancouver), (ext_temperature.datetime, 'Portland' ,ext_temperature.Portland), (ext_temperature.datetime, 'Phoenix' ,ext_temperature.Phoenix), (ext_temperature.datetime, 'Denver' ,ext_temperature.Denver), (ext_temperature.datetime, 'Dallas' ,ext_temperature.Dallas), (ext_temperature.datetime, 'Houston' ,ext_temperature.Houston), (ext_temperature.datetime, 'Minneapolis' ,ext_temperature.Minneapolis), (ext_temperature.datetime, 'Chicago' ,ext_temperature.Chicago), (ext_temperature.datetime, 'Nashville' ,ext_temperature.Nashville), (ext_temperature.datetime, 'Indianapolis' ,ext_temperature.Indianapolis), (ext_temperature.datetime, 'Atlanta' ,ext_temperature.Atlanta), (ext_temperature.datetime, 'Detroit' ,ext_temperature.Detroit), (ext_temperature.datetime, 'Jacksonville' ,ext_temperature.Jacksonville), (ext_temperature.datetime, 'Charlotte' ,ext_temperature.Charlotte), (ext_temperature.datetime, 'Miami' ,ext_temperature.Miami), (ext_temperature.datetime, 'Toronto' ,ext_temperature.Toronto), (ext_temperature.datetime, 'Pittsburgh' ,ext_temperature.Pittsburgh), (ext_temperature.datetime, 'Philadelphia' ,ext_temperature.Philadelphia), (ext_temperature.datetime, 'Boston' ,ext_temperature.Boston), (ext_temperature.datetime, 'Montreal' ,ext_temperature.Montreal), 
		(ext_temperature.datetime, 'San Antonio' ,ext_temperature.[San Antonio]),
		(ext_temperature.datetime, 'San Diego' ,ext_temperature.[San Diego]),
		(ext_temperature.datetime, 'San Francisco' ,ext_temperature.[San Francisco]),
		(ext_temperature.datetime, 'Kansas City' ,ext_temperature.[Kansas City]),
		(ext_temperature.datetime, 'Saint Louis' ,ext_temperature.[Saint Louis]),
		(ext_temperature.datetime, 'Las Vegas' ,ext_temperature.[Las Vegas]), 
		(ext_temperature.datetime, 'Los Angeles' ,ext_temperature.[Los Angeles]),
		(ext_temperature.datetime, 'New York' ,ext_temperature.[New York]), 
		(ext_temperature.datetime, 'Seattle' ,ext_temperature.Seattle)
	) Temp(DateOf, City, temperature)
) as tmp left join city_attributes_view cav 
on  tmp.City = cav.City 
WHERE cav.state is not null and tmp.temperature is not null
GO

--select * from temperature_view
--GO
--=======================================
CREATE VIEW weather_description_view
AS
SELECT weather.DateOf, weather.City, cav.State,weather.WeatherDescription
FROM  (
SELECT weather.DateOf, weather.City, weather.WeatherDescription
	FROM dbo.ext_weather_description
	CROSS APPLY (
		VALUES 
		(ext_weather_description.datetime, 'Albuquerque' ,ext_weather_description.Albuquerque),	(ext_weather_description.datetime, 'Vancouver' ,ext_weather_description.Vancouver),	(ext_weather_description.datetime, 'Portland' ,ext_weather_description.Portland),		(ext_weather_description.datetime, 'Phoenix' ,ext_weather_description.Phoenix),		(ext_weather_description.datetime, 'Denver' ,ext_weather_description.Denver),		(ext_weather_description.datetime, 'Dallas' ,ext_weather_description.Dallas),
		(ext_weather_description.datetime, 'Houston' ,ext_weather_description.Houston),
		(ext_weather_description.datetime, 'Minneapolis' ,ext_weather_description.Minneapolis),
		(ext_weather_description.datetime, 'Chicago' ,ext_weather_description.Chicago),
		(ext_weather_description.datetime, 'Nashville' ,ext_weather_description.Nashville),
		(ext_weather_description.datetime, 'Indianapolis' ,ext_weather_description.Indianapolis),
		(ext_weather_description.datetime, 'Atlanta' ,ext_weather_description.Atlanta),
		(ext_weather_description.datetime, 'Detroit' ,ext_weather_description.Detroit),
		(ext_weather_description.datetime, 'Jacksonville' ,ext_weather_description.Jacksonville),
		(ext_weather_description.datetime, 'Charlotte' ,ext_weather_description.Charlotte),
		(ext_weather_description.datetime, 'Miami' ,ext_weather_description.Miami),
		(ext_weather_description.datetime, 'Toronto' ,ext_weather_description.Toronto),
		(ext_weather_description.datetime, 'Pittsburgh' ,ext_weather_description.Pittsburgh),
		(ext_weather_description.datetime, 'Philadelphia' ,ext_weather_description.Philadelphia),
		(ext_weather_description.datetime, 'Boston' ,ext_weather_description.Boston),
		(ext_weather_description.datetime, 'Montreal' ,ext_weather_description.Montreal),
		(ext_weather_description.datetime, 'San Antonio' ,ext_weather_description.[San Antonio]),
		(ext_weather_description.datetime, 'San Diego' ,ext_weather_description.[San Diego]),
		(ext_weather_description.datetime, 'San Francisco' ,ext_weather_description.[San Francisco]),
		(ext_weather_description.datetime, 'Kansas City' ,ext_weather_description.[Kansas City]),
		(ext_weather_description.datetime, 'Saint Louis' ,ext_weather_description.[Saint Louis]),
		(ext_weather_description.datetime, 'Las Vegas' ,ext_weather_description.[Las Vegas]), 
		(ext_weather_description.datetime, 'Los Angeles' ,ext_weather_description.[Los Angeles]),
		(ext_weather_description.datetime, 'New York' ,ext_weather_description.[New York]), 
		(ext_weather_description.datetime, 'Seattle' ,ext_weather_description.Seattle)
	) weather(DateOf, City, WeatherDescription)
) as weather left join city_attributes_view cav 
on  weather.City = cav.City 
WHERE cav.state is not null and weather.WeatherDescription is not null
GO
-- ====================================

CREATE VIEW wind_speed_view
AS
SELECT ws.DateOf, ws.City, cav.State,ws.WindSpeed
FROM  (
SELECT ws.DateOf, ws.City, ws.WindSpeed
	FROM dbo.ext_wind_speed
	CROSS APPLY (
		VALUES 
		(ext_wind_speed.datetime, 'Albuquerque' ,ext_wind_speed.Albuquerque),
		(ext_wind_speed.datetime, 'Vancouver' ,ext_wind_speed.Vancouver),
		(ext_wind_speed.datetime, 'Portland' ,ext_wind_speed.Portland),
		(ext_wind_speed.datetime, 'Phoenix' ,ext_wind_speed.Phoenix),
		(ext_wind_speed.datetime, 'Denver' ,ext_wind_speed.Denver),
		(ext_wind_speed.datetime, 'Dallas' ,ext_wind_speed.Dallas),
		(ext_wind_speed.datetime, 'Houston' ,ext_wind_speed.Houston),
		(ext_wind_speed.datetime, 'Minneapolis' ,ext_wind_speed.Minneapolis),
		(ext_wind_speed.datetime, 'Chicago' ,ext_wind_speed.Chicago),
		(ext_wind_speed.datetime, 'Nashville' ,ext_wind_speed.Nashville),
		(ext_wind_speed.datetime, 'Indianapolis' ,ext_wind_speed.Indianapolis),
		(ext_wind_speed.datetime, 'Atlanta' ,ext_wind_speed.Atlanta),
		(ext_wind_speed.datetime, 'Detroit' ,ext_wind_speed.Detroit),
		(ext_wind_speed.datetime, 'Jacksonville' ,ext_wind_speed.Jacksonville),
		(ext_wind_speed.datetime, 'Charlotte' ,ext_wind_speed.Charlotte),
		(ext_wind_speed.datetime, 'Miami' ,ext_wind_speed.Miami),
		(ext_wind_speed.datetime, 'Toronto' ,ext_wind_speed.Toronto),
		(ext_wind_speed.datetime, 'Pittsburgh' ,ext_wind_speed.Pittsburgh),
		(ext_wind_speed.datetime, 'Philadelphia' ,ext_wind_speed.Philadelphia),
		(ext_wind_speed.datetime, 'Boston' ,ext_wind_speed.Boston),
		(ext_wind_speed.datetime, 'Montreal' ,ext_wind_speed.Montreal),
		(ext_wind_speed.datetime, 'San Antonio' ,ext_wind_speed.[San Antonio]),
		(ext_wind_speed.datetime, 'San Diego' ,ext_wind_speed.[San Diego]),
		(ext_wind_speed.datetime, 'San Francisco' ,ext_wind_speed.[San Francisco]),
		(ext_wind_speed.datetime, 'Kansas City' ,ext_wind_speed.[Kansas City]),
		(ext_wind_speed.datetime, 'Saint Louis' ,ext_wind_speed.[Saint Louis]),
		(ext_wind_speed.datetime, 'Las Vegas' ,ext_wind_speed.[Las Vegas]), 
		(ext_wind_speed.datetime, 'Los Angeles' ,ext_wind_speed.[Los Angeles]),
		(ext_wind_speed.datetime, 'New York' ,ext_wind_speed.[New York]), 
		(ext_wind_speed.datetime, 'Seattle' ,ext_wind_speed.Seattle)
	) ws(DateOf, City, WindSpeed)
) as ws left join city_attributes_view cav 
on  ws.City = cav.City 
WHERE cav.state is not null and ws.WindSpeed is not null
GO

-- select * from wind_speed_view

