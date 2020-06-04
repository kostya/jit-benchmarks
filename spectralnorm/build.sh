gcc -O3 -fomit-frame-pointer -funroll-loops spectralnorm.c -o bin_c -lm
crystal build spectralnorm.cr --release -o bin_cr

cython --embed spectralnorm.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`

