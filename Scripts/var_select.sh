#!/bin/bash -l

vars=(":APCP:"
      ":UGRD:10 m"
      ":VGRD:10 m"
      ":TMP:2 m"
      ":RH:2 m"
      ":PWAT:"
      ":PRES:surface:"
      ":TCDC:"
      ":TMAX:"
      ":TMIN:")
      
var_parse=$(printf "%s|"  "${vars[@]}")
var_parse="${var_parse%?}"
wgrib2 <filename> -s | grep -E "($var_parse)" | wgrib2 -i <filename> -grib <outfilename>

#(6) How do I extract the 500 Heights from a file (grib->grib)?

    wgrib -s grib_file | grep ":HGT:500 mb:" | wgrib -i -grib \
          grib_file -o new_grib_file


#(7) How do I eliminate the 500 Heights from a file (grib->grib)?

    wgrib -s grib_file | grep -v ":HGT:500 mb:" | wgrib -i -grib \
          grib_file -o new_grib_file


#(8) How do I extract the winds and temperatures from a file (grib->grib)?

    wgrib -s grib_file | egrep "(:UGRD:|:VGRD:|:TMP:)" | wgrib -i -grib \
          grib_file -o new_grib_file 