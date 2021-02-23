#!/bin/bash -l 


# script to submit a whole months (30ish runs) at once

ibc=GFS
month=08 # for August

for day in $(seq -w 01 31) # loops over days
do
	./wrf_run_rachel 2018 $month $day $ibc
done
