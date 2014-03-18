#!/usr/bin/env perl

#Versión 2 del script para poder sacar los datos de un text formateado de alguna forma concreta.
#Se pueden sacar los datos Año, Alumnos, Varones, Mujeres, Ordinarios y Becas y se pasa a formato .csv a un archivo
# llamado "matriculas-becas-ugr.csv".
#Siempre que se use este programa, sobreescribirá el archivo "matriculas-becas-ugr.csv"
use File::Slurp qw(read_file);
use Text::CSV;

use v5.014;

use JSON;
use strict;

my %data;

#El archivo se reescribe siempre que se ejecute el programa
open( SALIDA, ">matriculas-becas-ugr.csv") or die "No se puede abrir matriculas-becas-ugr.csv";
#Cabecera del documento

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

#    print SALIDA $year.",".$alumnos.",".$varones.",".$mujeres.",".$ordinarias.",".$mec."\n";

    $data{$year} = { Alumnos => $alumnos,
            Varones => $varones,
            Mujeres => $mujeres,
            Ordinarios => $ordinarias,
            Mec => $mec };

print SALIDA (to_json\%data);
}

close SALIDA;

#say(to_json\%data));