gcc -O3 -fomit-frame-pointer -funroll-loops fasta.c -o bin_c
crystal build fasta.cr --release -o bin_cr

cython3 --embed fasta.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

nuitka fasta.py --lto -o bin_nuitka