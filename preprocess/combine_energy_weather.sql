-- Kurt Emmanual Snell
-- kurt.snell@gmail.com
-- Created: 26 March 2025
-- Updated: 26 March 2025
-- MySQL query to combine energy and weather datasets

-- Empty database
DROP DATABASE IF EXISTS energy_weather;
CREATE DATABASE IF NOT EXISTS energy_weather;
USE energy_weather;

-- Energy table
CREATE TABLE IF NOT EXISTS energy (
        dttme VARCHAR(255),
        generation_biomass INT UNSIGNED,
        generation_fossil_brown_coal_lignite INT UNSIGNED,
        generation_fossil_coal_derived_gas INT UNSIGNED,
        generation_fossil_gas INT UNSIGNED,
        generation_fossil_hard_coal INT UNSIGNED,
        generation_fossil_oil INT UNSIGNED,
        generation_fossil_oil_shale INT UNSIGNED,
        generation_fossil_peat INT UNSIGNED,
        generation_geothermal INT UNSIGNED,
        generation_hydro_pumped_storage_consumption INT UNSIGNED,
        generation_hydro_run_of_river_and_poundage INT UNSIGNED,
        generation_hydro_water_reservoir INT UNSIGNED,
        generation_marine INT UNSIGNED,
        generation_nuclear INT UNSIGNED,
        generation_other INT UNSIGNED,
        generation_other_renewable INT UNSIGNED,
        generation_solar INT UNSIGNED,
        generation_waste INT UNSIGNED,
        generation_wind_offshore INT UNSIGNED,
        generation_wind_onshore INT UNSIGNED,
        forecast_solar_day_ahead INT UNSIGNED,
        forecast_wind_onshore_day_ahead INT UNSIGNED,
        total_load_forecast INT UNSIGNED,
        total_load_actual INT UNSIGNED,
        price_day_ahead FLOAT,
        price_actual FLOAT,
        PRIMARY KEY(dttme)
);

-- Weather table for Valencia
CREATE TABLE IF NOT EXISTS weather_valencia (
        dttmw VARCHAR(255),
        temp FLOAT,
        temp_min FLOAT,
        temp_max FLOAT,
        pressure INT UNSIGNED,
        humidity INT UNSIGNED,
        wind_speed INT UNSIGNED,
        wind_deg INT UNSIGNED,
        rain_1h INT UNSIGNED,
        rain_3h INT UNSIGNED,
        snow_3h INT UNSIGNED,
        clouds_all INT UNSIGNED,
        weather_id VARCHAR(255),
        weather_main VARCHAR(255),
        weather_description VARCHAR(255),
        weather_icon VARCHAR(255),
        PRIMARY KEY(dttmw)
);

-- Weather table for Madrid
CREATE TABLE IF NOT EXISTS weather_madrid (
        dttmw VARCHAR(255),
        temp FLOAT,
        temp_min FLOAT,
        temp_max FLOAT,
        pressure INT UNSIGNED,
        humidity INT UNSIGNED,
        wind_speed INT UNSIGNED,
        wind_deg INT UNSIGNED,
        rain_1h INT UNSIGNED,
        rain_3h INT UNSIGNED,
        snow_3h INT UNSIGNED,
        clouds_all INT UNSIGNED,
        weather_id VARCHAR(255),
        weather_main VARCHAR(255),
        weather_description VARCHAR(255),
        weather_icon VARCHAR(255),
        PRIMARY KEY(dttmw)
);

-- Weather table for Barcelona
CREATE TABLE IF NOT EXISTS weather_barcelona (
        dttmw VARCHAR(255),
        temp FLOAT,
        temp_min FLOAT,
        temp_max FLOAT,
        pressure INT UNSIGNED,
        humidity INT UNSIGNED,
        wind_speed INT UNSIGNED,
        wind_deg INT UNSIGNED,
        rain_1h INT UNSIGNED,
        rain_3h INT UNSIGNED,
        snow_3h INT UNSIGNED,
        clouds_all INT UNSIGNED,
        weather_id VARCHAR(255),
        weather_main VARCHAR(255),
        weather_description VARCHAR(255),
        weather_icon VARCHAR(255),
        PRIMARY KEY(dttmw)
);

-- Weather table for Bilbao
CREATE TABLE IF NOT EXISTS weather_bilbao (
        dttmw VARCHAR(255),
        temp FLOAT,
        temp_min FLOAT,
        temp_max FLOAT,
        pressure INT UNSIGNED,
        humidity INT UNSIGNED,
        wind_speed INT UNSIGNED,
        wind_deg INT UNSIGNED,
        rain_1h INT UNSIGNED,
        rain_3h INT UNSIGNED,
        snow_3h INT UNSIGNED,
        clouds_all INT UNSIGNED,
        weather_id VARCHAR(255),
        weather_main VARCHAR(255),
        weather_description VARCHAR(255),
        weather_icon VARCHAR(255),
        PRIMARY KEY(dttmw)
);

