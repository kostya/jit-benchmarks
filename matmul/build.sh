#!/bin/sh

npm install mpzjs

crystal build matmul.cr --release -o bin_cr --no-debug
gcc -O3 -o bin_c matmul.c 

cython3 --embed matmul.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

python3 -m nuitka matmul.py -o bin_nuitka

mypyc matmul.py
echo '
#!/usr/bin/env bash
python3 -c "import matmul" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc