#!/usr/bin/perl

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 18 March 2025
# Updated: 18 March 2025

# Perl script to separate CSV time-date format into separate fields
# In the current working directory, call `perl csv_split_date "filename.csv"`

# Compatibility control
use warnings;
use strict;
use 5.36.1;

# Inputs are file name and column number to be parsed
my $fl = $ARGV[0];

# Open file for processing
open(my $csv, '<', $fl) or die "Cannot open file \'$fl\': $!";

# Get headers and remove date-time to be replaced with year, month, day, UTC
my $headers = <$csv>;
$headers =~ s/^dttm,/dttm,year,month,day,hour,/;
print $headers;

# Process datetime
my $dttm;
while(<$csv>) {

    # Only affect rows in proper format
    $_ =~ m/^(\d\d\d\d\-\d\d\-\d\d \d\d\:00\:00\+\d\d\:00),/;
    $dttm = $1;
    $_ =~ s/^(\d\d\d\d)\-(\d\d)\-(\d\d) (\d\d)\:00\:00\+\d\d\:00\,/$dttm,$1,$2,$3,$4,/;
    print $_;
    
}

close $csv;

# 2015-01-21 18:00:00+01:00
# YYYY-MM-DD HH:MM:SS+UTC_diff