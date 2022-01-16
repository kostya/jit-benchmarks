gcc -O3 -fomit-frame-pointer -funroll-loops nbody.c -o bin_c -lm
crystal build nbody.cr --release -o bin_cr


cython3 --embed nbody.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9 -lm

python3 -m nuitka nbody.py -o bin_nuitka

mypyc nbody.py
echo '
#!/usr/bin/env bash
python3 -c "import nbody" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc