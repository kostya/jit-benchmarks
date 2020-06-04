gcc -O3 -fomit-frame-pointer -funroll-loops pidigits.c -o bin_c -lgmp
crystal build pidigits.cr --release -o bin_cr

cython --embed pidigits.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`
