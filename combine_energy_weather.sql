-- Kurt Emmanual Snell
-- kurt.snell@gmail.com
-- Created: 26 March 2025
-- Updated: 26 March 2025
-- MySQL query to combine energy and weather datasets

CREATE DATABASE IF NOT EXISTS energy_weather;

CREATE TABLE IF NOT EXISTS energy (
        dttm INT UNSIGNED,
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

CREATE TABLE IF NOT EXISTS weather (

);