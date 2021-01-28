#!/bin/bash
#SBATCH -t 0-1:00
#SBATCH --mem-per-cpu=2000
#SBATCH --nodes=1
#SBATCH -n 1
#SBATCH --account=rrg-rstull

module load wps/3.8.1

mpirun -np 1 metgrid.exe 1>metgrid.log 2>&1

