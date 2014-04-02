#!/usr/bin/env perl

#Versión 1 - Unifica archivos con el mismo diseño en las tablas, indicando si se quieren 
#Autor: oskyar
#Para ejecutar este programa hay que instalar las librerías, Slurp y Switch

#use File::Slurp qw(read_file);

use v5.014;

use strict;
use Text::CSV qw(getline getline_all);
#use Switch;
use utf8;
use open 'locale'; 
my $table;
my $headerTable;
my $fieldName;
my $fileName;
#Manejadores de entrada y salida
my $IN;
my $OUT;
my $row;
use constant false => 0;
use constant true  => 1;
sub principal {
	$headerTable=false;
	#Creamos una instancia de csv
	my $csv = Text::CSV->new ({
		binary => 1,
		auto_diag => 1,
		sep_char => ',' # no se necesita realmente porque es el caracter por defecto
	});

    open ($OUT, '>:encoding(utf-8)', "archivoUNIFICADO.csv");
    while (@ARGV) {
    	#Este argumento será el nombre de la celda
        my $fieldName = shift @ARGV;
        #Archivo contenedor del .csv
        my $fileName = shift @ARGV;

	    open ($IN, '<:encoding(utf-8)', $fileName) or die "No se puede abrir el archivo ".$IN;
        if($headerTable == false){
        	#Extraigo las variables del fichero para sacarlo a la tabla unificada
        	while ( $row = $csv->getline( $IN )) {
				print $OUT ",".$row->[0];
			}
			$headerTable = true;
			#Reinicio el manejador de entrada porque lo voy a usar de nuevo
			seek $IN,0,0;
    	}

    	#Saco el nombre de la variable para la fila
    	print $OUT "\n".$fieldName;
    	#Quito la primera línea de la cabecera;
    	$csv->getline($IN);
		while ($row = $csv->getline( $IN)) {
			print $OUT ",".$row->[2];
		}
        close(ENTRADA);
    }
    close (SALIDA);
}

#Cabecera del documento
principal();
