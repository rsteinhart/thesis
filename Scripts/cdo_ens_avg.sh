#!/bin/bash -l

# source config_cdo

# echo 'Starting script to merge ensemble files'
# echo 'System time is:' `date`

OUT_DIR=/Volumes/Scratch/Rachel/NAEFS/cdo_ensmean
MATCH_DIR=/Volumes/Scratch/Rachel/NAEFS/cdo_ensmean/match

if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

# if [ ! -d "$OUT_DIR/all_stats" ]; then
#     echo 'Output directory does not exist yet... creating directory'
#     mkdir $OUT_DIR/all_stats
# fi

if [ ! -d "$OUT_DIR/ens_mean" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/ens_mean
fi


for fcst in $(seq -f "%03g" 0 6 384); do
    cdo ensmean $MATCH_DIR/*${fcst}_BC_out.grb $OUT_DIR/ens_mean/cdo_out_mean_${fcst}

done


# then need to calc ensemble mean with -ens_processing
# for fcst in $(seq -f "%03g" 0 6 384); do
#     #echo "getting ensemble details for hsct hour" $fcst
#     #wgrib2  output1 -ens_processing output2 x
#     wgrib2  $MERGE_DIR/cmn_merged.t00z.pgrb2f${fcst} -ens_processing $OUT_DIR/all_stats/stats_ens.t00z.pgrb2f${fcst} 0
#     #echo "merged"
#     #echo "file available at: $OUT_DIR/BC_ens.t00z.pgrb2f${fcst}"
# done


# then we extract the ensemble mean from the statistics
# for fcst in $(seq -f "%03g" 0 6 384); do
#     #echo "extracting ensemble mean for hsct hour" $fcst
#     # extract ensemble mean from statistics
#     wgrib2 $OUT_DIR/all_stats/stats_ens.t00z.pgrb2f${fcst} -match  ":ens mean" -grib $OUT_DIR/ens_mean/cmn_ens_mean.t00z.pgrb2f${fcst}.grb
#     #echo "merged"
#     #echo "file available at: $OUT_DIR/BC_ens_mean.t00z.pgrb2f${fcst}.grb"
# done

# # cdo ensmean fileis file
# for fcst in $(seq -f "%03g" 0 6 384); do
#     cdo ensmean $MERGE_DIR/cmn_merged.t00z.pgrb2f${fcst} $OUT_DIR/ens_mean/cmn_ensmean.t00z.pgrb2f${fcst}

#     #cdo ensmean $MERGE_DIR/ncep_merged.t00z.pgrb2f${fcst} $OUT_DIR/ens_mean/ncep_ens_mean.t00z.pgrb2f${fcst}

# done

echo '!!!!!!!!!!  Ensemble averaging complete :) !!!!!!!!!!'


# To see what each forecast is
# for fcst in $(seq -f "%03g" 0 6 384); do
# echo $fcst
# done