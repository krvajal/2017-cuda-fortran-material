# Pascal GPU
#COMPUTE_CAPABILITY=cc60

# Kepler GPU
COMPUTE_CAPABILITY=cc35

all: dgemm_gpu

dgemm_cpu: dgemm_test.F90 timer.o
	pgf90 dgemm_test.F90 timer.o -o dgemm_cpu -lblas

dgemm_gpu: dgemm_test.F90 timer.o
	pgf90 -DUSE_CUDA -Mcuda=${COMPUTE_CAPABILITY},cuda8.0 -Mcudalib=cublas dgemm_test.F90 timer.o -o dgemm_gpu

timer.o: timer.c
	gcc -c timer.c

clean:
	rm -f *.o dgemm_gpu
