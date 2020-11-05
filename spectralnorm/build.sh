gcc -O3 -fomit-frame-pointer -funroll-loops spectralnorm.c -o bin_c -lm
crystal build spectralnorm.cr --release -o bin_cr


cython3 --embed spectralnorm.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.8/ -lpython3.8 -lm

nuitka spectralnorm.py --lto -o bin_nuitka
