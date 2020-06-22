#!/bin/bash -l

IN_DIR=/Volumes/Scratch/Rachel/NAEFS/grib_files/2019082700
OUT_DIR=/Volumes/Scratch/Rachel/NAEFS/ensmean

# if [ ! -d "$OUT_DIR/cmc_vars" ]; then
#     echo 'Output directory does not exist yet... creating directory'
#     mkdir $OUT_DIR/cmc_vars
# fi

if [ ! -d "$OUT_DIR/cmc_unq" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/cmc_unq
fi

if [ ! -d "$OUT_DIR/common" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/common
fi


#wgrib2 $file -match PRES -append -grib ${file}_out.grb
# grab cmc specific variables
for fcst in $(seq -f "%03g" 0 6 384); do
      wgrib2 $IN_DIR/cmc_*.t00z.pgrb2f${fcst}_BC -match ":(UGRD|VGRD):(5000.0|10000.0|30000.0|40000.0) Pa:" -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_*.t00z.pgrb2f${fcst}_BC -match ":(HGT):(5000.0|10000.0|30000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_*.t00z.pgrb2f${fcst}_BC -match ":(TMP):(5000.0|10000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_*.t00z.pgrb2f${fcst}_BC -match ":(RH):(5000.0|10000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/cmc_*.t00z.pgrb2f${fcst}_BC -match ":(SNOD):" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}
done
 
# grab common cmc ncep variables
for fcst in $(seq -f "%03g" 0 6 384); do
      wgrib2 $IN_DIR/*.t00z.pgrb2f${fcst}_BC -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common/common.t00z.pgrb2f${fcst}
    #   wgrib2 $IN_DIR/ncep_*.t00z.pgrb2f${fcst}_BC -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common/common.t00z.pgrb2f${fcst}
    

      wgrib2 $IN_DIR/*.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/common.t00z.pgrb2f${fcst}
    #   wgrib2 $IN_DIR/ncep_*.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/common.t00z.pgrb2f${fcst}

    #   wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(HGT):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common_vars/HGT_cmc_merged.t00z.pgrb2f${fcst}

    #   wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(TMP):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common_vars/TMP_cmc_merged.t00z.pgrb2f${fcst}

    #   wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -grib $OUT_DIR/common_vars/RH_cmc_merged.t00z.pgrb2f${fcst}

      # wgrib2 $IN_DIR/cmc_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -grib $OUT_DIR/common_vars/other_cmc_merged.t00z.pgrb2f${fcst}
done

echo '!!!!!!!!!!!!! Common and unique variables have been selected :) !!!!!!!!!!!!!!!!'






