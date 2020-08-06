#!/bin/bash -l

# Rachel Steinhart
# July 2020


data_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean"

#$ wgrib2 old.grb -if ":TSOIL:" -set_var SOILTMP -fi -grib new.grb

# for file in "$data_dir/"FINAL*; do
for fcst in $(seq -f "%03g" 0 6 384); do

    echo $file
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":TMP:" -set_var TT -fi -grib $data_dir/NAEFS.2019082700.${fcst}.grb
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":HGT:" -set_var GHT -fi -grib $data_dir/NAEFS.2019082700.${fcst}.grb
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":UGRD:" -set_var UU -fi -grib $data_dir/NAEFS.2019082700.${fcst}.grb
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":VGRD:" -set_var VV -fi -grib $data_dir/NAEFS.2019082700.${fcst}.grb
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":VVEL:" -set_var PRESSURE -fi -grib $data_dir/NAEFS.2019082700.${fcst}.grb
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":PRMSL:" -set_var PMSL -fi -grib $data_dir/NAEFS.2019082700.${fcst}.grb  
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":PRES:" -set_var PSFC -fi -grib $data_dir/NAEFS.2019082700.${fcst}.grb

done