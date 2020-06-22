#!/bin/bash -l

IN_DIR=/Volumes/Scratch/Rachel/NAEFS/grib_files
OUT_DIR=/Volumes/Scratch/Rachel/NAEFS/ensmean

# create the directory for merged original files
if [ ! -d "$IN_DIR/merged_2019082700" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $IN_DIR/merged_2019082700
fi

if [ ! -d "$OUT_DIR" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR
fi

# directory for UNIQUE cmc variable files
if [ ! -d "$OUT_DIR/cmc_unq" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/cmc_unq
fi

# directory for COMMON cmc and ncep files
if [ ! -d "$OUT_DIR/common" ]; then
    echo 'Output directory does not exist yet... creating directory'
    mkdir $OUT_DIR/common
fi

#### Now manipulate original forecast files ###########

# merge forecast files in order to match variables - only one file per $fcst permitted
# merge cmc and ncep files seperately to then make files of unique and common variables
for fcst in $(seq -f "%03g" 0 6 384); do
    # gmerge <to> <from>
    gmerge $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} $IN_DIR/2019082700/cmc_*.t00z.pgrb2f${fcst}*
    gmerge $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst} $IN_DIR/2019082700/ncep_*.t00z.pgrb2f${fcst}*

done

#wgrib2 $file -match PRES -append -grib ${file}_out.grb
# grab cmc specific variables
for fcst in $(seq -f "%03g" 0 6 384); do
      wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(UGRD|VGRD):(5000.0|10000.0|30000.0|40000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(HGT):(5000.0|10000.0|30000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(TMP):(5000.0|10000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(RH):(5000.0|10000.0) Pa:" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}

      wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(SNOD):" -append -grib $OUT_DIR/cmc_unq/cmc_unq.t00z.pgrb2f${fcst}
done
 
# grab common cmc ncep variables
for fcst in $(seq -f "%03g" 0 6 384); do
      wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f${fcst} -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -append -grib $OUT_DIR/common/cmc_common.t00z.pgrb2f${fcst}
      wgrib2 $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst}_BC -match ":(UGRD|VGRD|HGT|TMP|RH):(20000.0|25000.0|50000.0|70000.0|85000.0|92500.0|100000.0) Pa:" -append -grib $OUT_DIR/common/ncep_common.t00z.pgrb2f${fcst}
    

      wgrib2 $IN_DIR/merged_2019082700/cmc_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/cmc_common.t00z.pgrb2f${fcst}
      wgrib2 $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f$fcst -match ":(WEASD|TCDC|PRES|PRMSL|PWAT|WEL):" -append -grib $OUT_DIR/common/ncep_common.t00z.pgrb2f${fcst}

done

# merge the cmc and ncep common variable files 
for fcst in $(seq -f "%03g" 0 6 384); do
    # gmerge <to> <from>
    gmerge $OUT_DIR/common/common.t00z.pgrb2f${fcst} $OUT_DIR/common/*_common.t00z.pgrb2f${fcst}
    # gmerge $IN_DIR/merged_2019082700/ncep_merged.t00z.pgrb2f${fcst} $IN_DIR/ncep_*.t00z.pgrb2f${fcst}*

done


echo '!!!!!!!!!!!!! Common and unique variables have been selected :) !!!!!!!!!!!!!!!!'






