#!/bin/bash -l

# Rachel Steinhart
# July 2020

# This script is run after cdo_ens_mean.sh at combines the cmc and common
# mean files
# These files should be ready to be input into WRF 
# BUT need to confirm that the ordering of variabes is ok

# -------------------------------------------------- #
data_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean/ens_mean"
out_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean/ens_mean"

# -------------------------------------------------- #

# create the directory for merged original files
if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

# -------------------------------------------------- #

for fcst in $(seq -f "%03g" 0 6 384); do
    # cat file1.grb file2.grb ... file[N].grb > concatenated.grb
    # Doesn't work with file paths :( or at least the output doesn't
    cat cdo_cmc_mean_${fcst} cdo_common_mean_${fcst} > FINALmean_${fcst}.grb


done