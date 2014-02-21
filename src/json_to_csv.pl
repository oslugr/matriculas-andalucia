#!/usr/bin/env perl

use File::Slurp qw(read_file);

use v5.014;

use JSON;

my $file_name = shift;

my $file_data = read_file($file_name);

my $hash =from_json( $file_data );

my %keys;

for my $k (keys %$hash ) {
    for my $l (keys %{$hash->{$k}} ) {
	$keys{$l} = 1;
    }
}

say "Año,",join(",", keys %keys );
for my $k (sort { $a <=> $b } keys %$hash ) {
    my $line = "$k";
    for my $l (keys %keys ) {
	$line .= ",".$hash->{$k}->{$l};
    }
    say $line;
}
