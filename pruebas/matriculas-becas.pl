#!/usr/bin/env perl

use File::Slurp qw(read_file);
use Text::CSV;

use v5.014;

use JSON;

my %data;

my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
                 or die "Cannot use CSV: ".Text::CSV->error_diag ();

while (@ARGV) {

    my $file_name = shift @ARGV;
    open( SALIDA, ">$file_name".".csv") or die "No se puede abrir $file_name";
    my $file_data = read_file($file_name);

    my ($year) = ($file_name =~ /(\d+)\.txt/);
    
    my ($alumnos,$ordinarias) = ($file_data =~ /ALUMNOS:.+?(\d+)\s+.+?ORDINARIA.+?(\d+)\s/s);

    my ($mec) = ($file_data =~ /BECARIO .+? (\d+)/s);

 #   my ($mujeres) = ($)

    $data{$year} = { alumnos => $alumnos,
		     ordinarios => $ordinarias,
		     mec => $mec };

    close SALIDA;

}
 print Text::CSV->VERSION;
#say(to_json\%data));
