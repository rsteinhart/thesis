#!/bin/bash -l

IN_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files 
OUT_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test

if [ ! -d "$OUT_DIR/cmc_vars" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/cmc_vars
fi

if [ ! -d "$OUT_DIR/common_vars" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/common_vars
fi

# grab cmc specific variables
# for fcst in $(seq -f "%03g" 0 6 384); do
#       wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(UGRD|VGRD):(5000.0|10000.0|30000.0|40000.0) Pa:" -grib $OUT_DIR/cmc_vars/UV_cmc_merged.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(HGT):(5000.0|10000.0|30000.0) Pa:" -grib $OUT_DIR/cmc_vars/HGT_cmc_merged.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(TMP):(5000.0|10000.0) Pa:" -grib $OUT_DIR/cmc_vars/TMP_cmc_merged.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(RH):(5000.0|10000.0) Pa:" -grib $OUT_DIR/cmc_vars/RH_cmc_merged.t00z.pgrb2f${fcst}

#       wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(SNOD):" -grib $OUT_DIR/cmc_vars/HGT_cmc_merged.t00z.pgrb2f${fcst}
# done
 
# grab common cmc ncep variables
for fcst in $(seq -f "%03g" 0 6 384); do
      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(UGRD|VGRD):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common_vars/UV_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(HGT):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common_vars/HGT_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(TMP):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common_vars/TMP_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common_vars/RH_cmc_merged.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -grib $OUT_DIR/common_vars/other_cmc_merged.t00z.pgrb2f${fcst}
done

echo '!!!!!!!!!!!!! Data has been retreived :) !!!!!!!!!!!!!!!!'






