gcc -O3 -ffast-math -fomit-frame-pointer -funroll-loops mandelbrot.c -o bin_c
crystal build mandelbrot.cr --release -o bin_cr


cython3 --embed mandelbrot.pyx -o /tmp/cython3.c
gcc -O3 -g -o bin_cython3 /tmp/cython3.c -I/usr/include/python3.9/ -lpython3.9

python3 -m nuitka mandelbrot.py -o bin_nuitka

mypyc mandelbrot.py
echo '
#!/usr/bin/env bash
python3 -c "import mandelbrot" "$@"
' > ./run_mypyc && chmod +x ./run_mypyc