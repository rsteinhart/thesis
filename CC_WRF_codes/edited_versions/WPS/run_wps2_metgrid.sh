#!/bin/bash -l

# ---------------------------------
## METGRID
path=/home/rachels/scratch/WPS
month=08
#for month in $(seq -w 01 12)
#do
year=2020
ibcs='GFS'
for day in $(seq -w 01 03) #29 for feb
do
	
	# if [ -f ${path}/${year}${month}${day}00.ungribOK ]; then # need to figure out how to make this file ??
		cp METGRID.TBL ${path}/${ibcs}/${year}${month}${day}00
#		cp metgrid.sh ${path}/${year}${month}${day}00/metgrid_${month}${day}.sh
		cd ${path}/${ibcs}/${year}${month}${day}00
		sbatch metgrid_${month}${day}.sh || exit 1 # created in wps_run_ungrib_rachel
		echo "Submitted METGRID for ${year} ${month} ${day}"
	# fi

done
#done
