gcc -O3 -fomit-frame-pointer -funroll-loops fasta.c -o bin_c
crystal build fasta.cr --release -o bin_cr

cython3 --embed fasta.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.10/ -lpython3.10

python3 -m nuitka fasta.py -o bin_nuitka

mypyc fasta.py
echo '
#!/usr/bin/env bash
python3 -c "import fasta" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc