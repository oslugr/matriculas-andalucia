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

        open (ENTRADA,"<:encoding(utf8)", $file_name) or die "No se puede abrir salida";
        my @lineas = <ENTRADA>;
        my $tabla;
        my $tablaCompleta;
 #       while($linea = <ENTRADA>){
            if($_ =~ /^\s?\n\s?$/){
                say "PE";
            }
            say $_;
 #       }
        foreach $linea (@lineas){
            if($linea =~ /(\s[\d\w]\).*$)/){
                ($cabecera) = $1;
                #say $1;
                #print $cabecera;
            }
            if($linea =~ /\s*[\|\_]*/g){
                ($tabla) = ($linea =~ m/$\s*\|.*\|$/g);
               $tablaCompleta .= $tabla."\n";

            }
            if($linea =~ /^\n$/){
                #print $cabecera;
                
                open (SALIDA, ">".join('',@directory_name)."/".$cabecera);
                    print SALIDA $tablaCompleta;
                close (SALIDA);
                $tablaCompleta="";
                $tabla="";
            }
                
        }
        #print $tablaCompleta;

        #while (<SALIDA>){
            #$linea = $csv->getline ($file_data);
        #    say "HOLA";
        #    chomp($_);
            #say $_;
        #    my @cabeceras = (@$_ =~ /.*/);
        #    say $cabeceras[10];
       #         say $cabecera;
            
            #say $linea;
        #Para formatear el archivo entero en csv (Sin terminar)
        #    open( ENTRADA, "$file_name") or die "No se puede abrir $file_name";


#            $file_data =~ s/[\|\:]/,/g;
#            $file_data =~ s/_/ /g;

        #    print SALIDA $file_data;

#            $data{$year} = { Alumnos => $alumnos,
#                    Varones => $varones,
#                    Mujeres => $mujeres,
#                    Ordinarios => $ordinarias,
#                    Mec => $mec };
        #}
            close(ENTRADA);
    }
#    $file_json = (to_json\%data);
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