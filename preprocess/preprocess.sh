#!/usr/bin/bash

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 26 March 2025
# Updated: 3 April 2025

# Bash wrapper to preprocess all data
# In the current working directory, call `sh preprocess.sh`

# Pause running in terminal function
function pause(){
   read -p "$*"
}

# Split weather_features.csv into component cities
perl csv_split_city.pl ../data/original/weather_features.csv
mv ../data/original/weather_features_* ../data/cities/

# Manually run macro to remove duplicated datetime entries and rows containing blanks
pause 'Clean the CSV files using the clean_csv() macro in the clean_csv.bas module and then press [Enter] key to continue...'

# Combine data in as a MySQL database
sh aux_func/cp_sql_up.sh ../data/original/energy_dataset.csv
sh aux_func/cp_sql_up.sh ../data/cities/weather_features_\*

pause 'Inner join data as a database in MySQL Workbench using the combine_energy_weather.sql file and then press [Enter] key to continue...'

sh aux_func/cp_sql_dn.sh valencia.csv ../data/combo/
sh aux_func/cp_sql_dn.sh madrid.csv ../data/combo/
sh aux_func/cp_sql_dn.sh barcelona.csv ../data/combo/
sh aux_func/cp_sql_dn.sh bilbao.csv ../data/combo/
sh aux_func/cp_sql_dn.sh seville.csv ../data/combo/

# Remove bad fields
pause 'Remove fields using file and then press [Enter] key to continue...'

# Add year, month, day, hour info into combined tables
for city in valencia madrid barcelona bilbao seville ; do
    perl csv_split_date.pl ../data/combo/$city.csv > ../data/datetime/${city}_time.csv
done

# Get average data
for city in valencia madrid barcelona bilbao seville ; do
    perl avg_day.pl ../data/datetime/${city}_time.csv > ../data/daily/${city}_daily_average.csv
done

# Get relative data
for city in valencia madrid barcelona bilbao seville ; do
    perl rel_gen.pl ../data/daily/${city}_daily_average.csv > ../data/percent/${city}_percent.csv
done