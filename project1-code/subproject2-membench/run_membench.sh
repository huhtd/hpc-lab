#!/bin/bash -l

#SBATCH --job-name=membench
#SBATCH --time=00:30:00
#SBATCH --nodes=1
#SBATCH --output=membench-%j.out
#SBATCH --error=membench-%j.err

# load modules
if command -v module 1>/dev/null 2>&1; then
   module load new
   module load gcc/6.3.0
fi

./membench | sed -e '/:/	s//: /g' -e '/  */	s//	/g' | cut -f2,4,6 > generic.xxx && sed -e '/sarlacc/ s//generic/' gnuplot.template > generic.gp

gnuplot generic.gp
