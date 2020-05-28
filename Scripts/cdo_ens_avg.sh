#!/bin/bash -l

# source config_cdo

# echo 'Starting script to merge ensemble files'
# echo 'System time is:' `date`


# create directory if it doesn't already exist
# echo 'Output directory is' $OUT_DIR
OUT_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test
MERGE_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files

if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

if [ ! -d "$OUT_DIR/ens_mean" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/ens_mean
fi

# calculate ensemble mean with cdo ensmean
# for file in $MERGE_DIR; do
#     # cdo ensmean fileis fileo
#     cdo ensmean cmc_* ncep_* ens_average

# done

# cdo ensmean fileis fileo
cdo ensmean cmc_* cmc_ens_average

cdo ensmean ncep_* ncep_ens_average