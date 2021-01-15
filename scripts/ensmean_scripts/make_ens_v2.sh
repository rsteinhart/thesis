#!/bin/bash -l

source config.sh

echo "GRIB_DIR is $GRIB_DIR"
echo "OUT_DIR is $OUT_DIR"

echo 'Starting script to merge ensemble files'
echo 'System time is:' `date`

# exit when any command fails
# set -e

for fcst in $(seq -f "%03g" 0 6 384); do
    echo "cat-ing for fcst hour" $fcst
    # cat grib_file_1 grib_file_2 ... grib_file_N > output_grib_file
    cat $GRIB_DIR/*.t00z.pgrb2f${fcst} > $OUT_DIR/merged_files/merged.t00z.pgrb2f${fcst}.grb
    echo "file available at: $OUT_DIR/merged.t00z.pgrb2f${fcst}"
done

for fcst in $(seq -f "%03g" 0 6 384); do
    echo "sorting for fcst hour" $fcst
    # 
     wgrib2 merged.t00z.pgrb2f${fcst}.grb | \
       sort -t: -k5,5 -k4,4 |  \
       wgrib2 -i merged.t00z.pgrb2f${fcst}.grb -grib sort_merged.t00z.pgrb2f${fcst}.grb
    echo "file available at: $OUT_DIR/merged.t00z.pgrb2f${fcst}"
done


# then need to calc ensemble mean with -ens_processing
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "getting ensemble details for hsct hour" $fcst
    #wgrib2  output1 -ens_processing output2 x
    wgrib2  $OUT_DIR/merged_files/sort_merged.t00z.pgrb2f${fcst}.grb -ens_processing $OUT_DIR/all_stats/ens.t00z.pgrb2f${fcst} 0
    echo "ens_processing"
    echo "file available at: $OUT_DIR/BC_ens.t00z.pgrb2f${fcst}"
done


# then we extract the ensemble mean from the statistics
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "extracting ensemble mean for hsct hour" $fcst
    # extract ensemble mean from statistics
    wgrib2 $OUT_DIR/all_stats/ens.t00z.pgrb2f${fcst} -match  ":ens mean" -grib $OUT_DIR/ens_mean/ens_mean.t00z.pgrb2f${fcst}.grb
    echo "mean extracted"
    echo "file available at: $OUT_DIR/BC_ens_mean.t00z.pgrb2f${fcst}.grb"
done


### for sorting files after <cat>
"""
     wgrib2 IN.grb | \
       sed -e 's/:UGRD:/:UGRDa:/' -e 's/:VGRD:/:UGRDb:/' | \
       sort -t: -k3,3 -k6n,6 -k5,5 -k4,4 |  \
       wgrib2 -i IN.grb -grib OUT.grb


     line 1: makes standard inventory
     line 2: converts UGRD -> UGRDa and VGRD -> UGRDb 
      so VGRD should follow UGRD when sorted -  NOT USED
     line 3: sort by date code, forecast time, level and variable
     line 4: wgrib2 reads inventory, writes out grib file as sorted by inventory
"""