# Benchmark for interpreted languages implementations.

Most programs from [benchmarks game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/index.html). All programs are chosen to be simplest, single-thread and without any low-level hacks. Also, the code for all languages trying to be implemented with one algorithm, use the same language constructs and containers, and be semantically similar to each other. The goal of the benchmark is to find the most successful JIT solutions. My other benchmarks: [Benchmarks](https://github.com/kostya/benchmarks), [Crystal Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game).

Compare:
		
		* Ruby (Ruby2.7, Ruby3, Graal, Topaz, JRuby, Rbx)
		* Python (Cpython, Graal, Pypy, Cython, Jython, Nuitka, Mypyc)
		* Lua (JIT)
		* Javascript (Node, Graal)
		* PHP8.1 (JIT)
		* C, Crystal as a basis

Running on AMD Ryzen 7 3800X, 16Gb DDR-4 3200 Mghz, host os Windows10, VirtualBox with Ubuntu 20.04.01, in docker with os Debian/Testing. (This looks like big overhead - vm in vm, but i also test in Docker on pure Ubuntu, and perfomance is the same, and surprisingly on Windows it sometimes even faster O_o, AMD-V is something awesome).

Build Docker image (5.2Gb):

		docker build -t jit-bench - <Dockerfile

Enter into execution env:

		docker run -it --rm -v $(pwd):/src -w /src jit-bench

To run and build test:
```
cd TEST-NAME
sh build.sh
ruby run.rb
```

Every test run code by 5 times, within one process, it allow to do some warnups for jitted languages.

## Binarytrees (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 0.49     | 0.53        | 0.0       | 17.13      |
| Crystal    |             | 0.53     | 0.56        | 0.0       | 28.79      |
| Ruby       | GraalVM_JVM | 0.79     | 1.78        | 2.2       | 735.74     |
| Python3    | Cython      | 0.85     | 0.93        | 0.0       | 24.05      |
| C          | gcc         | 0.92     | 1.01        | 0.0       | 49.78      |
| Ruby       | JRuby_InDy  | 1.11     | 1.62        | 1.7       | 661.44     |
| Ruby       | GraalVM     | 1.35     | 2.10        | 0.0       | 851.23     |
| Javascript | Node        | 1.54     | 1.99        | 0.1       | 158.03     |
| Javascript | GraalVM_JVM | 1.68     | 2.84        | 2.6       | 1031.63    |
| Ruby       | Topaz       | 2.17     | 2.38        | 0.0       | 63.11      |
| Python3    | GraalVM_JVM | 2.38     | 5.51        | 3.4       | 1246.96    |
| Javascript | GraalVM     | 2.66     | 3.44        | 0.3       | 583.58     |
| Ruby       | JRuby       | 3.11     | 3.44        | 1.7       | 601.77     |
| PHP        | JIT         | 3.39     | 4.02        | 0.0       | 76.29      |
| Python3    | GraalVM     | 3.77     | 4.83        | 0.1       | 980.24     |
| Python3    | Pypy        | 4.28     | 4.49        | 0.0       | 127.29     |
| Python2    | Pypy        | 4.33     | 4.55        | 0.0       | 140.69     |
| Ruby3      | JIT         | 4.49     | 4.56        | 0.1       | 296.88     |
| Ruby3      |             | 5.86     | 6.00        | 0.0       | 41.79      |
| PHP        |             | 6.31     | 7.12        | 0.0       | 73.04      |
| Ruby2.7    | JIT         | 6.31     | 6.46        | 0.0       | 38.06      |
| Ruby2.7    |             | 6.99     | 7.10        | 0.0       | 36.87      |
| Lua        | JIT         | 8.95     | 9.52        | 0.0       | 306.39     |
| Ruby       | Rbx         | 16.02    | 16.50       | 0.1       | 421.43     |
| Lua        |             | 20.26    | 24.77       | 0.0       | 169.86     |
| Python2    | Jython      | 26.10    | 26.73       | 1.2       | 1091.72    |
| Python3    | Mypyc       | 27.85    | 28.55       | 0.0       | 0.90       |
| Python3    | Nuitka      | 84.14    | 84.14       | 0.0       | 106.97     |
| Python3    |             | 85.46    | 85.46       | 0.0       | 104.43     |
| Python2    |             | > 100    | > 100       | 0.0       | 205.72     |


## Brainfuck (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 2.39     | 2.39        | 0.0       | 1.82       |
| Crystal    |             | 4.61     | 4.62        | 0.0       | 3.09       |
| Javascript | Node        | 5.23     | 5.91        | 0.1       | 47.17      |
| Python2    | Pypy        | 6.56     | 7.47        | 0.0       | 62.70      |
| Python3    | Pypy        | 9.13     | 10.09       | 0.0       | 65.08      |
| Ruby       | GraalVM_JVM | 16.16    | 17.48       | 1.9       | 417.24     |
| Ruby       | Topaz       | 16.71    | 16.80       | 0.0       | 29.44      |
| Ruby       | GraalVM     | 17.14    | 18.34       | 0.0       | 343.45     |
| Python3    | GraalVM_JVM | 36.43    | 37.80       | 3.8       | 602.15     |
| Python3    | GraalVM     | 39.88    | 42.92       | 0.3       | 979.85     |
| Ruby       | JRuby_InDy  | 53.83    | 55.90       | 1.5       | 375.97     |
| Javascript | GraalVM_JVM | 58.53    | 63.20       | 2.3       | 475.92     |
| Javascript | GraalVM     | 83.85    | 86.37       | 0.2       | 447.54     |
| Python3    | Mypyc       | 87.35    | 87.65       | 0.0       | 0.91       |
| Ruby2.7    | JIT         | 114.27   | 114.27      | 0.0       | 12.99      |
| Ruby3      | JIT         | 115.30   | 115.30      | 0.1       | 270.13     |
| Ruby2.7    |             | 123.52   | 123.52      | 0.0       | 12.77      |
| Ruby3      |             | 129.89   | 129.89      | 0.0       | 13.48      |
| Ruby       | JRuby       | 133.25   | 133.25      | 1.6       | 229.84     |
| Python3    | Nuitka      | 181.62   | 181.62      | 0.0       | 10.91      |
| Python3    | Cython      | > 190    | > 190       | 0.0       | 9.75       |
| Ruby       | Rbx         | > 190    | > 190       | 0.1       | 1011.47    |
| Python2    |             | > 190    | > 190       | 0.0       | 6.26       |
| Python3    |             | > 190    | > 190       | 0.0       | 9.36       |
| Python2    | Jython      | > 190    | > 190       | 1.1       | 511.75     |


## Brainfuck2 (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.25     | 1.25        | 0.0       | 0.83       |
| Crystal    |             | 2.10     | 2.10        | 0.0       | 3.07       |
| Javascript | Node        | 3.58     | 5.45        | 0.1       | 47.22      |
| Ruby       | GraalVM     | 6.22     | 8.80        | 0.0       | 636.66     |
| Ruby       | GraalVM_JVM | 6.79     | 8.33        | 1.9       | 573.39     |
| Lua        | JIT         | 7.79     | 8.31        | 0.0       | 2.36       |
| Python2    | Pypy        | 11.20    | 11.24       | 0.0       | 67.34      |
| Python3    | Pypy        | 11.21    | 11.44       | 0.1       | 72.53      |
| Javascript | GraalVM_JVM | 12.06    | 12.35       | 2.2       | 617.68     |
| Javascript | GraalVM     | 12.30    | 12.50       | 0.2       | 472.72     |
| Python3    | GraalVM_JVM | 13.07    | 13.99       | 3.7       | 652.48     |
| Python3    | GraalVM     | 13.87    | 14.34       | 0.4       | 802.73     |
| Ruby       | Topaz       | 22.92    | 23.16       | 0.0       | 31.67      |
| Ruby       | JRuby_InDy  | 43.32    | 44.01       | 1.6       | 281.75     |
| Ruby3      | JIT         | 49.41    | 49.55       | 0.1       | 270.15     |
| Lua        |             | 54.63    | 54.67       | 0.0       | 1.51       |
| Ruby2.7    | JIT         | 60.33    | 60.58       | 0.0       | 13.05      |
| Python3    | Mypyc       | 76.48    | 76.54       | 0.0       | 0.90       |
| Ruby       | JRuby       | 92.43    | 93.92       | 1.5       | 256.87     |
| Ruby3      |             | 117.25   | 117.25      | 0.0       | 13.40      |
| Ruby2.7    |             | 129.15   | 129.15      | 0.0       | 12.75      |
| Python3    | Nuitka      | 132.80   | 132.80      | 0.0       | 11.01      |
| Python3    |             | 142.49   | 142.49      | 0.0       | 9.52       |
| Python2    |             | 158.37   | 158.37      | 0.0       | 6.51       |
| Python2    | Jython      | 202.71   | 202.71      | 1.1       | 496.73     |
| Python3    | Cython      | > 215    | > 215       | 0.0       | 9.77       |
| Ruby       | Rbx         | > 215    | > 215       | 0.1       | 960.89     |


## Fannkuchredux (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.12     | 0.12        | 0.0       | 7.94       |
| Javascript | Node        | 0.15     | 0.18        | 0.1       | 46.74      |
| Javascript | GraalVM_JVM | 0.18     | 0.57        | 2.3       | 360.37     |
| Javascript | GraalVM     | 0.19     | 0.52        | 0.2       | 307.85     |
| C          | gcc         | 0.21     | 0.21        | 0.0       | 0.92       |
| Ruby       | GraalVM_JVM | 0.22     | 0.90        | 1.8       | 372.34     |
| Crystal    |             | 0.22     | 0.22        | 0.0       | 3.02       |
| Lua        | JIT         | 0.27     | 0.27        | 0.0       | 2.36       |
| Ruby       | GraalVM     | 0.30     | 0.62        | 0.0       | 320.94     |
| Python3    | GraalVM_JVM | 0.37     | 1.63        | 3.1       | 638.56     |
| Ruby       | Topaz       | 0.42     | 0.47        | 0.0       | 29.74      |
| Python3    | GraalVM     | 0.56     | 1.20        | 0.2       | 576.68     |
| Python2    | Pypy        | 0.67     | 0.68        | 0.0       | 66.00      |
| PHP        | JIT         | 0.74     | 0.75        | 0.0       | 20.28      |
| Ruby       | JRuby_InDy  | 1.08     | 1.76        | 1.5       | 238.11     |
| Lua        |             | 1.91     | 1.94        | 0.0       | 1.57       |
| Ruby       | JRuby       | 2.08     | 2.38        | 1.5       | 183.63     |
| PHP        |             | 2.46     | 2.49        | 0.0       | 17.12      |
| Python3    | Mypyc       | 2.82     | 2.82        | 0.0       | 0.94       |
| Python3    | Pypy        | 3.39     | 3.39        | 0.0       | 62.20      |
| Python3    | Nuitka      | 3.61     | 3.64        | 0.0       | 10.37      |
| Python2    |             | 3.72     | 3.73        | 0.0       | 6.44       |
| Python3    |             | 4.10     | 4.11        | 0.0       | 7.72       |
| Python2    | Jython      | 4.54     | 4.78        | 1.0       | 541.23     |
| Ruby2.7    | JIT         | 4.61     | 4.65        | 0.0       | 12.88      |
| Ruby2.7    |             | 4.68     | 4.70        | 0.0       | 12.80      |
| Ruby3      | JIT         | 5.50     | 5.53        | 0.1       | 270.10     |
| Ruby3      |             | 5.67     | 5.68        | 0.0       | 13.46      |
| Ruby       | Rbx         | > 60     | > 60        | 0.1       | 503.00     |


## Fasta (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.61     | 0.61        | 0.0       | 0.85       |
| Crystal    |             | 0.84     | 0.84        | 0.0       | 3.59       |
| Lua        | JIT         | 1.66     | 1.68        | 0.0       | 2.64       |
| PHP        | JIT         | 2.36     | 2.38        | 0.0       | 19.96      |
| Ruby       | GraalVM_JVM | 2.68     | 4.75        | 2.3       | 452.70     |
| Python2    | Pypy        | 2.86     | 2.91        | 0.2       | 68.98      |
| Python3    | Pypy        | 3.19     | 3.26        | 0.2       | 67.34      |
| Javascript | Node        | 3.62     | 3.68        | 0.2       | 54.61      |
| Lua        |             | 3.62     | 3.66        | 0.0       | 1.55       |
| Ruby       | GraalVM     | 3.68     | 4.54        | 0.4       | 643.29     |
| Ruby       | Topaz       | 4.04     | 4.14        | 0.1       | 41.01      |
| PHP        |             | 4.17     | 4.19        | 0.0       | 16.84      |
| Python3    | GraalVM_JVM | 4.60     | 9.47        | 3.7       | 888.45     |
| Python3    | GraalVM     | 5.83     | 8.94        | 0.7       | 652.46     |
| Python3    | Mypyc       | 6.63     | 6.65        | 0.0       | 0.86       |
| Python3    | Cython      | 7.03     | 7.04        | 0.0       | 8.71       |
| Python3    |             | 8.78     | 8.81        | 0.0       | 7.82       |
| Javascript | GraalVM_JVM | 9.05     | 16.44       | 2.4       | 634.11     |
| Python3    | Nuitka      | 10.74    | 10.81       | 0.0       | 10.41      |
| Python2    |             | 11.51    | 11.56       | 0.0       | 19.57      |
| Javascript | GraalVM     | 12.57    | 16.18       | 0.5       | 724.18     |
| Ruby3      | JIT         | 13.01    | 13.08       | 0.1       | 289.62     |
| Ruby3      |             | 16.93    | 17.14       | 0.1       | 33.21      |
| Ruby2.7    | JIT         | 16.95    | 17.23       | 0.0       | 51.37      |
| Ruby2.7    |             | 18.15    | 18.22       | 0.0       | 51.06      |
| Ruby       | JRuby       | 23.31    | 23.44       | 1.7       | 269.59     |
| Ruby       | JRuby_InDy  | 24.52    | 24.66       | 1.5       | 253.64     |
| Python2    | Jython      | 35.87    | 36.16       | 1.3       | 566.05     |
| Ruby       | Rbx         | > 80     | > 80        | 0.2       | 539.82     |


## Knucleotide (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Lua        | JIT         | 0.71     | 0.93        | 0.0       | 51.80      |
| Python2    | Pypy        | 2.04     | 2.06        | 0.1       | 137.68     |
| PHP        | JIT         | 2.08     | 2.12        | 0.0       | 47.90      |
| C++        | g++         | 2.22     | 2.28        | 0.2       | 30.75      |
| Crystal    |             | 2.48     | 2.53        | 0.0       | 59.52      |
| PHP        |             | 3.11     | 3.21        | 0.0       | 44.55      |
| Python3    | Pypy        | 3.54     | 3.63        | 0.1       | 149.45     |
| Lua        |             | 3.92     | 3.96        | 0.1       | 63.43      |
| Ruby       | Topaz       | 5.02     | 5.09        | 0.2       | 118.65     |
| Javascript | Node        | 5.25     | 6.13        | 0.2       | 166.65     |
| Python3    | GraalVM_JVM | 5.32     | 9.13        | 4.0       | 794.19     |
| Ruby       | GraalVM_JVM | 5.66     | 9.62        | 3.0       | 1126.73    |
| Python3    | GraalVM     | 6.10     | 8.63        | 0.5       | 632.56     |
| Python2    |             | 6.81     | 6.86        | 0.1       | 262.95     |
| Javascript | GraalVM_JVM | 7.96     | 8.87        | 4.9       | 852.20     |
| Python3    | Cython      | 8.42     | 8.45        | 0.1       | 49.54      |
| Python3    | Nuitka      | 8.83     | 9.01        | 0.1       | 51.34      |
| Python3    |             | 8.83     | 8.94        | 0.1       | 49.12      |
| Python3    | Mypyc       | 8.87     | 8.94        | 0.1       | 0.86       |
| Ruby       | JRuby       | 8.92     | 9.51        | 1.6       | 453.62     |
| Python2    | Jython      | 9.03     | 9.70        | 1.3       | 1424.46    |
| Ruby       | GraalVM     | 9.14     | 13.93       | 0.8       | 966.93     |
| Ruby2.7    | JIT         | 9.91     | 10.05       | 0.1       | 61.64      |
| Ruby       | JRuby_InDy  | 10.09    | 10.33       | 1.7       | 331.23     |
| Ruby3      | JIT         | 11.19    | 11.36       | 0.2       | 339.49     |
| Ruby2.7    |             | 12.80    | 13.12       | 0.1       | 62.22      |
| Javascript | GraalVM     | 13.16    | 13.80       | 2.1       | 563.96     |
| Ruby3      |             | 13.19    | 13.35       | 0.1       | 84.01      |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 492.30     |


## Mandelbrot (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.44     | 0.44        | 0.0       | 0.87       |
| Crystal    |             | 0.46     | 0.46        | 0.0       | 3.10       |
| Python3    | Cython      | 0.46     | 0.46        | 0.0       | 7.92       |
| Javascript | Node        | 0.47     | 0.48        | 0.1       | 80.89      |
| Lua        | JIT         | 0.50     | 0.50        | 0.0       | 1.18       |
| Python3    | Pypy        | 0.54     | 1.68        | 0.0       | 82.46      |
| Python2    | Pypy        | 0.55     | 1.78        | 0.0       | 87.63      |
| Javascript | GraalVM     | 0.58     | 1.83        | 0.2       | 743.90     |
| Javascript | GraalVM_JVM | 0.61     | 1.81        | 2.3       | 555.58     |
| PHP        | JIT         | 0.62     | 0.63        | 0.0       | 20.36      |
| Ruby       | GraalVM_JVM | 0.90     | 2.84        | 1.9       | 396.94     |
| Ruby       | GraalVM     | 0.91     | 2.16        | 0.0       | 409.89     |
| Ruby       | Topaz       | 0.97     | 0.99        | 0.0       | 26.37      |
| Python3    | GraalVM_JVM | 1.05     | 1.91        | 2.9       | 462.76     |
| Python3    | GraalVM     | 1.18     | 1.54        | 0.1       | 404.30     |
| Lua        |             | 5.21     | 5.25        | 0.0       | 1.58       |
| Ruby       | JRuby_InDy  | 5.29     | 6.46        | 1.5       | 496.64     |
| PHP        |             | 5.54     | 5.58        | 0.0       | 17.20      |
| Python2    | Jython      | 11.64    | 32.43       | 1.0       | 642.36     |
| Ruby       | JRuby       | 14.23    | 16.20       | 1.5       | 412.27     |
| Ruby2.7    |             | 16.77    | 16.81       | 0.0       | 12.87      |
| Ruby2.7    | JIT         | 16.77    | 16.80       | 0.0       | 12.97      |
| Ruby3      | JIT         | 19.00    | 19.24       | 0.1       | 269.98     |
| Ruby3      |             | 19.02    | 19.19       | 0.0       | 13.41      |
| Python3    | Mypyc       | 22.26    | 22.50       | 0.0       | 0.89       |
| Python3    | Nuitka      | 27.76    | 27.85       | 0.0       | 18.93      |
| Python3    |             | 30.40    | 30.55       | 0.0       | 16.57      |
| Python2    |             | 33.92    | 34.04       | 0.0       | 15.15      |
| Ruby       | Rbx         | > 120    | > 120       | 0.1       | 798.01     |


## Matmul (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.24     | 0.24        | 0.0       | 16.51      |
| Crystal    |             | 0.26     | 0.26        | 0.0       | 22.21      |
| Javascript | Node        | 0.26     | 0.28        | 0.1       | 97.50      |
| Lua        | JIT         | 0.27     | 0.29        | 0.0       | 68.40      |
| Javascript | GraalVM_JVM | 0.30     | 4.44        | 2.5       | 368.36     |
| Python2    | Pypy        | 0.35     | 0.36        | 0.0       | 85.20      |
| Python3    | Pypy        | 0.35     | 0.38        | 0.0       | 85.87      |
| Python3    | Cython      | 0.39     | 0.39        | 0.0       | 84.11      |
| Javascript | GraalVM     | 0.51     | 4.32        | 0.2       | 440.45     |
| Ruby       | GraalVM_JVM | 0.82     | 2.12        | 1.8       | 691.68     |
| Ruby       | GraalVM     | 0.91     | 1.85        | 0.0       | 583.70     |
| Python3    | GraalVM_JVM | 0.95     | 2.71        | 3.5       | 577.87     |
| Python3    | GraalVM     | 1.38     | 1.81        | 0.2       | 495.98     |
| Ruby       | Topaz       | 1.82     | 1.93        | 0.0       | 88.70      |
| Lua        |             | 5.79     | 5.86        | 0.0       | 74.28      |
| Ruby3      | JIT         | 15.15    | 15.19       | 0.1       | 315.75     |
| Ruby3      |             | 17.00    | 17.09       | 0.0       | 59.05      |
| Ruby2.7    |             | 18.72    | 18.79       | 0.0       | 58.21      |
| Python2    |             | 21.19    | 21.56       | 0.0       | 21.94      |
| Ruby2.7    | JIT         | 21.35    | 21.38       | 0.0       | 58.51      |
| Python3    |             | 22.29    | 22.34       | 0.0       | 25.12      |
| Ruby       | JRuby_InDy  | 22.36    | 28.75       | 1.4       | 631.88     |
| Python3    | Nuitka      | 23.16    | 23.18       | 0.0       | 26.58      |
| Python3    | Mypyc       | 24.20    | 24.41       | 0.0       | 0.86       |
| Ruby       | JRuby       | 34.02    | 35.36       | 1.5       | 622.56     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 720.04     |
| Python2    | Jython      | > 80     | > 80        | 1.1       | 448.25     |


## Nbody (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Mypyc       | 0.00     | 0.00        | 0.0       | 0.00       |
| C          | gcc         | 0.62     | 0.62        | 0.0       | 1.12       |
| Python3    | Cython      | 0.68     | 0.68        | 0.0       | 7.87       |
| Crystal    |             | 0.77     | 0.77        | 0.0       | 3.04       |
| Javascript | Node        | 0.81     | 0.83        | 0.1       | 49.30      |
| Ruby       | GraalVM_JVM | 0.84     | 1.65        | 1.7       | 372.11     |
| Ruby       | GraalVM     | 0.89     | 1.32        | 0.1       | 359.63     |
| Lua        | JIT         | 1.20     | 1.20        | 0.0       | 2.45       |
| Python3    | GraalVM_JVM | 3.33     | 4.45        | 2.9       | 563.98     |
| Python3    | GraalVM     | 4.15     | 4.48        | 0.2       | 410.74     |
| Javascript | GraalVM     | 4.95     | 5.55        | 0.2       | 569.82     |
| Ruby       | Topaz       | 5.37     | 9.01        | 0.0       | 33.39      |
| Javascript | GraalVM_JVM | 5.78     | 5.90        | 2.2       | 608.08     |
| Python2    | Pypy        | 7.24     | 7.31        | 0.0       | 67.18      |
| Ruby       | JRuby_InDy  | 7.65     | 8.33        | 1.5       | 413.94     |
| PHP        | JIT         | 15.00    | 15.43       | 0.0       | 20.12      |
| Lua        |             | 16.29    | 16.31       | 0.0       | 1.58       |
| PHP        |             | 22.00    | 22.12       | 0.0       | 17.14      |
| Ruby3      | JIT         | 27.71    | 27.76       | 0.1       | 270.25     |
| Python3    | Pypy        | 34.76    | 34.76       | 0.0       | 66.45      |
| Ruby2.7    | JIT         | 35.78    | 35.89       | 0.0       | 13.09      |
| Ruby2.7    |             | 42.74    | 42.74       | 0.0       | 12.89      |
| Ruby3      |             | 44.34    | 44.34       | 0.0       | 13.48      |
| Ruby       | JRuby       | 50.36    | 50.36       | 1.5       | 302.13     |
| Python3    |             | 53.37    | 53.37       | 0.0       | 8.37       |
| Python2    |             | 56.95    | 56.95       | 0.0       | 286.49     |
| Python2    | Jython      | 61.16    | 61.16       | 1.0       | 1036.18    |
| Python3    | Nuitka      | 64.52    | 64.52       | 0.0       | 10.45      |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 615.19     |


## Pidigits (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.68     | 1.72        | 0.0       | 5.46       |
| PHP        | JIT         | 1.69     | 1.70        | 0.0       | 21.91      |
| PHP        |             | 1.72     | 1.72        | 0.0       | 18.79      |
| Python3    | Cython      | 1.83     | 1.86        | 0.0       | 11.47      |
| Javascript | Node        | 2.17     | 2.20        | 0.1       | 51.81      |
| Javascript | GraalVM     | 3.06     | 3.31        | 0.3       | 438.21     |
| Javascript | GraalVM_JVM | 3.75     | 4.22        | 2.5       | 561.90     |
| Python3    |             | 6.13     | 6.15        | 0.0       | 9.54       |
| Python2    |             | 6.30     | 6.34        | 0.0       | 7.64       |
| Python3    | Mypyc       | 6.39     | 6.52        | 0.0       | 0.89       |
| Python3    | Nuitka      | 7.18     | 7.30        | 0.0       | 11.90      |
| Python2    | Pypy        | 8.07     | 8.12        | 0.0       | 70.74      |
| Crystal    |             | 8.16     | 9.24        | 0.0       | 8.54       |
| Ruby       | GraalVM_JVM | 8.28     | 8.97        | 1.8       | 620.43     |
| Python3    | Pypy        | 8.31     | 8.76        | 0.0       | 67.10      |
| Ruby       | Topaz       | 8.67     | 8.91        | 0.0       | 35.10      |
| Ruby       | JRuby       | 9.62     | 10.25       | 1.8       | 456.36     |
| Python2    | Jython      | 9.70     | 10.33       | 1.1       | 751.76     |
| Ruby       | JRuby_InDy  | 9.87     | 10.96       | 1.7       | 422.26     |
| Python3    | GraalVM_JVM | 10.16    | 11.03       | 2.9       | 830.80     |
| Ruby3      |             | 11.24    | 11.36       | 0.0       | 79.96      |
| Ruby       | GraalVM     | 11.32    | 12.17       | 0.0       | 457.70     |
| Ruby3      | JIT         | 11.60    | 11.76       | 0.1       | 337.55     |
| Ruby2.7    | JIT         | 12.38    | 12.69       | 0.0       | 162.57     |
| Ruby2.7    |             | 12.52    | 12.80       | 0.0       | 163.53     |
| Python3    | GraalVM     | 15.28    | 15.52       | 0.1       | 783.64     |
| Ruby       | Rbx         | 26.11    | 26.15       | 0.1       | 89.37      |


## Regexdna (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Javascript | Node        | 0.48     | 1.19        | 0.6       | 521.34     |
| Crystal    |             | 1.35     | 1.42        | 0.1       | 408.43     |
| PHP        | JIT         | 1.46     | 1.55        | 0.0       | 141.84     |
| PHP        |             | 1.48     | 1.61        | 0.0       | 149.96     |
| Ruby       | GraalVM_JVM | 1.75     | 5.51        | 3.5       | 1683.73    |
| Ruby       | GraalVM     | 1.76     | 9.26        | 1.3       | 2245.06    |
| Python2    | Pypy        | 2.23     | 2.37        | 0.1       | 337.23     |
| Ruby       | Topaz       | 2.41     | 3.24        | 0.4       | 440.80     |
| Javascript | GraalVM_JVM | 2.74     | 8.97        | 8.0       | 2030.14    |
| Javascript | GraalVM     | 2.93     | 10.84       | 3.3       | 1125.98    |
| Python3    | GraalVM_JVM | 2.94     | 13.03       | 7.1       | 1715.58    |
| Python3    | GraalVM     | 3.83     | 14.58       | 2.2       | 971.43     |
| Python3    | Mypyc       | 5.39     | 5.58        | 0.9       | 0.90       |
| Python3    |             | 5.39     | 5.51        | 0.9       | 182.58     |
| C          | gcc         | 5.76     | 6.53        | 0.1       | 90.18      |
| Python2    |             | 5.80     | 5.83        | 0.9       | 176.14     |
| Python3    | Nuitka      | 6.29     | 6.46        | 1.1       | 192.32     |
| Python3    | Cython      | 6.30     | 6.44        | 0.4       | 227.84     |
| Ruby2.7    |             | 6.36     | 6.72        | 0.2       | 181.19     |
| Ruby2.7    | JIT         | 6.40     | 6.70        | 0.2       | 181.21     |
| Ruby3      | JIT         | 6.40     | 6.71        | 0.4       | 394.42     |
| Ruby3      |             | 6.43     | 6.59        | 0.3       | 138.18     |
| Ruby       | Rbx         | 7.25     | 12.70       | 1.8       | 429.80     |
| Python2    | Jython      | 7.33     | 7.59        | 2.4       | 1590.71    |
| Lua        | JIT         | 9.31     | 9.56        | 0.6       | 296.72     |
| Lua        |             | 9.89     | 10.01       | 0.6       | 272.61     |
| Ruby       | JRuby_InDy  | 10.33    | 11.85       | 2.1       | 431.35     |
| Ruby       | JRuby       | 11.12    | 12.83       | 2.2       | 425.13     |
| Python3    | Pypy        | 11.90    | 11.90       | 0.2       | 337.09     |


## Revcomp (1 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.43     | 0.43        | 0.0       | 135.37     |
| Python2    |             | 1.93     | 1.93        | 0.0       | 860.95     |
| Python3    |             | 2.02     | 2.02        | 0.0       | 1178.11    |
| Python3    | Cython      | 2.22     | 2.22        | 0.0       | 1178.24    |
| Python3    | Nuitka      | 2.23     | 2.23        | 0.0       | 1180.61    |
| Python2    | Pypy        | 2.45     | 2.45        | 0.0       | 1310.29    |
| Lua        | JIT         | 2.82     | 2.82        | 0.0       | 309.45     |
| Javascript | Node        | 3.37     | 3.37        | 0.0       | 238.74     |
| Crystal    |             | 3.51     | 3.51        | 0.0       | 916.68     |
| Python3    | Pypy        | 3.67     | 3.67        | 0.0       | 1447.68    |
| Ruby2.7    | JIT         | 4.11     | 4.11        | 0.0       | 156.21     |
| Ruby       | Topaz       | 4.21     | 4.21        | 0.0       | 821.65     |
| Ruby3      | JIT         | 4.21     | 4.21        | 0.0       | 413.25     |
| Ruby2.7    |             | 4.23     | 4.23        | 0.0       | 156.02     |
| Ruby3      |             | 4.49     | 4.49        | 0.0       | 156.78     |
| Ruby       | JRuby       | 6.68     | 6.68        | 0.0       | 845.75     |
| Ruby       | JRuby_InDy  | 6.85     | 6.85        | 0.0       | 848.81     |
| Javascript | GraalVM     | 7.30     | 7.30        | 0.0       | 850.46     |
| Lua        |             | 8.01     | 8.01        | 0.0       | 806.39     |
| Python3    | GraalVM     | 10.61    | 10.61       | 0.0       | 2960.84    |
| Javascript | GraalVM_JVM | 11.19    | 11.19       | 0.0       | 1084.74    |
| Ruby       | GraalVM     | 12.04    | 12.04       | 0.0       | 1763.94    |
| Ruby       | GraalVM_JVM | 12.75    | 12.75       | 0.0       | 1616.79    |
| Python3    | Mypyc       | crashed  | crashed     | crashed   | 0.00       |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 494.18     |
| Python3    | GraalVM_JVM | crashed  | crashed     | crashed   | 1693.42    |
| Python2    | Jython      | crashed  | crashed     | crashed   | 1541.06    |
| PHP        |             | 435.18   |
| PHP        | JIT         | 446.30   |


## Spectralnorm (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.11     | 0.11        | 0.0       | 1.12       |
| Python3    | Cython      | 0.11     | 0.11        | 0.0       | 10.28      |
| Javascript | Node        | 0.11     | 0.12        | 0.1       | 47.90      |
| Crystal    |             | 0.12     | 0.12        | 0.0       | 3.97       |
| Lua        | JIT         | 0.12     | 0.13        | 0.0       | 2.44       |
| Javascript | GraalVM     | 0.29     | 0.78        | 0.2       | 461.41     |
| Javascript | GraalVM_JVM | 0.31     | 0.82        | 2.3       | 587.86     |
| Ruby       | GraalVM_JVM | 0.51     | 0.80        | 1.8       | 387.41     |
| Ruby       | GraalVM     | 0.61     | 0.69        | 0.0       | 346.27     |
| Python2    | Pypy        | 0.65     | 0.67        | 0.0       | 67.29      |
| Python3    | Pypy        | 0.72     | 0.75        | 0.0       | 64.18      |
| Python3    | GraalVM_JVM | 1.22     | 6.95        | 3.1       | 710.64     |
| Ruby       | Topaz       | 1.49     | 1.55        | 0.0       | 31.72      |
| Python3    | GraalVM     | 1.63     | 4.96        | 0.1       | 870.30     |
| Lua        |             | 4.26     | 4.30        | 0.0       | 2.88       |
| Ruby       | JRuby_InDy  | 4.61     | 4.90        | 1.5       | 463.41     |
| PHP        | JIT         | 5.36     | 5.78        | 0.0       | 20.88      |
| PHP        |             | 6.84     | 6.88        | 0.0       | 17.42      |
| Ruby3      | JIT         | 10.39    | 10.46       | 0.1       | 270.91     |
| Ruby       | JRuby       | 11.41    | 11.76       | 1.5       | 417.57     |
| Ruby2.7    | JIT         | 12.81    | 13.22       | 0.0       | 14.23      |
| Python2    |             | 13.93    | 14.03       | 0.0       | 6.93       |
| Python3    | Mypyc       | 14.45    | 14.53       | 0.0       | 0.95       |
| Ruby3      |             | 15.96    | 16.03       | 0.0       | 14.50      |
| Ruby2.7    |             | 16.53    | 16.59       | 0.0       | 13.56      |
| Python3    |             | 19.56    | 19.62       | 0.0       | 8.56       |
| Python3    | Nuitka      | 20.30    | 20.48       | 0.0       | 11.05      |
| Python2    | Jython      | 40.56    | 40.56       | 1.1       | 497.09     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 614.71     |


## Versions: 
* `Python 2.7.18`
* `Python 3.10.6`
* `Crystal 1.5.0 [994c70b10] (2022-07-06)`
* `gcc (Debian 12.2.0-1) 12.2.0`
* `g++ (Debian 12.2.0-1) 12.2.0`
* `Lua 5.4.4  Copyright (C) 1994-2022 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2022 Mike Pall. https://luajit.org/`
* `Nodejs v18.7.0`
* `ruby 2.7.6p219 (2022-04-12 revision c9c2245c0a) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev d9acd472) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.3.7.0 (2.6.8) 2022-08-16 c79ef237e0 OpenJDK 64-Bit Server VM 17.0.4+8-Debian-1 on 17.0.4+8-Debian-1 +jit [x86_64-linux]`
* `Cython version 0.29.30`
* `truffleruby 22.2.0, like ruby 3.0.3, GraalVM CE Native [x86_64-linux]`
* `truffleruby 22.2.0, like ruby 3.0.3, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.18 (b89256933b0b, Oct 04 2021, 15:22:08) [PyPy 7.3.6 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.9.12 (05fbe3aa5b0845e6c37239768aa455451aa5faba, Mar 29 2022, 08:15:34) [PyPy 7.3.9 with GCC 10.2.1 20210130 (Red Hat 10.2.1-11)]`
* `openjdk version "17.0.4" 2022-07-19`
* `GraalVM Python 3.8.5 (GraalVM CE Native 22.2.0)`
* `GraalVM Python 3.8.5 (GraalVM CE JVM 22.2.0)`
* `GraalNode v16.14.2`
* `Jython 2.7.2`
* `Nuitka 1.0.6`
* `ruby 3.1.2p20 (2022-04-12 revision 4491bb740a) [x86_64-linux]`
* `rubinius 5.0 (10.0 a0a9ed90 2020-05-16 7.0.0) [x86_64-linux-gnu]`
* `mypy 0.971 (compiled: yes)`
* `PHP 8.1.5 (cli) (built: May 16 2022 17:15:25) (NTS)`
