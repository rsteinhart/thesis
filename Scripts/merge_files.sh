#!/bin/bash -l

#source config

# echo 'Starting script to merge ensemble files'
# echo 'System time is:' `date`

OUT_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/common_vars
GRIB_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/common_vars/cmc_ncep


# create directory if it doesn't already exist
echo 'Output directory is' $OUT_DIR
if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

if [ ! -d "$OUT_DIR/merged_files" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/merged_files
fi

# merge ncep and cmc files seperately
#     gmerge ens_files/fh000_merged_test grib_files/*.t00z.pgrb2f000*

for fcst in $(seq -f "%03g" 0 6 384); do
    # merge cmc files
    gmerge $OUT_DIR/merged_files/cmn_merged.t00z.pgrb2f${fcst} $GRIB_DIR/*_merged.t00z.pgrb2f${fcst}

    # merge ncep files
    #gmerge $OUT_DIR/merged_files/ncep_merged.t00z.pgrb2f${fcst} $GRIB_DIR/ncep_*.t00z.pgrb2f*

done

echo '!!!!!!!!!!! merging complete :) !!!!!!!!!!!'