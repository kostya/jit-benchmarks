#!/bin/bash

crystal build brainfuck.cr --release -o bin_cr --no-debug
g++ -O3 -o bin_cpp brainfuck.cpp

cython --embed brainfuck.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`

