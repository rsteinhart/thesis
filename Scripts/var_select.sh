#!/bin/bash -l

IN_DIR = /Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files 
OUT_DIR = /Users/rsteinhart/DATA/test_data/NAEFS/cdo_test

if [ ! -d "$OUT_DIR/cmc_vars" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/cmc_vars
fi

for fcst in $(seq -f "%03g" 0 6 384); do
      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(UGRD|VGRD):(5000.0|10000.0|30000.0|40000.0) Pa:" -grib $OUT_DIR/cmc_vars/UV_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(HGT):(5000.0|10000.0|30000.0) Pa:" -grib $OUT_DIR/cmc_vars/HGT_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(TMP):(5000.0|10000.0) Pa:" -grib $OUT_DIR/cmc_vars/TMP_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(RH):(5000.0|10000.0) Pa:" -grib $OUT_DIR/cmc_vars/RH_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(SNOD):" -grib $OUT_DIR/cmc_vars/HGT_cmc_merged.t00z.pgrb2f${fcst}
done

echo '!!!!!!!!!!!!! Data has been retreived :) !!!!!!!!!!!!!!!!'

##############################################################################################

# vars=(":APCP:"
#       ":UGRD:10 m"
#       ":VGRD:10 m"
#       ":TMP:2 m"
#       ":RH:2 m"
#       ":PWAT:"
#       ":PRES:surface:"
#       ":TCDC:"
#       ":TMAX:"
#       ":TMIN:")
      
# var_parse=$(printf "%s|"  "${vars[@]}")
# var_parse="${var_parse%?}"
# wgrib2 <filename> -s | grep -E "($var_parse)" | wgrib2 -i <filename> -grib <outfilename>

############################################################################################

# #(6) How do I extract the 500 Heights from a file (grib->grib)?

#     wgrib -s grib_file | grep ":HGT:500 mb:" | wgrib -i -grib \
#           grib_file -o new_grib_file


# #(7) How do I eliminate the 500 Heights from a file (grib->grib)?

#     wgrib -s grib_file | grep -v ":HGT:500 mb:" | wgrib -i -grib \
#           grib_file -o new_grib_file


# #(8) How do I extract the winds and temperatures from a file (grib->grib)?

#     wgrib -s grib_file | egrep "(:UGRD:|:VGRD:|:TMP:)" | wgrib -i -grib \
#           grib_file -o new_grib_file 

#############################################################################################





