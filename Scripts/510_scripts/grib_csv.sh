#!/bin/bash -l

# Rachel Steinhart
# November 2020

# RUN IN DATA FOLDER # 

# -------------------------------------------------- #
# data_dir="/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100"
out_dir="/Volumes/Scratch/Rachel/NAEFS/510_temp/det_files"

# -------------------------------------------------- #

# grib_get_data -w time=0 infile > outfile.csv

FILES=*.t00z.pgrb2f000_TMP_BC.grb

for file in $FILES; do

    grib_get_data -w time=0 $file > $file.csv

done