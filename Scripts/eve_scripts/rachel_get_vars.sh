#!/bin/bash -l

# Eve Wicksteed
# May 2020
# edited my script to work for Rachel...


# -------------------------------------------------- #

data_dir="/Volumes/Scratch/Rachel/NAEFS/grib_files/2019082700"

# -------------------------------------------------- #


for file in "$data_dir/"*; do
    echo $file
    wgrib2 $file -match ":HGT:" -append -grib ${file}_out.grb
    wgrib2 $file -match "PRES:surface" -append -grib ${file}_out.grb
    wgrib2 $file -match ":TMP:2 m" -append -grib ${file}_out.grb
    wgrib2 $file -match ":UGRD:10 m" -append -grib ${file}_out.grb
    wgrib2 $file -match ":VGRD:10 m" -append -grib ${file}_out.grb
    wgrib2 $file -match ":RH:2 m" -append -grib ${file}_out.grb
    wgrib2 $file -match ":PWAT:" -append -grib ${file}_out.grb
    wgrib2 $file -match ":TCDC:" -append -grib ${file}_out.grb
    wgrib2 $file -match ":APCP:" -append -grib ${file}_out.grb

done

# then you just run the cdo ensmean command with the new files you created. 

# then loop through fcst hrs to calc ens mean:
for fcst in $(seq -f "%03g" 0 6 384); do
    echo "calculating ensemble mean for fcst hour" $fcst
    echo ' '
    #echo `ls $data_dir*$fcst*_out.grb`
    #echo ls *fcst*out.grb
    #echo 'calc ens mean for' $data_dir*$fcst*_out.grb
    cdo ensmean $data_dir*$fcst*_out.grb ${data_dir}cdo_out_mean_$fcst
    echo 'saved as:' ${data_dir}cdo_out_mean_$fcst
done



echo ' '
echo ' '
echo '* * * * * * * * * * * * * *'
echo 'Script is finished running'
echo '* * * * * * * * * * * * * *'
