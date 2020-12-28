gcc -O3 -fomit-frame-pointer -funroll-loops binarytrees.c -o bin_c -lm
g++ -fomit-frame-pointer -funroll-loops -std=c++11 binarytrees.cpp -O3 -o bin_cpp
crystal build binarytrees.cr --release -o bin_cr

cython3 --embed binarytrees.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

nuitka binarytrees.py -o bin_nuitka