-- Weather table for Seville
CREATE TABLE IF NOT EXISTS weather_seville (
        dttmw VARCHAR(255),
        temp FLOAT,
        temp_min FLOAT,
        temp_max FLOAT,
        pressure INT UNSIGNED,
        humidity INT UNSIGNED,
        wind_speed INT UNSIGNED,
        wind_deg INT UNSIGNED,
        rain_1h INT UNSIGNED,
        rain_3h INT UNSIGNED,
        snow_3h INT UNSIGNED,
        clouds_all INT UNSIGNED,
        weather_id VARCHAR(255),
        weather_main VARCHAR(255),
        weather_description VARCHAR(255),
        weather_icon VARCHAR(255),
        PRIMARY KEY(dttmw)
);

-- Import energy data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/energy_dataset.csv' INTO TABLE energy_weather.energy
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
    dttme,
    generation_biomass,
    generation_fossil_brown_coal_lignite,
    generation_fossil_coal_derived_gas,
    generation_fossil_gas,
    generation_fossil_hard_coal,
    generation_fossil_oil,
    generation_fossil_oil_shale,
    generation_fossil_peat,
    generation_geothermal,
    generation_hydro_pumped_storage_consumption,
    generation_hydro_run_of_river_and_poundage,
    generation_hydro_water_reservoir,
    generation_marine,
    generation_nuclear,
    generation_other,
    generation_other_renewable,
    generation_solar,
    generation_waste,
    generation_wind_offshore,
    generation_wind_onshore,
    forecast_solar_day_ahead,
    forecast_wind_onshore_day_ahead,
    total_load_forecast,
    total_load_actual,
    price_day_ahead,
    price_actual
);

-- Import weather data for Valencia
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weather_features_Valencia.csv' INTO TABLE energy_weather.weather_valencia
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	dttmw,
    temp,
    temp_min,
    temp_max,
    pressure,
    humidity,
    wind_speed,
    wind_deg,
    rain_1h,
    rain_3h,
    snow_3h,
    clouds_all,
    weather_id,
    weather_main,
    weather_description,
    weather_icon
);

-- Import weather data for Madrid
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weather_features_Madrid.csv' INTO TABLE energy_weather.weather_madrid
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	dttmw,
    temp,
    temp_min,
    temp_max,
    pressure,
    humidity,
    wind_speed,
    wind_deg,
    rain_1h,
    rain_3h,
    snow_3h,
    clouds_all,
    weather_id,
    weather_main,
    weather_description,
    weather_icon
);

-- Import weather data for Barcelona
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weather_features_Barcelona.csv' INTO TABLE energy_weather.weather_barcelona
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	dttmw,
    temp,
    temp_min,
    temp_max,
    pressure,
    humidity,
    wind_speed,
    wind_deg,
    rain_1h,
    rain_3h,
    snow_3h,
    clouds_all,
    weather_id,
    weather_main,
    weather_description,
    weather_icon
);

-- Import weather data for Bilbao
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weather_features_Bilbao.csv' INTO TABLE energy_weather.weather_bilbao
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	dttmw,
    temp,
    temp_min,
    temp_max,
    pressure,
    humidity,
    wind_speed,
    wind_deg,
    rain_1h,
    rain_3h,
    snow_3h,
    clouds_all,
    weather_id,
    weather_main,
    weather_description,
    weather_icon
);

-- Import weather data for Seville
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weather_features_Seville.csv' INTO TABLE energy_weather.weather_seville
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 LINES
(
	dttmw,
    temp,
    temp_min,
    temp_max,
    pressure,
    humidity,
    wind_speed,
    wind_deg,
    rain_1h,
    rain_3h,
    snow_3h,
    clouds_all,
    weather_id,
    weather_main,
    weather_description,
    weather_icon
);

CREATE TABLE valencia AS SELECT * FROM weather_valencia INNER JOIN energy ON weather_valencia.dttmw=energy.dttme;
SELECT "dttm", "temp", "temp_min", "temp_max", "pressure", "humidity", "wind_speed", "wind_deg", "rain_1h", "rain_3h", 
"snow_3h", "clouds_all", "weather_id", "weather_main", "weather_description", "weather_icon", "dttm", "generation_biomass",
"generation_fossil_brown_coal_lignite", "generation_fossil_coal_derived_gas", "generation_fossil_gas", "generation_fossil_hard_coal",
"generation_fossil_oil", "generation_fossil_oil_shale", "generation_fossil_peat", "generation_geothermal", 
"generation_hydro_pumped_storage_consumption", "generation_hydro_run_of_river_and_poundage", "generation_hydro_water_reservoir", 
"generation_marine", "generation_nuclear", "generation_other", "generation_other_renewable", "generation_solar", "generation_waste", 
"generation_wind_offshore", "generation_wind_onshore", "forecast_solar_day_ahead", "forecast_wind_onshore_day_ahead", 
"total_load_forecast", "total_load_actual", "price_day_ahead", "price_actual"
UNION ALL
SELECT * FROM valencia
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/valencia.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

