gcc -O3 -fomit-frame-pointer -funroll-loops spectralnorm.c -o bin_c -lm
crystal build spectralnorm.cr --release -o bin_cr


cython3 --embed spectralnorm.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.10/ -lpython3.10 -lm

python3 -m nuitka spectralnorm.py -o bin_nuitka

mypyc spectralnorm.py
echo '
#!/usr/bin/env bash
python3 -c "import spectralnorm" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc