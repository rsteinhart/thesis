#!/bin/bash -l

# Rachel Steinhart
# November 2020

# -------------------------------------------------- #
data_dir="/Volumes/Scratch/Rachel/NAEFS/510_temp/det_files"
# out_dir="/Volumes/Scratch/Rachel/NAEFS/510_temp/det_files"
# -------------------------------------------------- #

for file in $data_dir; do

    wgrib2 $file -match -small_grib -140:-115 49:60 $file_BC.grb

done

