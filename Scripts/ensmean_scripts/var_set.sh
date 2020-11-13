#!/bin/bash -l

# Rachel Steinhart
# July 2020


# data_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean"
data_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean/2020080100"
date="2020080100"

#$ wgrib2 old.grb -if ":TSOIL:" -set_var SOILTMP -fi -grib new.grb

# for file in "$data_dir/"FINAL*; do
for fcst in $(seq -f "%03g" 0 6 384); do

    echo $file
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":var0_4_0_54_0_0:" -set_var var0_2_1_7_0_0 -fi -grib $data_dir/NAEFS.${date}.${fcst}.grb #TMP
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":var0_4_0_54_3_5:" -set_var var0_2_1_7_3_5 -fi -grib $data_dir/NAEFS.${date}.${fcst}.grb #HGT
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":var0_4_0_54_2_2:" -set_var var0_2_1_7_2_2 -fi -grib $data_dir/NAEFS.${date}.${fcst}.grb #UGRD
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":var0_4_0_54_2_3:" -set_var var0_2_1_7_2_3 -fi -grib $data_dir/NAEFS.${date}.${fcst}.grb #VGRD
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":var0_4_0_54_2_8:" -set_var var0_2_1_7_2_8 -fi -grib $data_dir/NAEFS.${date}.${fcst}.grb #VVEL
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":var0_4_0_54_3_1:" -set_var var0_2_1_7_3_1 -fi -grib $data_dir/NAEFS.${date}.${fcst}.grb #PRMSL 
    wgrib2 $data_dir/FINALmean_${fcst}.grb -if ":var0_4_0_54_3_0:" -set_var var0_2_1_7_3_0 -fi -grib $data_dir/NAEFS.${date}.${fcst}.grb #PRES

done