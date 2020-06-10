#!/bin/bash -l

# source config_cdo

# echo 'Starting script to merge ensemble files'
# echo 'System time is:' `date`

OUT_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/cmc_vars/merged_files
MERGE_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/cmc_vars/merged_files

if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

if [ ! -d "$OUT_DIR/ens_mean" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/ens_mean
fi

# cdo ensmean fileis file
for fcst in $(seq -f "%03g" 0 6 384); do
    cdo ensmean $MERGE_DIR/sp_cmc_merged.t00z.pgrb2f${fcst} $OUT_DIR/ens_mean/sp_cmc_ensmean.t00z.pgrb2f${fcst}

    #cdo ensmean $MERGE_DIR/ncep_merged.t00z.pgrb2f${fcst} $OUT_DIR/ens_mean/ncep_ens_mean.t00z.pgrb2f${fcst}

done

echo '!!!!!!!!!!  Ensemble averaging complete :) !!!!!!!!!!'


# To see what each forecast is
# for fcst in $(seq -f "%03g" 0 6 384); do
# echo $fcst
# done