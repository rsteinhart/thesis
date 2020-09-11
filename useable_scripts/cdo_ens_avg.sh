#!/bin/bash -l

# Rachel Steinhart
# June 2020

# Script is run after var_select.sh 

# Script calculates the ensemble mean for cmc and common cmc and ncep 
# variables

# !!!!!!!!!! Currently input data is from $data_dir and data is also 
# output to $out_dir

data_dir="/Volumes/Scratch/Rachel/NAEFS/grib_files/2020080100"
out_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean/2020080100"


if [ ! -d "$out_dir" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $out_dir
fi


# then loop through fcst hrs to calc ens mean:
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "calculating ensemble mean for fcst hour" $fcst
    echo ' '
    #echo `ls $data_dir*$fcst*_out.grb`
    #echo ls *fcst*out.grb
    #echo 'calc ens mean for' $data_dir*$fcst*_out.grb
    cdo ensmean $data_dir/*$fcst*_common_out.grb $out_dir/cdo_common_mean_$fcst
    echo 'saved as:' cdo_common_mean_$fcst

    cdo ensmean $data_dir/*$fcst*_cmc_out.grb $out_dir/cdo_cmc_mean_$fcst
    echo 'saved as:' cdo_cmc_mean_$fcst
done

# # then loop through fcst hrs to calc ens mean:
# for fcst in $(seq -f "%03g" 0 6 384); do
#     echo "calculating ensemble mean for fcst hour" $fcst
#     echo ' '
#     #echo `ls $data_dir*$fcst*_out.grb`
#     #echo ls *fcst*out.grb
#     #echo 'calc ens mean for' $data_dir*$fcst*_out.grb
#     cdo ensmean $data_dir/*$fcst*_cmc_out.grb $out_dir/cdo_cmc_mean_$fcst
#     echo 'saved as:' cdo_cmc_mean_$fcst
# done

echo ' '
echo ' '
echo '* * * * * * * * * * * * * *'
echo 'Script is finished running'
echo '* * * * * * * * * * * * * *'

# OUT_DIR=/Volumes/Scratch/Rachel/NAEFS/ensmean
# UNQ_DIR=/Volumes/Scratch/Rachel/NAEFS/ensmean/cmc_unq
# CMN_DIR=/Volumes/Scratch/Rachel/NAEFS/ensmean/common

# make ensemble mean of unique cmc variables
# for fcst in $(seq -f "%03g" 0 6 384); do
#     cdo ensmean $UNQ_DIR/cmc_unq.t00z.pgrb2f${fcst} $OUT_DIR/ens_mean/cmc_unq_mean.t00z.pgrb2f${fcst}
# done

# # make ensemble mean of common merged cmc & ncep variables
# for fcst in $(seq -f "%03g" 0 6 384); do
#     cdo ensmean $CMN_DIR/cmc_common.t00z.pgrb2f${fcst} $CMN_DIR/ncep_common.t00z.pgrb2f${fcst} $OUT_DIR/ens_mean/common_mean.t00z.pgrb2f${fcst}
# done


# for fcst in $(seq -f "%03g" 0 6 384); do
#     #gmerge output fcst1 fcst2 fcst3
#     gmerge $OUT_DIR/ens_mean/FULL_ensmean.t00z.pgrb2f${fcst} $OUT_DIR/ens_mean/*_mean.t00z.pgrb2f${fcst} 

# done


# echo '!!!!!!!!!!  Ensemble averaging complete :) !!!!!!!!!!'


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



# To see what each forecast is
# for fcst in $(seq -f "%03g" 0 6 384); do
# echo $fcst
# done