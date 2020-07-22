#!/bin/bash -l

# Rachel Steinhart
# June 2020

# Script selects the unique variables from cmc and writes them to a file
# it also takes the common variables from cmc and ncep files and 
# writes them to a new file 

# Data is input directly from forecast grib files !!! currently this is
# just 2019082700 files but this will need to be generalized. !!!!!
# Data is output to the same directory as it is input


# -------------------------------------------------- #
data_dir="/Volumes/Scratch/Rachel/NAEFS/grib_files/2019082700"
out_dir="/Volumes/Scratch/Rachel/NAEFS/ensmean"

# -------------------------------------------------- #

# create the directory for merged original files
if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi


# -------------------------------------------------- #
# Select variables and write new files

# Common variables
for file in "$data_dir/"*; do
    echo $file
    if [[ "$file" == *"pgrb2f000"* ]]; then
        wgrib2 $file -match ":(UGRD|VGRD|HGT|TMP|RH):(200|250|500|700|850|925|1000) mb:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRES:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":WEASD" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRMSL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":VVEL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PWAT:" -append -grib ${file}_common_out.grb

    else 
        wgrib2 $file -match ":(UGRD|VGRD|HGT|TMP|RH):(200|250|500|700|850|925|1000) mb:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRES:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":WEASD" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PRMSL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":VVEL" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":PWAT:" -append -grib ${file}_common_out.grb
        wgrib2 $file -match ":TCDC:" -append -grib ${file}_common_out.grb

    fi 


done

# CMC specific variables
for file in "$data_dir/"*; do
    echo $file
    if [[ "$file" == *"pgrb2f000"* ]]; then
        wgrib2 $file -match ":(UGRD|VGRD):(50|100|300|400) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(HGT):(50|100|300) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(TMP):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(RH):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":SNOD:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":TCDC:" -append -grib ${file}_cmc_out.grb

    else 
        wgrib2 $file -match ":(UGRD|VGRD):(50|100|300|400) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(HGT):(50|100|300) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(TMP):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":(RH):(50|100) mb:" -append -grib ${file}_cmc_out.grb
        wgrib2 $file -match ":SNOD:" -append -grib ${file}_cmc_out.grb

    fi

done

echo ' '
echo ' '
echo '* * * * * * * * * * * * * *'
echo 'Script is finished running'
echo '* * * * * * * * * * * * * *'


# IN_DIR=/Volumes/Scratch/Rachel/NAEFS/grib_files
# OUT_DIR=/Volumes/Scratch/Rachel/NAEFS/ensmean


# # directory for UNIQUE cmc variable files
# if [ ! -d "$OUT_DIR/cmc_unq" ]; then
#     echo 'Output directory does not exist yet... creating directory'
#     mkdir $OUT_DIR/cmc_unq
# fi

# # directory for COMMON cmc and ncep files
# if [ ! -d "$OUT_DIR/common" ]; then
#     echo 'Output directory does not exist yet... creating directory'
#     mkdir $OUT_DIR/common
# fi

# # merge forecast files in order to match variables - only one file per $fcst permitted
# # merge cmc and ncep files seperately to then make files of unique and common variables
# for fcst in $(seq -f "%03g" 0 6 384); do
#     # gmerge <to> <from>
#     gmerge $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} $IN_DIR/2019082700/cmc_*.t00z.pgrb2f${fcst}*
#     gmerge $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst} $IN_DIR/2019082700/ncep_*.t00z.pgrb2f${fcst}*

# done

# #wgrib2 $file -match PRES -append -grib ${file}_out.grb
# # grab cmc specific variables
# for fcst in $(seq -f "%03g" 0 6 384); do
#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(UGRD|VGRD):(5000.0|10000.0|30000.0|40000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(HGT):(5000.0|10000.0|30000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(TMP):(5000.0|10000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(RH):(5000.0|10000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(SNOD):" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}
# done
 
# # grab common cmc ncep variables
# for fcst in $(seq -f "%03g" 0 6 384); do
#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -append -grib $OUT_DIR/common/cmc_common.t00z.pgrb2f${fcst}
#       wgrib2 $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst}_BC -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -append -grib $OUT_DIR/common/ncep_common.t00z.pgrb2f${fcst}
    

#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/cmc_common.t00z.pgrb2f${fcst}
#       wgrib2 $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/ncep_common.t00z.pgrb2f${fcst}

# done

# # merge the cmc and ncep common variable files 
# for fcst in $(seq -f "%03g" 0 6 384); do
#     # gmerge <to> <from>
#     gmerge $OUT_DIR/common/common.t00z.pgrb2f${fcst} $OUT_DIR/common/*_common.t00z.pgrb2f${fcst}
#     # gmerge $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst} $IN_DIR/ncep_*.t00z.pgrb2f${fcst}*

# done


# echo '!!!!!!!!!!!!! Common and unique variables have been selected :) !!!!!!!!!!!!!!!!'






