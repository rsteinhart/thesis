#!/bin/bash
#SBATCH -t 0-0:30 # ??
#SBATCH --mem-per-cpu=2000 # ??
#SBATCH --nodes=1
#SBATCH -n 1
#SBATCH --account=def-rstull # What do I change this to ??

module load StdEnv/2020  intel/2020.1.217  openmpi/4.0.3
module load wps/4.2

mpirun -np 1 geogrid.exe 1>geogrid.log 2>&1

#!/bin/bash
#SBATCH -t 0-01:00
#SBATCH --mem-per-cpu=2000
#SBATCH --nodes=1
#SBATCH -n 48
#SBATCH --account=def-rstull
