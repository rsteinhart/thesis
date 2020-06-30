#!/bin/bash -l

# Eve Wicksteed
# May 2020
# edited my script to work for Rachel...


# -------------------------------------------------- #

data_dir="/Volumes/Scratch/Rachel/NAEFS/grib_files/2019082700"
# out_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean/match"

# -------------------------------------------------- #

# Common variables
for file in "$data_dir/"*; do
    echo $file
    wgrib2 $file -match ":(UGRD|VGRD|HGT|TMP|RH):(200|250|500|700|850|925|1000) mb:" -append -grib ${file}_common_out.grb
    wgrib2 $file -match ":PRES:" -append -grib ${file}_common_out.grb
    wgrib2 $file -match ":WEASD" -append -grib ${file}_common_out.grb
    wgrib2 $file -match ":PRMSL" -append -grib ${file}_common_out.grb
    wgrib2 $file -match ":WEL" -append -grib ${file}_common_out.grb
    wgrib2 $file -match ":PWAT:" -append -grib ${file}_common_out.grb
    wgrib2 $file -match ":TCDC:" -append -grib ${file}_common_out.grb
    # wgrib2 $file -match ":APCP:" -append -grib ${file}_out.grb

    # wgrib2 $file -match ":VGRD:10 m" -append -grib ${file}_out.grb
    # wgrib2 $file -match ":RH:2 m" -append -grib ${file}_out.grb

done

# CMC specific variables
for file in "$data_dir/"*; do
    echo $file
    wgrib2 $file -match ":(UGRD|VGRD):(50|100|300|400) mb:" -append -grib ${file}_cmc_out.grb
    wgrib2 $file -match ":(HGT):(50|100|300) mb:" -append -grib ${file}_cmc_out.grb
    wgrib2 $file -match ":(TMP):(50|100) mb:" -append -grib ${file}_cmc_out.grb
    wgrib2 $file -match ":(RH):(50|100) mb:" -append -grib ${file}_cmc_out.grb
    wgrib2 $file -match ":SNOD:" -append -grib ${file}_cmc_out.grb
    # wgrib2 $file -match ":PWAT:" -append -grib ${file}_out.grb
    # wgrib2 $file -match ":TCDC:" -append -grib ${file}_out.grb
    # wgrib2 $file -match ":APCP:" -append -grib ${file}_out.grb

    # wgrib2 $file -match ":VGRD:10 m" -append -grib ${file}_out.grb
    # wgrib2 $file -match ":RH:2 m" -append -grib ${file}_out.grb

done

# then you just run the cdo ensmean command with the new files you created. 

# then loop through fcst hrs to calc ens mean:
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "calculating ensemble mean for fcst hour" $fcst
    echo ' '
    #echo `ls $data_dir*$fcst*_out.grb`
    #echo ls *fcst*out.grb
    #echo 'calc ens mean for' $data_dir*$fcst*_out.grb
    cdo ensmean $data_dir/*$fcst*_common_out.grb $data_dir/cdo_common_mean_$fcst
    echo 'saved as:' cdo_common_mean_$fcst
done

# then loop through fcst hrs to calc ens mean:
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "calculating ensemble mean for fcst hour" $fcst
    echo ' '
    #echo `ls $data_dir*$fcst*_out.grb`
    #echo ls *fcst*out.grb
    #echo 'calc ens mean for' $data_dir*$fcst*_out.grb
    cdo ensmean $data_dir/*$fcst*_common_out.grb $data_dir/cdo_cmc_mean_$fcst
    echo 'saved as:' cdo_cmc_mean_$fcst
done



echo ' '
echo ' '
echo '* * * * * * * * * * * * * *'
echo 'Script is finished running'
echo '* * * * * * * * * * * * * *'

# for sorting variables in the right order

# (21'') In the operational CFSv2 time series, V does not follow U and the forecasts
#      are not in order.
#      wgrib2 IN.grb | \
#        sed -e 's/:UGRD:/:UGRDa:/' -e 's/:VGRD:/:UGRDb:/' | \
#        sort -t: -k3,3 -k6n,6 -k5,5 -k4,4 |  \
#        wgrib2 -i IN.grb -grib OUT.grb
#      line 1: makes standard inventory
#      line 2: converts UGRD -> UGRDa and VGRD -> UGRDb 
#       so VGRD should follow UGRD when sorted
#      line 3: sort by date code, forecast time, level and variable
#      line 4: wgrib2 reads inventory, writes out grib file as sorted by inventory