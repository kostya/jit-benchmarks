gcc -O3 -fomit-frame-pointer -funroll-loops fannkuchredux.c -o bin_c
crystal build fannkuchredux.cr --release -o bin_cr

cython --embed fannkuchredux.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`
