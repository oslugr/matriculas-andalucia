#!/usr/bin/env perl

#Versión 1 - Crea archivos con el nombre de las tablas de los archivos del 1996-2009 y los exporta a .csv

#Para ejecutar este programa hay que instalar las librerías, JSON, Slurp y Switch

use File::Slurp qw(read_file);
use Text::CSV qw(getline);
use File::Path qw(mkpath remove_tree);


use v5.014;

use JSON;
use strict;
use Switch;

my %data;
my $file_json;
my $tabla;
my $linea;

use constant false => 0;
use constant true  => 1;

sub principal {
    my $csv = Text::CSV->new ( { binary => 1 } )  # should set binary attribute.
                 or die "Cannot use CSV: ".Text::CSV->error_diag ();
    while (@ARGV) {
        my $file_name = shift @ARGV;
        my @directory_name = split(".txt", $file_name);
      
        my $file_data = read_file($file_name);
        mkpath(@directory_name);
        #my $linea = $csv->getline ($file_data);

        #my ($tabla) = ($file_data =~ /\s*[\d\w])/g);
        my $cabecera;# = ($file_data =~ /.\).*/g);
        #say $cabecera;
        #my ($tabla) = ($file_data =~ /\|.*\|\n\n/g);
        #my ($tabla) = ($file_data =~ /\s[\_\s]*[\d\w\s\|\_]*\|\n\n/g);
        #say $tabla;

        #my ($tabla2) = ($file_data =~ /\s[\_\s]*[\d\w\s\|\_]*\|\n\n/g);
        #say $tabla2;
        
        #$linea = $csv->getline ($file_data);

        open (ENTRADA,"<:encoding(iso88591)", $file_name) or die "No se puede abrir salida";
        my @lineas = <ENTRADA>;
        my $tabla;
        my $tablaCompleta;
        my $finalTabla;
        
        foreach $linea (@lineas){
            if($linea =~ /\s(.\).*$)/){
                ($cabecera) = $1;
            }
            if($linea =~ /\s*[\|\_]*/){
            
                ($tabla) = ($linea =~ /\|.*\|$/g);
                #Le quito la primera barra y la última a las líneas
                $tabla =~ s/(\|)//;
                $tabla =~ s/\s+([\w\d]*)/$1/;
                $tablaCompleta .= $tabla."\n";
                $finalTabla = true;
            }
            if(($linea =~ /^\n$/) && $finalTabla){
                #print $cabecera;
                #print $tablaCompleta;
                #Se quitan los números que muestran los porcentajes
                #$tablaCompleta =~ s/([^\ ]\|)//;
                $tablaCompleta =~ s/(\d+)\ +(\d+.\d*)/$1/g;
                #Se quitan el símbolo de los porcentajes
                $tablaCompleta =~ s/%//g;
                #Se eliminan líneas con comas y espacios
                $tablaCompleta =~ s/,\n/\n/g;
                $tablaCompleta =~ s/(\,\_+)+//g;
                $tablaCompleta =~ s/[\|]/\,/g;
                $tablaCompleta =~ s/[\_]//g;
                $tablaCompleta =~ s/(\,{2,})//g;
                $tablaCompleta =~ s/(\,\n)/\n/g;
                #$tablaCompleta =~ s/[^\w\d,\n\(\) ]//g;
                $tablaCompleta =~ s/\s+([\w\d]*)/$1/;
     #           $tablaCompleta =~ s/(\d)*/$1,/;
                $tablaCompleta =~ s/(\,\s*){2,}//g;
                print $tablaCompleta;
                open (SALIDA, ">>".join('',@directory_name)."/".$cabecera);
                    print SALIDA $tablaCompleta;
                close (SALIDA);
                $tablaCompleta="";
                $tabla="";
                $finalTabla=false;
            }
        }
        close(ENTRADA);
    }
}

sub text_to_json {
    open( SALIDA, ">matriculas-becas-ugr.json") or die "No se puede abrir matriculas-becas-ugr.json";
    print SALIDA (to_json\%data);
    close(SALIDA);
}

sub json_to_csv{
    open( SALIDA, ">matriculas-becas-ugr.csv") or die "No se puede abrir matriculas-becas-ugr.csv";
    
    my $hash =from_json( $file_json );

    my %keys;

    for my $k (keys %$hash ) {
        for my $l (keys %{$hash->{$k}} ) {
        $keys{$l} = 1;
        }
    }

    say SALIDA "Año,",join(",", keys %keys );
    for my $k (sort { $a <=> $b } keys %$hash ) {
        my $line = "$k";
        for my $l (keys %keys ) {
        $line .= ",".$hash->{$k}->{$l};
        }
        say SALIDA $line;
    }

    close (SALIDA);
}

#Cabecera del documento

print "Escoge una opción: \n"; 
print "1. Separar tablas y exportar a csv\n";
print "2. Nada\n";
print "3. Nada\n";
print "4. Salir\n";
print "Opción: " ;
#my $valor = <STDIN> ;
my $valor = 1;
while ($valor < 1 || $valor > 4){
    print "Error al escoger la opción\n\n";
            print "Escoge una opción: \n"; 
            print "1. Separar tablas y exportar a csv\n";
            print "2. Nada\n";
            print "3. Nada\n";
            print "4. Salir\n";
            print "Opción: " ;
            $valor = <STDIN> ;
}
switch ($valor) {
    case 1  {   principal();}
    case 2 {     }
    case 3 {    }
    case 4 {exit(1);}
    else { 
    }
}