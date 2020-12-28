if [ ! -f 1.txt ]; then
	sh generate.sh
fi

#gcc -O3 -fomit-frame-pointer -o bin_c knucleotide.c
g++ -O3 -fomit-frame-pointer -o bin_cpp knucleotide.cpp
crystal build knucleotide.cr --release -o bin_cr

cython3 --embed knucleotide.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

nuitka knucleotide.py -o bin_nuitka
