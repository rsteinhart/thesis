#!/bin/bash -l

IN_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test/merged_files 
OUT_DIR=/Users/rsteinhart/DATA/test_data/NAEFS/cdo_test

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






