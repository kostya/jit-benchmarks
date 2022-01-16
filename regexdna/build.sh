if [ ! -f 1.txt ]; then
	sh generate.sh
fi

gcc -O3 -fomit-frame-pointer -o bin_c regexdna.c -lpcre
crystal build regexdna.cr --release -o bin_cr


cython3 --embed regexdna.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

python3 -m nuitka regexdna.py -o bin_nuitka

mypyc regexdna.py
echo '
#!/usr/bin/env bash
python3 -c "import regexdna" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc