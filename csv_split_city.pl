#!/usr/bin/perl

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 26 March 2025
# Updated: 26 March 2025

# Perl script to separate a CSV of cities into new CSVs
# In the current working directory, call `perl csv_split_city.pl "filename.csv"`

# Compatibility control
use warnings;
use strict;
use 5.36.1;

# Get headers and remove second column
open(CSV, '<', $ARGV[0]) or die "Cannot open file \'$ARGV[0]\': $!";
my $headers = <CSV>;
$headers =~ s/^([\w\_\-\/]*),[\w\_\-\/]*,([\w\_\-\/\,]*)/$1,$2/;
close CSV;

# Hardcoded list of cities
my @cities = ("Valencia", "Madrid", "Bilbao", "Barcelona", "Seville");

# Create new CSV for each city
my $new;
my $fl = $ARGV[0];
$fl =~ s/\.\w*$//;
foreach my $city ( @cities ) {

    # Reopen original CSV file
    open(CSV, '<', $ARGV[0]) or die "Cannot open file $ARGV[0]\': $!";

    # Get new file name
    $new = "${fl}_$city.csv";
    open(NSV, '>', $new) or die "Cannot create file \'$new\': $!";
    print NSV $headers;

    while (<CSV>) {

        # Add to new CSV without city name if the city matches
        if ($_ =~ m/^[\w\_\-\/\s\:\+]*,\s?(\w*),[\w\_\-\/\,]*/) {
            if ($1 eq $city) {
                $_ =~ s/^([\w\_\-\/\s\:\+]*),\s?\w*,([\w\_\-\/\,]*)/$1,$2/;
                print NSV $_;
            }
        }
    }

    close NSV;
    close CSV;

}