CREATE TABLE madrid AS SELECT * FROM weather_madrid INNER JOIN energy ON weather_madrid.dttmw=energy.dttme;
SELECT "dttm", "temp", "temp_min", "temp_max", "pressure", "humidity", "wind_speed", "wind_deg", "rain_1h", "rain_3h", 
"snow_3h", "clouds_all", "weather_id", "weather_main", "weather_description", "weather_icon", "dttm", "generation_biomass",
"generation_fossil_brown_coal_lignite", "generation_fossil_coal_derived_gas", "generation_fossil_gas", "generation_fossil_hard_coal",
"generation_fossil_oil", "generation_fossil_oil_shale", "generation_fossil_peat", "generation_geothermal", 
"generation_hydro_pumped_storage_consumption", "generation_hydro_run_of_river_and_poundage", "generation_hydro_water_reservoir", 
"generation_marine", "generation_nuclear", "generation_other", "generation_other_renewable", "generation_solar", "generation_waste", 
"generation_wind_offshore", "generation_wind_onshore", "forecast_solar_day_ahead", "forecast_wind_onshore_day_ahead", 
"total_load_forecast", "total_load_actual", "price_day_ahead", "price_actual"
UNION ALL
SELECT * FROM madrid
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/madrid.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

CREATE TABLE barcelona AS SELECT * FROM weather_barcelona INNER JOIN energy ON weather_barcelona.dttmw=energy.dttme;
SELECT "dttm", "temp", "temp_min", "temp_max", "pressure", "humidity", "wind_speed", "wind_deg", "rain_1h", "rain_3h", 
"snow_3h", "clouds_all", "weather_id", "weather_main", "weather_description", "weather_icon", "dttm", "generation_biomass",
"generation_fossil_brown_coal_lignite", "generation_fossil_coal_derived_gas", "generation_fossil_gas", "generation_fossil_hard_coal",
"generation_fossil_oil", "generation_fossil_oil_shale", "generation_fossil_peat", "generation_geothermal", 
"generation_hydro_pumped_storage_consumption", "generation_hydro_run_of_river_and_poundage", "generation_hydro_water_reservoir", 
"generation_marine", "generation_nuclear", "generation_other", "generation_other_renewable", "generation_solar", "generation_waste", 
"generation_wind_offshore", "generation_wind_onshore", "forecast_solar_day_ahead", "forecast_wind_onshore_day_ahead", 
"total_load_forecast", "total_load_actual", "price_day_ahead", "price_actual"
UNION ALL
SELECT * FROM barcelona
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/barcelona.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

CREATE TABLE bilbao AS SELECT * FROM weather_bilbao INNER JOIN energy ON weather_bilbao.dttmw=energy.dttme;
SELECT "dttm", "temp", "temp_min", "temp_max", "pressure", "humidity", "wind_speed", "wind_deg", "rain_1h", "rain_3h", 
"snow_3h", "clouds_all", "weather_id", "weather_main", "weather_description", "weather_icon", "dttm", "generation_biomass",
"generation_fossil_brown_coal_lignite", "generation_fossil_coal_derived_gas", "generation_fossil_gas", "generation_fossil_hard_coal",
"generation_fossil_oil", "generation_fossil_oil_shale", "generation_fossil_peat", "generation_geothermal", 
"generation_hydro_pumped_storage_consumption", "generation_hydro_run_of_river_and_poundage", "generation_hydro_water_reservoir", 
"generation_marine", "generation_nuclear", "generation_other", "generation_other_renewable", "generation_solar", "generation_waste", 
"generation_wind_offshore", "generation_wind_onshore", "forecast_solar_day_ahead", "forecast_wind_onshore_day_ahead", 
"total_load_forecast", "total_load_actual", "price_day_ahead", "price_actual"
UNION ALL
SELECT * FROM bilbao
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/bilbao.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

CREATE TABLE seville AS SELECT * FROM weather_seville INNER JOIN energy ON weather_seville.dttmw=energy.dttme;
SELECT "dttm", "temp", "temp_min", "temp_max", "pressure", "humidity", "wind_speed", "wind_deg", "rain_1h", "rain_3h", 
"snow_3h", "clouds_all", "weather_id", "weather_main", "weather_description", "weather_icon", "dttm", "generation_biomass",
"generation_fossil_brown_coal_lignite", "generation_fossil_coal_derived_gas", "generation_fossil_gas", "generation_fossil_hard_coal",
"generation_fossil_oil", "generation_fossil_oil_shale", "generation_fossil_peat", "generation_geothermal", 
"generation_hydro_pumped_storage_consumption", "generation_hydro_run_of_river_and_poundage", "generation_hydro_water_reservoir", 
"generation_marine", "generation_nuclear", "generation_other", "generation_other_renewable", "generation_solar", "generation_waste", 
"generation_wind_offshore", "generation_wind_onshore", "forecast_solar_day_ahead", "forecast_wind_onshore_day_ahead", 
"total_load_forecast", "total_load_actual", "price_day_ahead", "price_actual"
UNION ALL
SELECT * FROM seville
INTO OUTFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/seville.csv'
FIELDS TERMINATED BY ','
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\n';

-- Run this query to find your MySQL Server Upload directory (you may have to switch "\" to "/")
-- SHOW VARIABLES LIKE "secure_file_priv";