#!/bin/sh

crystal build bf.cr --release -o bin_cr --no-debug
gcc -O3 -o bin_c bf.c


cython3 --embed bf.py -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

nuitka bf.py -o bin_nuitka
