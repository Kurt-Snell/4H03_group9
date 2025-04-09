#!/usr/bin/perl

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 27 March 2025
# Updated: 27 March 2025

# Perl script to dump headers of a CSV
# In the current working directory, call `perl get_cols.pl "filename.csv"`

# Compatibility control
use warnings;
use strict;
use 5.36.1;

# Inputs are file name and column number to be parsed
my $fl = $ARGV[0];

# Open file for processing
open(my $csv, '<', $fl) or die "Cannot open file \'$fl\': $!";

# Get headers and remove date-time to be replaced with year, month, day, UTC
my $first = <$csv>;
my @headers = split(/,/, $first);
foreach ( @headers ) {
    # print "\"$_\", ";
    print "$_,";
}

close $csv;