#!/usr/bin/env perl

use File::Slurp qw(read_file);
use Text::CSV;

use v5.014;

use JSON;
use strict;

my %data;

my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
                 or die "Cannot use CSV: ".Text::CSV->error_diag ();

#El archivo se reescribe siempre que se ejecute el programa
open( SALIDA, ">matriculas-becas-ugr.csv") or die "No se puede abrir matriculas-becas-ugr.csv" . ".csv";
#Cabecera del documento
print SALIDA "Año, Alumnos, Varones, Mujeres, Ordinarios, Becas \n";

while (@ARGV) {

    my $file_name = shift @ARGV;
    my $file_data = read_file($file_name);

#Para formatear el archivo entero en csv (Sin terminar)
#    open( ENTRADA, "$file_name") or die "No se puede abrir $file_name";


#    $file_data =~ s/[\|\:]/,/g;
#    $file_data =~ s/_/ /g;

#    print SALIDA $file_data;
 

    my ($year) = ($file_name =~ /(\d+)\.txt/);
    
    my ($alumnos,$ordinarias) = ($file_data =~ /ALUMNOS:.+?(\d+)\s+.+?ORDINARIA.+?(\d+)\s/s);

    my ($mec) = ($file_data =~ /BECARIO .+? (\d+)/s);

    my ($varones, $mujeres) = ($file_data =~ /VARONES:.+?(\d+)\s+.+?MUJERES:.+?(\d+)/s);

#    $data{$year} = { alumnos => $alumnos,
#		     ordinarios => $ordinarias,
#		     mec => $mec };

    print SALIDA $year.",".$alumnos.",".$varones.",".$mujeres.",".$ordinarias.",".$mec."\n";


}

close SALIDA;

#say(to_json\%data));
