#!/usr/bin/perl

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 6 April 2025
# Updated: 6 April 2025

# Perl script to dump headers of a CSV
# In the current working directory, call `perl avg_day.pl "filename.csv"`

# Compatibility control
use warnings;
use strict;
use 5.36.1;

# Inputs are file name and column number to be parsed
my $fl = $ARGV[0];

# Open file for processing
open(my $csv, '<', $fl) or die "Cannot open file \'$fl\': $!";

# Get headers
my $first = <$csv>;
print "year,month,day,temp,pressure,humidity,wind_speed,wind_direction,clouds,generation_biomass,generation_fossil_brown_coal_lignite,generation_fossil_coal_derived_gas,generation_fossil_gas,generation_fossil_hard_coal,generation_fossil_oil,generation_fossil_oil_shale,generation_fossil_peat,generation_geothermal,generation_hydro_pumped_storage_consumption,generation_hydro_run_of_river_and_poundage,generation_hydro_water_reservoir,generation_marine,generation_nuclear,generation_other,generation_other_renewable,generation_solar,generation_waste,generation_wind_offshore,generation_wind_onshore,forecast_solar_day_ahead,forecast_wind_onshore_day_ahead,total_load_forecast,total_load_actual,price_day_ahead,price_actual\n";

# Iterate through each record
my $prev = 1;
my $pym = "2015,1";
my @weather;
my @summw = (0,0,0,0,0,0);
my @energy;
my @summe = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
my @price;
my @summp = (0,0);
my $hours = 0;
while ( <$csv> ) {

    # Get current day and a list of weather data and a list of energy data
    # print $_;
    # if ( $_ =~ m/^[\s\d\:\+\-]*,(\d*,\d*),(\d*),\d*,([\d\.]*,\d*,\d*,\d*,\d*,\d*),([\d\s\,]*),([\d\.]*,[\d\.]*)$/) {
    if ( $_ =~ m/^[\s\d\:\+\-]*,(\d*,\d*),(\d*),\d*,([\d\.]*,\d*,\d*,\d*,\d*,\d*),([\d\,]*),([\s\d\.]*\,[\s\d\.]*)$/) {

        @weather = split(/,/, $3);
        @energy  = split(/,/, $4);
        @price   = split(/,/, $5);

        # Same day
        if ($prev == $2) {

            # Log another entry
            $hours = $hours + 1;

            # Sum weather and energy data
            for my $w ( 0 .. scalar @weather-1 ) {
                $summw[$w] = $summw[$w] + $weather[$w];
            }
            for my $e ( 0 .. scalar @energy-1 ) {
                $summe[$e] = $summe[$e] + $energy[$e];
            }
            for my $p ( 0 .. scalar @price-1 ) {
                $summp[$p] = $summp[$p] + $price[$p];
            }
        }

        # New day
        else {

            # Dump aggregate data
            print "$pym,$prev,";
            for my $w ( 0 .. scalar @summw-1 ) {
                print $summw[$w]/$hours;
                print ","
            }
            for my $e ( 0 .. scalar @summe-1 ) {
                print $summe[$e];
                print ","
            }
            for my $p ( 0 .. scalar @summp-1 ) {
                print $summp[$p]/$hours;
                if ( $p < scalar @summp-1) {
                    print ",";
                }
                else {
                    print "\n";
                }
            }

            # Reset variables
            $hours = 1;
            @summw = (0,0,0,0,0,0);
            @summe = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
            @summp = (0,0);

            # Get new day number
            $prev = $2;
            $pym = $1;

        }

    }

}

close $csv;