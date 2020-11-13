#!/bin/bash -l

#source config

# echo 'Starting script to merge ensemble files'
# echo 'System time is:' `date`

OUT_DIR=/Volumes/Scratch/Rachel/NAEFS/grib_files/merged_2019082700
GRIB_DIR=/Volumes/Scratch/Rachel/NAEFS/grib_files/2019082700


# create directory if it doesn't already exist
echo 'Output directory is' $OUT_DIR
if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

# if [ ! -d "$OUT_DIR/final" ]; then
#     echo 'Output directory does not exist yet... creating directory'
#     mkdir $OUT_DIR/final
# fi



# merge forecast files
for fcst in $(seq -f "%03g" 0 6 384); do
    # gmerge <to> <from>
    gmerge $OUT_DIR/cmc_merged.t00z.pgrb2f${fcst} $GRIB_DIR/cmc_*.t00z.pgrb2f${fcst}*
    gmerge $OUT_DIR/ncep_merged.t00z.pgrb2f${fcst} $GRIB_DIR/ncep_*.t00z.pgrb2f${fcst}*

done



# merge ncep and cmc files seperately
#     gmerge ens_files/fh000_merged_test grib_files/*.t00z.pgrb2f000*

# for fcst in $(seq -f "%03g" 0 6 384); do
#     # merge cmc files
#     gmerge $OUT_DIR/final/complete_ens.t00z.pgrb2f${fcst} $GRIB_DIR/*.t00z.pgrb2f${fcst}*

#     # merge ncep files
#     #gmerge $OUT_DIR/merged_files/ncep_merged.t00z.pgrb2f${fcst} $GRIB_DIR/ncep_*.t00z.pgrb2f*

# done

echo '!!!!!!!!!!! merging complete :) !!!!!!!!!!!'