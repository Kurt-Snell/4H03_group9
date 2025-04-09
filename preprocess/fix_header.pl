#!/usr/bin/perl

# Kurt Emmanuel Snell
# kurt.snell@gmail.com
# Created: 26 March 2025
# Updated: 26 March 2025

# Perl script to fix headers of weather and energy datasets
# In the current working directory, call `perl fix_header.pl "filename.csv"`

# Compatibility control
use warnings;
use strict;
use 5.36.1;

# Get headers change to format without spaces and first column called "dttm"
open(CSV, '<', $ARGV[0]) or die "Cannot open file \'$ARGV[0]\': $!";
my $headers = <CSV>;
$headers =~ tr/ /_/;
$headers =~ s/^[\w\-\_\.\:\/]+,/dttm,/;

# Dump contents
print $headers;
while (<CSV>) {
    print $_;
}

close CSV;