#!/bin/sh

crystal build bf.cr --release -o bin_cr --no-debug
gcc -O3 -o bin_c bf.c

cython --embed bf.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`

