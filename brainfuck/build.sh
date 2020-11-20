#!/bin/bash

crystal build brainfuck.cr --release -o bin_cr --no-debug
g++ -O3 -o bin_cpp brainfuck.cpp

cython3 --embed brainfuck.py -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

nuitka brainfuck.py --lto -o bin_nuitka
