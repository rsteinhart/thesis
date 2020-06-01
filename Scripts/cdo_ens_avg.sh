#!/bin/bash -l

# source config_cdo

# echo 'Starting script to merge ensemble files'
# echo 'System time is:' `date`

OUT_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/ens_mean
MERGE_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files

if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

if [ ! -d "$OUT_DIR/ens_mean" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/ens_mean
fi

# !!!!!!!!! Consider defining a folder for cmc and ncep ens_average files? !!!!!!!!!!!!!!!!!!!!!!

# cdo ensmean fileis file
for fcst in $(seq -f "%03g" 0 6 384); do
    cdo ensmean $MERGE_DIR/cmc_* $OUT_DIR/cmc_ens_average${fcst}

    cdo ensmean $MERGE_DIR/ncep_* $OUT_DIR/ncep_ens_average${fcst}

done