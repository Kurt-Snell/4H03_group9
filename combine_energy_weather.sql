-- Kurt Emmanual Snell
-- kurt.snell@gmail.com
-- Created: 26 March 2025
-- Updated: 26 March 2025
-- MySQL query to combine energy and weather datasets

-- Empty database
CREATE DATABASE IF NOT EXISTS energy_weather;
USE energy_weather;

-- Energy table
CREATE TABLE IF NOT EXISTS energy (
        dttm LONGTEXT,
        generation_biomass INT UNSIGNED,
        generation_fossil_brown_coal_lignite INT UNSIGNED,
        generation_fossil_coal_derived_gas INT UNSIGNED,
        generation_fossil_gas INT UNSIGNED,
        generation_fossil_hard_coal INT UNSIGNED,
        generation_fossil_oil INT UNSIGNED,
        generation_fossil_oil_shale INT UNSIGNED,
        generation_fossil_peat INT UNSIGNED,
        generation_geothermal INT UNSIGNED,
        generation_hydro_pumped_storage_aggregated INT UNSIGNED,
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
        forecast_wind_offshore_eday_ahead INT UNSIGNED,
        forecast_wind_onshore_day_ahead INT UNSIGNED,
        total_load_forecast INT UNSIGNED,
        total_load_actual INT UNSIGNED,
        price_day_ahead FLOAT,
        price_actual FLOAT,
        PRIMARY KEY(dttm)
);

-- Weather table
CREATE TABLE IF NOT EXISTS weather (
        dttm LONGTEXT,
        city_name VARCHAR(255),
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
        weather_id INT UNSIGNED,
        weather_main VARCHAR(255),
        weather_description VARCHAR(255),
        weather_icon VARCHAR(255),
        PRIMArY KEY(dttm)
);

-- Import energy data
-- LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/energy_dataset.csv' INTO TABLE energy_weather.energy;

-- Import energy data
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/weather_features.csv' INTO TABLE energy_weather.weather;

-- Combine tables into one 


SHOW VARIABLES LIKE "secure_file_priv";


