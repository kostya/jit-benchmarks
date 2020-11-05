if [ ! -f 1.txt ]; then
	sh generate.sh
fi

gcc -O3 -fomit-frame-pointer -o bin_c revcomp.c
crystal build revcomp.cr --release -o bin_cr

cython3 --embed revcomp.py -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.8/ -lpython3.8

nuitka revcomp.py --lto -o bin_nuitka