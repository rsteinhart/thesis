#!/bin/bash -l

# IN_DIR=/Volumes/Scratch/Rachel/NAEFS/grib_files
OUT_DIR=/Volumes/Scratch/Rachel/NAEFS/ensmean

# # grab common cmc ncep variables
# for fcst in $(seq -f "%03g" 0 6 384); do
#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -append -grib $OUT_DIR/common/cmc_common.t00z.pgrb2f${fcst}
#       wgrib2 $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst}_BC -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -append -grib $OUT_DIR/common/ncep_common.t00z.pgrb2f${fcst}
    

#       wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/cmc_common.t00z.pgrb2f${fcst}
#       wgrib2 $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/ncep_common.t00z.pgrb2f${fcst}

# done

for fcst in $(seq -f "%03g" 0 6 384); do
    # gmerge <to> <from>
    wgrib2 $OUT_DIR/common/common.t00z.pgrb2f${fcst} -match ":(UGRD|VGRD|HGT|TMP|RH|WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -grib $OUT_DIR/common/FINAL_common.t00z.pgrb2f${fcst}
    # gmerge $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst} $IN_DIR/ncep_*.t00z.pgrb2f${fcst}*

done

# path=/Users/rsteinhart/DATA/test_data/NAEFS/grib_files/2019082700/*

# for file in $path; do
#     echo $file
#     wgrib2 $file -match PRES -append -grib ${file}_out.grb
#     wgrib2 $file -match TMP -append -grib ${file}_out.grb
#     wgrib2 $file -match UGRD -append -grib ${file}_out.grb
#     wgrib2 $file -match VGRD -append -grib ${file}_out.grb
#     wgrib2 $file -match RH -append -grib ${file}_out.grb
#     wgrib2 $file -match PWAT -append -grib ${file}_out.grb
#     wgrib2 $file -match TCDC -append -grib ${file}_out.grb
#     wgrib2 $file -match APCP -append -grib ${file}_out.grb
#     wgrib2 $file -match WEASD -append -grib ${file}_out.grb
#     wgrib2 $file -match PRMSL -append -grib ${file}_out.grb
#     wgrib2 $file -match WEL -append -grib ${file}_out.grb
#     wgrib2 $file -match SNOD -append -grib ${file}_out.grb

#     wgrib2 $file -match HGT -append -grib ${file}_out.grb


# done

