#!/bin/bash
#SBATCH -t 0-1:30
#SBATCH --mem-per-cpu=4000
#SBATCH --nodes=1
#SBATCH -n 1
#SBATCH --account=rrg-rstull

module load StdEnv/2020  intel/2020.1.217  openmpi/4.0.3
module load wps/4.2

mpirun -np 1 ungrib.exe 1>ungrib.log 2>&1

