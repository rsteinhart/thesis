#!/bin/bash
#SBATCH -t 0-01:00
#SBATCH --mem-per-cpu=2000
#SBATCH --nodes=1
#SBATCH -n 48
#SBATCH --account=def-rstull

module load StdEnv/2020 intel/2020.1.217 openmpi/4.0.3
module load wrf/4.2

workdir=WORKDIR
cd $workdir

echo "Current working directory is `pwd`"

mpirun -np 1 real.exe 1>real_run.log 2>&1

time mpiexec wrf.exe 1>wrf.log 2>&1

