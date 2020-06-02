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