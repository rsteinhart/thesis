# Eve's cdo method to ensemble average
# June 2020
# this is a bash script / just run it in the terminal
# 
# So for the first bit I just manually chose the variables I wanted and put them in a loop. I loop through them, extract 
# the variable from the grib file and then append it to a new grib file. The loop is in the same order for both cmc and 
# ncep variables so the new grib files "${file}_out.grb" have the variables in the same order.... I still get warnings 
# that the variable names are not the same... but I don't think it matters too much seeing as the variables are in the 
# same order. 
for file in /Users/rsteinhart/DATA/test_data/NAEFS/grib_files/2019082700/*; do
    echo $file
    wgrib2 $file -match PRES -append -grib ${file}_out.grb
    wgrib2 $file -match TMP -append -grib ${file}_out.grb
    wgrib2 $file -match UGRD -append -grib ${file}_out.grb
    wgrib2 $file -match VGRD -append -grib ${file}_out.grb
    wgrib2 $file -match RH -append -grib ${file}_out.grb
    wgrib2 $file -match PWAT -append -grib ${file}_out.grb
    wgrib2 $file -match TCDC -append -grib ${file}_out.grb
    wgrib2 $file -match APCP -append -grib ${file}_out.grb
    wgrib2 $file -match WEASD -append -grib ${file}_out.grb
    wgrib2 $file -match PRMSL -append -grib ${file}_out.grb
    wgrib2 $file -match WEL -append -grib ${file}_out.grb
    wgrib2 $file -match SNOD -append -grib ${file}_out.grb

    wgrib2 $file -match HGT -append -grib ${file}_out.grb


done
# then you just run the cdo ensmean command with the new files you created. 
for fcst in $(seq -f "%03g" 0 6 384); do
    cdo ensmean *${fcst}_BC_out.grb cdo_out_mean_${fcst}

done

# (UGRD|VGRD|HGT|TMP|RH|WEASD|TCDC|PRES|PRMSL|PWAT|WEL|SNOD)