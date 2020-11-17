#!/bin/bash -l

# Rachel Steinhart
# June 2020

# Script selects the unique variables from cmc and writes them to a file
# it also takes the common variables from cmc and ncep files and 
# writes them to a new file 

# Data is input directly from forecast grib files !!! currently this is
# just one day files but this will need to be generalized. !!!!!
# Data is output to the same directory as it is input

# -------------------------------------------------- #
data_dir="/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100"
out_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean/"

# -------------------------------------------------- #

# create the directory for merged original files
if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi


# -------------------------------------------------- #
# Select variables and write new files

# Common variables
for file in "$data_dir/"*; do
    echo $file
    if [[ "$file" == *"pgrb2f000"* ]]; then
        wgrib2 $file -match ":(UGRD|VGRD|HGT|TMP|RH):(200|250|500|700|850|925|1000) mb:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRES:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":WEASD" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRMSL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":VVEL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PWAT:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":LHTFL:surface:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":SHTFL:surface:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":APCP:surface:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":TMP:2 m above ground:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":RH:2 m above ground:" -append -grib ${file}_common_out.grb
        # wgrib2 $file -match ":TMIN:2 m above ground:" -append -grib ${file}_common_out.grb
        # wgrib2 $file -match ":TMAX:2 m above ground:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":UGRD:10 m above ground:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":VMAX:2 m above ground:" -append -grib ${file}_common_out.grb

    else 
        wgrib2 $file -match ":(UGRD|VGRD|HGT|TMP|RH):(200|250|500|700|850|925|1000) mb:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRES:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":WEASD" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRMSL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":VVEL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PWAT:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":TCDC:" -append -grib ${file}_common_out.grb

        wgrib2 $file -match ":LHTFL:surface:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":SHTFL:surface:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":APCP:surface:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":TMP:2 m above ground:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":RH:2 m above ground:" -append -grib ${file}_common_out.grb
        # wgrib2 $file -match ":TMIN:2 m above ground:" -append -grib ${file}_common_out.grb
        # wgrib2 $file -match ":TMAX:2 m above ground:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":UGRD:10 m above ground:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":VMAX:2 m above ground:" -append -grib ${file}_common_out.grb

    fi 


done

# CMC specific variables
for file in "$data_dir/"*; do
    echo $file
    if [[ "$file" == *"pgrb2f000"* ]]; then
        wgrib2 $file -match ":(UGRD|VGRD):(50|100|300|400) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(HGT):(50|100|300) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(TMP):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(RH):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":SNOD:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":TCDC:" -append -grib ${file}_cmc_out.grb

    else 
        wgrib2 $file -match ":(UGRD|VGRD):(50|100|300|400) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(HGT):(50|100|300) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(TMP):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(RH):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":SNOD:" -append -grib ${file}_cmc_out.grb

    fi

done

echo ' '
echo ' '
echo '* * * * * * * * * * * * * *'
echo 'Script is finished running'
echo '* * * * * * * * * * * * * *'

