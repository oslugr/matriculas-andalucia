#!/usr/bin/env perl

use File::Slurp qw(read_file);

use v5.014;

use JSON;

my $year = shift;
my $file_name = shift || "matriculas-becas-ugr.json";

my $file_data = read_file($file_name);

my $hash =from_json( $file_data );

my %keys;

my $geojson_base =<<EOC;
{ "type": "FeatureCollection",
  "features": [
    { "type": "Feature",
      "geometry": {"type": "Point", "coordinates": [-3.600833, 37.178056]}
      }
      ]
}
EOC

my $geojson =from_json( $geojson_base);

$geojson->{'features'}[0]->{'properties'} = $hash->{$year};

say to_json($geojson);

