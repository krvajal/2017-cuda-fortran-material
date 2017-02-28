#!/bin/bash
#SBATCH -J NAME
#SBATCH -A TRAINING-GPU
#SBATCH --nodes=1
#SBATCH --ntasks=2
#SBATCH --time=1:00:00
#SBATCH --no-requeue
#SBATCH --partition=tesla
#SBATCH --reservation=cuda_fortran_tue

# EDIT ME ONLY IF YOU KNOW WHAT YOU ARE DOING ###############
. /etc/profile.d/modules.sh
module purge
module load default-wilkes
module unload cuda intel/cce intel/fce intel/impi intel/mkl
module load intel/mkl/11.3.3.210
module load pgi/16.10
module load openmpi/pgi/1.10.3
module load cuda/8.0
module load custom/magma/2.0.2 custom/lib-jdr/1.0
#############################################################

cd $SLURM_SUBMIT_DIR

export EXE="./pw-gpu-nvtx.x"
export PARAMS="-input ausurf_k.in"

export OMP_NUM_THREADS=6

mpirun -np 1 --bind-to none -x CUDA_VISIBLE_DEVICES=0 numactl --cpunodebind=0 nvprof -o prof.%h.%p ${EXE} ${PARAMS} : \
       -np 1 --bind-to none -x CUDA_VISIBLE_DEVICES=1 numactl --cpunodebind=1 nvprof -o prof.%h.%p ${EXE} ${PARAMS} : \
       2>&1 | tee out.GPU-NVTX.${SLURM_JOB_ID}
