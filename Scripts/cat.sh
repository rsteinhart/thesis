#!/bin/bash -l

# Rachel Steinhart
# July 2020

# cat file1.grb file2.grb ... file[N].grb > concatenated.grb


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
    cat cdo_cmc_mean_${fcst} cdo_common_mean_${fcst} > FINALmean_${fcst}.grb


done