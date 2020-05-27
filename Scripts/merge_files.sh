#!/bin/bash -l

source config

# echo 'Starting script to merge ensemble files'
# echo 'System time is:' `date`


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

#fhr='00' --> only need this if I'm going to be working with other forecast hour variables.


# merge ncep and cmc files seperately
#     gmerge ens_files/fh000_merged_test grib_files/*.t00z.pgrb2f000*

for fcst in "$GRIB_DIR"; do
    # determine if forecast is cmc or ncep files
    if [[ "$fcst" == "cmc_"* ]]; then
        gmerge $OUT_DIR/merged_files/cmc_merged.t00z.pgrb2f${fcst} $GRIB_DIR/cmc_*.t00z.pgrb2f000*
    fi

    if [[ "$fcst" == "ncep_"* ]]; then
        gmerge $OUT_DIR/merged_files/ncep_merged.t00z.pgrb2f${fcst} $GRIB_DIR/ncep_*.t00z.pgrb2f000*
    fi

done
