gcc -O3 -fomit-frame-pointer -funroll-loops nbody.c -o bin_c -lm
crystal build nbody.cr --release -o bin_cr

cython --embed nbody.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`

