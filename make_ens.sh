#!/bin/bash -l

source config

echo 'Starting script to merge ensemble files'
echo 'System time is:' `date`


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

if [ ! -d "$OUT_DIR/all_stats" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/all_stats
fi

if [ ! -d "$OUT_DIR/ens_mean" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/ens_mean
fi

#fhr='00' --> only need this if I'm going to be working with other forecast hour variables.


# need to merge all ensemble files with gmerge
#     gmerge ens_files/fh000_merged_test grib_files/*.t00z.pgrb2f000*
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "merging for fcst hour" $fcst
    #gmerge output fcst1 fcst2 fcst3
    gmerge $OUT_DIR/merged_files/BC_merged.t00z.pgrb2f${fcst} $GRIB_DIR/*.t00z.pgrb2f000*
    echo "merged"
    echo "file available at: $OUT_DIR/BC_merged.t00z.pgrb2f${fcst}"
done


# then need to calc ensemble mean with -ens_processing
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "getting ensemble details for hsct hour" $fcst
    #wgrib2  output1 -ens_processing output2 x
    wgrib2  $OUT_DIR/merged_files/BC_merged.t00z.pgrb2f${fcst} -ens_processing $OUT_DIR/all_stats/BC_ens.t00z.pgrb2f${fcst} 0
    echo "merged"
    echo "file available at: $OUT_DIR/BC_ens.t00z.pgrb2f${fcst}"
done


# then we extract the ensemble mean from the statistics
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "extracting ensemble mean for hsct hour" $fcst
    # extract ensemble mean from statistics
    wgrib2 $OUT_DIR/all_stats/BC_ens.t00z.pgrb2f${fcst} -match  ":ens mean" -grib $OUT_DIR/ens_mean/BC_ens_mean.t00z.pgrb2f${fcst}.grb
    echo "merged"
    echo "file available at: $OUT_DIR/BC_ens_mean.t00z.pgrb2f${fcst}.grb"
done


