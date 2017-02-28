# environment to setup on Wilkes (login-gfx2)
# module purge
# module load default-wilkes
# module unload cuda intel/cce intel/fce intel/impi intel/mkl
# module load intel/mkl/11.3.3.210
# module load pgi/16.10
# module load openmpi/pgi/1.10.3
# module load cuda/8.0
# module load custom/magma/2.0.2 custom/lib-jdr/1.0

# Modify these entries as needed
#MKLROOT =
MAGMAROOT = ${MAGMA_ROOT}
CUDAROOT = ${CUDA_INSTALL_PATH}

# Enable -DACC to enable accuracy checking 
FLAGS = -O3 -mp -pgf90libs -Mcuda=cc35,cuda8.0 -Mlarge_arrays #-DACC

LIBS = -L${MKLROOT}/lib/intel64 -lmkl_intel_lp64 -lmkl_core -lmkl_pgi_thread -pgf90libs -lgomp -lm
LIBS += -L${MAGMAROOT}/lib -lmagma
LIBS += -L${CUDAROOT}/lib64 -lnvToolsExt -lcudart -lcublas -lcusolver


main:  main.F90 zhegst_jdr.F90 cusolverDn_m.cuf toolbox.F90 wallclock.c 
	pgcc -c ${FLAGS} wallclock.c
	pgf90 -c ${FLAGS} toolbox.F90
	pgf90 -c ${FLAGS} cusolverDn_m.cuf
	pgf90 -c ${FLAGS} zhegst_jdr.F90
	pgf90 -o main main.F90 zhegst_jdr.o cusolverDn_m.o toolbox.o wallclock.o ${LIBS} ${FLAGS} -pgf90libs -I${MAGMAROOT}/include -I${MKLROOT}/include 
clean:
	rm main *.mod *.o
