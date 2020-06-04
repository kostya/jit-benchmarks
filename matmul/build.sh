#!/bin/sh

crystal build matmul.cr --release -o bin_cr --no-debug
gcc -O3 -o bin_c matmul.c 

cython --embed matmul.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`

