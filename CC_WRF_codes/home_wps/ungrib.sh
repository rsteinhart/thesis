#!/bin/bash
#SBATCH -t 0-1:30
#SBATCH --mem-per-cpu=4000
#SBATCH --nodes=1
#SBATCH -n 1
#SBATCH --account=rrg-rstull

module load wps/3.8.1

mpirun -np 1 ungrib.exe 1>ungrib.log 2>&1

