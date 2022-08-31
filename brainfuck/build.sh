#!/bin/bash

crystal build brainfuck.cr --release -o bin_cr --no-debug
g++ -O3 -o bin_cpp brainfuck.cpp

cython3 --embed brainfuck.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.10/ -lpython3.10

python3 -m nuitka brainfuck.py -o bin_nuitka

mypyc brainfuck.py
echo '
#!/usr/bin/env bash
python3 -c "import brainfuck" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc