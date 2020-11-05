gcc -O3 -ffast-math -fomit-frame-pointer -funroll-loops mandelbrot.c -o bin_c
crystal build mandelbrot.cr --release -o bin_cr


cython3 --embed mandelbrot.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.8/ -lpython3.8

nuitka mandelbrot.py --lto -o bin_nuitka
