#!/bin/sh

npm install mpzjs

crystal build matmul.cr --release -o bin_cr --no-debug
gcc -O3 -o bin_c matmul.c 

cython3 --embed matmul.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

nuitka matmul.py --lto -o bin_nuitka