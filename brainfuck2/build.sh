#!/bin/sh

crystal build bf.cr --release -o bin_cr --no-debug
gcc -O3 -o bin_c bf.c


cython3 --embed bf.py -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

python3 -m nuitka bf.py -o bin_nuitka

mypyc bf.py
echo '
#!/usr/bin/env bash
python3 -c "import bf" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc