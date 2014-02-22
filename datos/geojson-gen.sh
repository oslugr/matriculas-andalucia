#!/bin/bash

for y in $(seq 1997 1 2009) 
do
    ../src/json2geojson-poly.pl $y > alumnos-becas.geojson
    git commit -a -m "Actualizando año ${y}"
done
