gcc -O3 -fomit-frame-pointer -funroll-loops fasta.c -o bin_c
crystal build fasta.cr --release -o bin_cr

cython --embed fasta2.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`
