#!/bin/bash -l

# Rachel Steinhart
# July 2020

#$ wgrib2 old.grb -if ":TSOIL:" -set_var SOILTMP -fi -grib new.grb

for file in "$data_dir/"FINAL*; do

    echo $file
    wgrib2 $file -if ":TMP:" -set_var TT -fi -grib NAEFS.2019082700.${file}
    wgrib2 $file -if ":HGT:" -set_var GHT -fi -grib NAEFS.2019082700.${file}
    wgrib2 $file -if ":UGRD:" -set_var UU -fi -grib NAEFS.2019082700.${file}
    wgrib2 $file -if ":VGRD:" -set_var VV -fi -grib NAEFS.2019082700.${file}
    wgrib2 $file -if ":VVEL:" -set_var PRESSURE -fi -grib NAEFS.2019082700.${file}
    wgrib2 $file -if ":PRMSL:" -set_var PMSL -fi -grib NAEFS.2019082700.${file}  
    wgrib2 $file -if ":PRES:" -set_var PSFC -fi -grib NAEFS.2019082700.${file}

done