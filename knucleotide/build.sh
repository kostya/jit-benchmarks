if [ ! -f 1.txt ]; then
	sh generate.sh
fi

#gcc -O3 -fomit-frame-pointer -o bin_c knucleotide.c
g++ -O3 -fomit-frame-pointer -o bin_cpp knucleotide.cpp
crystal build knucleotide.cr --release -o bin_cr

cython --embed knucleotide.py -o /tmp/cython.c
gcc -O3 -g -o bin_cython /tmp/cython.c `python-config --includes --ldflags`
