#!/usr/bin/env perl

use File::Slurp qw(read_file);

use v5.014;

use JSON;

my %data;

while (@ARGV) {
    my $file_name = shift @ARGV;
    my $file_data = read_file($file_name);

    my ($year) = ($file_name =~ /(\d+)\.txt/);
    
    my ($alumnos,$ordinarias,$mec) = ($file_data =~ /ALUMNOS:.+?(\d+)\s+.+?ORDINARIA.+?(\d+)\s+.+?BECARIO M.E.C.  .+?(\d+)\s+/sg);

    $data{$year}->{'alumnos'}=$alumnos;

}
say(to_json(\%data));
