#!/bin/bash -l

# ---------------------------------
## METGRID
path=/home/rachels/WRF4.2/WPS
month=08
#for month in $(seq -w 01 12)
#do
year=2020
for day in 04 #$(seq -w 01 31) #29 for feb
do
	
	if [ -f ${path}/${year}${month}${day}00.ungribOK ]; then # need to figure out how to make this file ??
		cp METGRID.TBL ${path}/${year}${month}${day}00
#		cp metgrid.sh ${path}/${year}${month}${day}00/metgrid_${month}${day}.sh
		cd ${path}/${year}${month}${day}00
		sbatch metgrid_${month}${day}.sh || exit 1 # created in wps_run_ungrib_rachel
		echo "Submitted METGRID for ${year} ${month} ${day}"
	fi

done
#done
