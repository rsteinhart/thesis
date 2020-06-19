#!/bin/bash -l

path=/Users/rsteinhart/DATA/test_data/NAEFS/grib_files/2019082700/*

for file in $path; do
    echo $file
    wgrib2 $file -match PRES -append -grib ${file}_out.grb
    wgrib2 $file -match TMP -append -grib ${file}_out.grb
    wgrib2 $file -match UGRD -append -grib ${file}_out.grb
    wgrib2 $file -match VGRD -append -grib ${file}_out.grb
    wgrib2 $file -match RH -append -grib ${file}_out.grb
    wgrib2 $file -match PWAT -append -grib ${file}_out.grb
    wgrib2 $file -match TCDC -append -grib ${file}_out.grb
    wgrib2 $file -match APCP -append -grib ${file}_out.grb
    wgrib2 $file -match WEASD -append -grib ${file}_out.grb
    wgrib2 $file -match PRMSL -append -grib ${file}_out.grb
    wgrib2 $file -match WEL -append -grib ${file}_out.grb
    wgrib2 $file -match SNOD -append -grib ${file}_out.grb

    wgrib2 $file -match HGT -append -grib ${file}_out.grb


done