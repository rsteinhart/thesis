#!/bin/bash -l

# Rachel Steinhart
# November 2020

# -------------------------------------------------- #
# data_dir="/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100"
out_dir="/Volumes/Scratch/Rachel/NAEFS/510_temp/det_files"

# -------------------------------------------------- #

# var = TMP = var0_2_1_7_0_0

# grib_get_data -w shortName=t FILE

FILES=*.t00z.pgrb2f000

for file in $FILES; do

    wgrib2 $file -match ":TMP" -grib $out_dir/${file}_TMP.grb

done
