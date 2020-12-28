gcc -O3 -fomit-frame-pointer -funroll-loops fannkuchredux.c -o bin_c
crystal build fannkuchredux.cr --release -o bin_cr

cython3 --embed fannkuchredux.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

nuitka fannkuchredux.py -o bin_nuitka
