#!/usr/bin/perl

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 8 April 2025
# Updated: 8 April 2025

# Perl script to change absolute energy generation to relative
# In the current working directory, call `perl rel_gen.pl "filename.csv"`

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
print "year,month,day,temp,pressure,humidity,wind_speed,wind_direction,clouds,generation_biomass,generation_fossil_brown_coal_lignite,generation_fossil_coal_derived_gas,generation_fossil_gas,generation_fossil_hard_coal,generation_fossil_oil,generation_fossil_oil_shale,generation_fossil_peat,generation_geothermal,generation_hydro_pumped_storage_consumption,generation_hydro_run_of_river_and_poundage,generation_hydro_water_reservoir,generation_marine,generation_nuclear,generation_other,generation_other_renewable,generation_solar,generation_waste,generation_wind_offshore,generation_wind_onshore,total_generation,forecast_solar_day_ahead,forecast_wind_onshore_day_ahead,total_load_forecast,total_load_actual,price_day_ahead,price_actual\n";

# Iterate through each record
my @energy_abs;
my @energy_rel = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
my $summe = 0;
while ( <$csv> ) {

    # Get current day and a list of weather data and a list of energy data
    if ( $_ =~ m/^(\d*,\d*,\d*,[\d\.]*,[\d\.]*,[\d\.]*,[\d\.]*,[\d\.]*,[\d\.]*),([\d\,]*),(\d*,\d*,\d*,\d*,[\s\d\.]*,[\s\d\.]*)$/ ) {

        # Dynamically get all energy data
        @energy_abs  = split(/,/, $2);
        foreach ( @energy_abs ) {
            $summe = $summe + $_;
        }

        # Get relative values
        foreach my $g ( 0 .. scalar @energy_rel - 1) {
            $energy_rel[$g] = $energy_abs[$g] / $summe;
        }

        # Dump new values
        print "$1,";
        foreach my $g ( 0 .. scalar @energy_rel - 1) {
            print "${energy_rel[$g]},";
        }
        print "$summe,";
        print $3;

        # Reset for next record
        @energy_rel = (0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0);
        $summe = 0

    }

}

close $csv;