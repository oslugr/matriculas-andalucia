#!/usr/bin/env perl

use File::Slurp qw(read_file);

use v5.014;

use JSON;

my %data;

while (@ARGV) {
    my $file_name = shift @ARGV;
    my $file_data = read_file($file_name);

    my ($year) = ($file_name =~ /(\d+)\.txt/);
    
    my ($alumnos,$ordinarias) = ($file_data =~ /ALUMNOS:.+?(\d+)\s+.+?ORDINARIA.+?(\d+)\s/s);

    my ($mec) = ($file_data =~ /BECARIO .+? (\d+)/s);

    $data{$year} = { alumnos => $alumnos,
		     ordinarios => $ordinarias,
		     mec => $mec };

}
say(to_json(\%data));
