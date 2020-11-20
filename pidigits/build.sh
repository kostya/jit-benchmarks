gcc -O3 -fomit-frame-pointer -funroll-loops pidigits.c -o bin_c -lgmp
crystal build pidigits.cr --release -o bin_cr

cython3 --embed pidigits.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9 -lgmp

nuitka pidigits.py --lto -o bin_nuitka
npm install mpzjs
