#!/bin/bash -l

# ---------------------------------

ibcs='GFS' # will this syntax work? 

## UNGRIB
for day in $(seq -w 01 3)
do
	./wps_run_ungrib_rachel 2020 08 $day $ibcs # currently setup for test GFS data from Aug2020
done


# Have UNGRIB ready before running METGRID!
# ---------------------------------
## METGRID
#path=/home/jeworrek/projects/rrg-rstull/jeworrek/wps/
#month=01
#year=2017
#for day in $(seq -w 01 31) #29 for feb
#do
#	sbatch ${path}/${year}${month}${day}/metgrid_${month}${day}.sh || exit 1
#	echo "Submitted METGRID for ${year} ${month} ${day}"
#done
