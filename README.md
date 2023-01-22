# Benchmark for interpreted languages implementations.

Most programs from [benchmarks game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/index.html). All programs are chosen to be simplest, single-thread and without any low-level hacks. Also, the code for all languages trying to be implemented with one algorithm, use the same language constructs and containers, and be semantically similar to each other. The goal of the benchmark is to find the most successful JIT solutions. My other benchmarks: [Benchmarks](https://github.com/kostya/benchmarks), [Crystal Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game).

Compare:
		
		* Ruby (Ruby2.7, Ruby3, Graal, Topaz, JRuby, Rbx)
		* Python (Cpython, Graal, Pypy, Cython, Jython, Nuitka, Mypyc)
		* Lua (JIT)
		* Javascript (Node, Graal)
		* PHP8.1 (JIT)
		* C, Crystal as a basis

Running on AMD Ryzen 7 3800X, 80Gb DDR-4 3200 Mghz, docker on Ubuntu 22.10.

## Update: 2023-01-22 (round 0)

## binarytrees
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C++        |             | 0.44     | 5    | 0.75        | 17.3       |
| Crystal    |             | 0.62     | 5    | 9.87        | 22.1       |
| Ruby2      | GraalVM_JVM | 0.65     | 5    | 1.86        | 1872.2     |
| Python3    | Cython      | 0.81     | 5    | 1.15        | 24.2       |
| C          |             | 0.88     | 5    | 0.66        | 49.6       |
| Ruby2      | GraalVM     | 1.1      | 5    | 0.2         | 760.5      |
| Javascript | Node        | 1.13     | 5    | 0.31        | 154.4      |
| Ruby2      | JRuby_InDy  | 1.2      | 5    | 1.7         | 2119.1     |
| Javascript | GraalVM_JVM | 1.31     | 5    | 2.12        | 2054.9     |
| Ruby2      | Topaz       | 1.96     | 5    | 0.21        | 62.6       |
| Python3    | GraalVM_JVM | 1.98     | 5    | 3.03        | 3135.0     |
| Javascript | GraalVM     | 2.16     | 5    | 0.55        | 691.9      |
| Ruby2      | JRuby       | 2.86     | 5    | 1.66        | 1194.8     |
| PHP        | JIT         | 3.03     | 5    | 0.19        | 76.2       |
| Python3    | GraalVM     | 3.68     | 5    | 0.32        | 921.5      |
| Python3    | PYPY        | 3.82     | 5    | 0.23        | 124.4      |
| Python2    | PYPY        | 3.91     | 5    | 0.21        | 141.3      |
| Ruby3      | JIT         | 4.26     | 5    | 0.45        | 78.8       |
| Ruby3      |             | 5.53     | 5    | 0.24        | 46.8       |
| Ruby2      | JIT         | 5.93     | 5    | 0.24        | 45.0       |
| PHP        |             | 6.02     | 5    | 0.25        | 73.0       |
| Ruby2      |             | 6.59     | 5    | 0.23        | 44.6       |
| Lua        | JIT         | 6.65     | 5    | 0.7         | 306.4      |
| Ruby2      | Rbx         | 15.36    | 5    | 0.36        | 411.3      |
| Python3    | MYPYC       | 22.73    | 4    | 2.55        | 53.6       |
| Lua        |             | 23.43    | 4    | 0.19        | 333.1      |
| Python2    | Jython      | 23.57    | 4    | 1.23        | 800.4      |
| Python3    | Nuitka      | 71.05    | 1    | 3.82        | 97.2       |
| Python3    |             | 73.14    | 1    | 0.24        | 104.0      |
| Python2    |             | 90.97    | 1    | 0.26        | 205.7      |


## brainfuck
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C++        |             | 2.35     | 5    | 0.61        | 1.9        |
| Crystal    |             | 4.89     | 5    | 9.79        | 2.8        |
| Javascript | Node        | 5.28     | 5    | 0.3         | 47.9       |
| Python2    | PYPY        | 6.58     | 5    | 0.29        | 64.0       |
| Python3    | PYPY        | 8.74     | 5    | 0.26        | 61.1       |
| Python3    | GraalVM_JVM | 14.1     | 5    | 3.58        | 1620.1     |
| Ruby2      | GraalVM_JVM | 15.16    | 5    | 2.41        | 1352.1     |
| Ruby2      | GraalVM     | 15.7     | 4    | 0.21        | 595.8      |
| Ruby2      | Topaz       | 16.89    | 5    | 0.22        | 29.9       |
| Python3    | GraalVM     | 19.19    | 5    | 0.38        | 867.1      |
| Javascript | GraalVM_JVM | 47.53    | 3    | 2.67        | 1155.4     |
| Ruby2      | JRuby_InDy  | 53.54    | 3    | 2.2         | 805.3      |
| Javascript | GraalVM     | 72.39    | 2    | 0.55        | 438.1      |
| Python3    | MYPYC       | 89.76    | 2    | 2.79        | 9.3        |
| Ruby2      | JIT         | 103.68   | 1    | 0.67        | 20.9       |
| Ruby3      | JIT         | 105.24   | 1    | 0.94        | 24.9       |
| Ruby2      | JRuby       | 111.87   | 1    | 1.65        | 966.7      |
| Ruby2      |             | 114.79   | 1    | 0.26        | 20.7       |
| Ruby3      |             | 121.95   | 1    | 0.31        | 22.8       |
| Python3    | Cython      | 168.07   | 1    | 2.28        | 9.9        |
| Python3    | Nuitka      | 171.21   | 1    | 3.77        | 11.1       |
| Python2    | Jython      | > 190    | 0    | 1.4         | 380.3      |
| Python2    |             | > 190    | 0    | 0.19        | 6.4        |
| Python3    |             | > 190    | 0    | 0.21        | 9.5        |
| Ruby2      | Rbx         | > 190    | 0    | 0.35        | 1011.2     |


## brainfuck2
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 1.25     | 5    | 0.27        | 0.8        |
| Crystal    |             | 1.97     | 5    | 9.74        | 2.8        |
| Javascript | Node        | 3.62     | 5    | 0.3         | 47.5       |
| Ruby2      | GraalVM_JVM | 4.69     | 5    | 1.86        | 2023.3     |
| Ruby2      | GraalVM     | 5.55     | 5    | 0.25        | 650.9      |
| Lua        | JIT         | 6.64     | 5    | 0.65        | 2.8        |
| Javascript | GraalVM_JVM | 10.48    | 5    | 2.13        | 1279.4     |
| Python3    | PYPY        | 11.15    | 5    | 0.22        | 63.9       |
| Python2    | PYPY        | 11.16    | 5    | 0.24        | 68.4       |
| Javascript | GraalVM     | 11.53    | 5    | 0.48        | 560.2      |
| Python3    | GraalVM_JVM | 11.56    | 5    | 3.56        | 1937.5     |
| Python3    | GraalVM     | 14.28    | 5    | 0.41        | 1119.5     |
| Ruby2      | Topaz       | 22.81    | 5    | 0.27        | 31.8       |
| Ruby2      | JRuby_InDy  | 53.13    | 3    | 2.4         | 791.2      |
| Ruby3      | JIT         | 58.92    | 3    | 0.92        | 25.4       |
| Ruby2      | JIT         | 64.14    | 3    | 0.8         | 21.0       |
| Lua        |             | 66.25    | 3    | 0.17        | 2.4        |
| Python3    | MYPYC       | 73.96    | 2    | 2.73        | 9.3        |
| Ruby2      | JRuby       | 91.72    | 2    | 1.61        | 808.9      |
| Ruby3      |             | 91.96    | 2    | 0.31        | 22.7       |
| Ruby2      |             | 95.39    | 2    | 0.28        | 20.7       |
| Python3    | Nuitka      | 131.16   | 1    | 3.81        | 11.2       |
| Python3    |             | 137.4    | 1    | 0.21        | 9.4        |
| Python2    |             | 158.22   | 1    | 0.17        | 6.3        |
| Python2    | Jython      | 203.68   | 1    | 1.41        | 381.1      |
| Ruby2      | Rbx         | > 215    | 0    | 0.34        | 960.6      |


## fannkuchredux
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | Cython      | 0.13     | 5    | 0.98        | 8.2        |
| Javascript | Node        | 0.15     | 5    | 0.29        | 47.9       |
| Javascript | GraalVM_JVM | 0.19     | 5    | 2.16        | 721.4      |
| Crystal    |             | 0.19     | 5    | 9.78        | 2.8        |
| Javascript | GraalVM     | 0.19     | 5    | 0.53        | 329.6      |
| C          |             | 0.21     | 5    | 0.26        | 0.9        |
| Ruby2      | GraalVM_JVM | 0.22     | 5    | 1.82        | 725.0      |
| Lua        | JIT         | 0.27     | 5    | 0.17        | 2.7        |
| Ruby2      | GraalVM     | 0.27     | 5    | 0.2         | 331.7      |
| Python3    | GraalVM_JVM | 0.35     | 5    | 3.1         | 1625.5     |
| Ruby2      | Topaz       | 0.44     | 5    | 0.23        | 29.8       |
| Python3    | GraalVM     | 0.6      | 5    | 0.25        | 563.0      |
| Python3    | PYPY        | 0.68     | 1    | 0.2         | 57.5       |
| Python2    | PYPY        | 0.7      | 5    | 0.18        | 66.8       |
| PHP        | JIT         | 0.73     | 5    | 0.17        | 20.1       |
| Ruby2      | JRuby_InDy  | 1.17     | 5    | 1.59        | 368.2      |
| Ruby2      | JRuby       | 2.07     | 5    | 1.64        | 374.1      |
| PHP        |             | 2.58     | 5    | 0.14        | 16.6       |
| Lua        |             | 2.77     | 5    | 0.19        | 2.5        |
| Python3    | MYPYC       | 2.85     | 5    | 2.43        | 7.5        |
| Python3    | Nuitka      | 3.64     | 5    | 3.84        | 10.5       |
| Python3    |             | 4.03     | 5    | 0.18        | 8.2        |
| Python2    |             | 4.11     | 5    | 0.16        | 6.4        |
| Ruby2      | JIT         | 4.33     | 5    | 0.29        | 20.9       |
| Ruby3      | JIT         | 4.37     | 5    | 0.51        | 23.8       |
| Ruby2      |             | 4.37     | 5    | 0.24        | 20.8       |
| Ruby3      |             | 4.4      | 5    | 0.23        | 22.9       |
| Python2    | Jython      | 4.91     | 5    | 1.27        | 379.1      |
| Ruby2      | Rbx         | > 60     | 0    | 0.34        | 513.0      |


## fasta
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 0.57     | 5    | 0.29        | 0.9        |
| Crystal    |             | 1.17     | 5    | 9.76        | 3.8        |
| Lua        | JIT         | 1.68     | 5    | 0.2         | 2.8        |
| PHP        | JIT         | 2.45     | 5    | 0.2         | 19.7       |
| Python2    | PYPY        | 2.87     | 5    | 0.23        | 69.8       |
| Python3    | PYPY        | 3.16     | 5    | 0.19        | 62.8       |
| Ruby2      | GraalVM_JVM | 3.39     | 5    | 1.9         | 1311.0     |
| Python3    | GraalVM_JVM | 3.65     | 5    | 3.2         | 1183.5     |
| Ruby2      | GraalVM     | 3.69     | 5    | 0.3         | 429.8      |
| Javascript | Node        | 4.15     | 5    | 0.27        | 55.0       |
| Lua        |             | 4.39     | 5    | 0.18        | 2.8        |
| PHP        |             | 4.4      | 5    | 0.27        | 16.8       |
| Python3    | GraalVM     | 5.11     | 5    | 0.35        | 761.8      |
| Ruby2      | Topaz       | 5.24     | 5    | 0.25        | 40.9       |
| Python3    | MYPYC       | 6.82     | 5    | 2.74        | 7.6        |
| Python3    | Cython      | 7.33     | 5    | 2.4         | 8.3        |
| Javascript | GraalVM_JVM | 7.96     | 5    | 2.22        | 1312.0     |
| Python3    |             | 8.71     | 5    | 0.29        | 8.0        |
| Javascript | GraalVM     | 10.67    | 5    | 0.54        | 918.4      |
| Python3    | Nuitka      | 10.88    | 5    | 3.73        | 10.5       |
| Python2    |             | 11.59    | 5    | 0.21        | 19.6       |
| Ruby3      | JIT         | 15.47    | 5    | 1.01        | 55.3       |
| Ruby3      |             | 16.76    | 4    | 0.29        | 53.2       |
| Ruby2      | JIT         | 17.27    | 4    | 0.76        | 59.5       |
| Ruby2      |             | 18.19    | 4    | 0.23        | 75.3       |
| Ruby2      | JRuby_InDy  | 27.94    | 2    | 2.17        | 779.3      |
| Ruby2      | JRuby       | 30.05    | 2    | 1.68        | 777.2      |
| Python2    | Jython      | 31.59    | 2    | 1.32        | 405.5      |
| Ruby2      | Rbx         | > 80     | 0    | 0.35        | 540.1      |


## knucleotide
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Lua        | JIT         | 0.77     | 1    | 0.22        | 24.8       |
| C++        |             | 1.94     | 1    | 1.01        | 30.9       |
| Python2    | PYPY        | 1.99     | 1    | 0.24        | 136.4      |
| PHP        | JIT         | 2.07     | 1    | 0.22        | 45.3       |
| Crystal    |             | 2.32     | 1    | 11.48       | 45.7       |
| PHP        |             | 3.1      | 1    | 0.22        | 42.0       |
| Lua        |             | 3.84     | 1    | 0.32        | 68.3       |
| Python3    | PYPY        | 3.96     | 1    | 0.25        | 142.3      |
| Python3    | GraalVM_JVM | 4.92     | 1    | 4.43        | 1379.9     |
| Javascript | Node        | 4.96     | 1    | 0.33        | 123.2      |
| Ruby2      | Topaz       | 5.08     | 1    | 0.39        | 117.2      |
| Ruby2      | GraalVM_JVM | 5.4      | 1    | 2.55        | 1626.8     |
| Python3    | GraalVM     | 5.59     | 1    | 0.78        | 784.1      |
| Python2    |             | 6.55     | 1    | 0.34        | 262.9      |
| Ruby2      | GraalVM     | 7.6      | 1    | 0.8         | 444.4      |
| Python3    |             | 8.2      | 1    | 0.32        | 48.9       |
| Python3    | Nuitka      | 8.51     | 1    | 3.78        | 51.5       |
| Python3    | Cython      | 8.69     | 1    | 2.58        | 49.9       |
| Ruby2      | JRuby_InDy  | 9.2      | 1    | 1.81        | 845.5      |
| Python2    | Jython      | 9.24     | 1    | 1.53        | 835.8      |
| Javascript | GraalVM_JVM | 9.24     | 1    | 3.78        | 1426.4     |
| Ruby2      | JRuby       | 9.48     | 1    | 1.8         | 1017.7     |
| Ruby2      | JIT         | 9.63     | 1    | 0.33        | 55.8       |
| Ruby3      | JIT         | 10.1     | 1    | 0.52        | 83.9       |
| Ruby2      |             | 10.79    | 1    | 0.36        | 55.9       |
| Ruby3      |             | 11.63    | 1    | 0.33        | 84.5       |
| Javascript | GraalVM     | 13.53    | 1    | 1.84        | 563.1      |
| Python3    | MYPYC       | -        | 0    | 1.06        | -          |
| Ruby2      | Rbx         | > 60     | 0    | 0.0         | -          |


## mandelbrot
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | Cython      | 0.43     | 5    | 1.14        | 8.2        |
| C          |             | 0.45     | 5    | 0.32        | 0.9        |
| Crystal    |             | 0.45     | 5    | 9.7         | 2.7        |
| Javascript | Node        | 0.46     | 5    | 0.28        | 111.1      |
| Javascript | GraalVM_JVM | 0.48     | 5    | 2.23        | 1313.7     |
| Lua        | JIT         | 0.5      | 5    | 0.2         | 2.4        |
| Javascript | GraalVM     | 0.51     | 5    | 0.49        | 715.4      |
| Python3    | PYPY        | 0.54     | 5    | 0.21        | 75.6       |
| Python2    | PYPY        | 0.57     | 5    | 0.28        | 83.6       |
| PHP        | JIT         | 0.57     | 5    | 0.21        | 19.7       |
| Python3    | GraalVM_JVM | 0.83     | 5    | 3.48        | 1035.0     |
| Python3    | GraalVM     | 1.14     | 4    | 0.3         | 669.8      |
| Ruby2      | GraalVM     | 1.41     | 5    | 0.26        | 400.8      |
| Ruby2      | Topaz       | 1.44     | 5    | 0.25        | 26.8       |
| Ruby2      | GraalVM_JVM | 1.47     | 5    | 1.89        | 1185.1     |
| PHP        |             | 5.6      | 5    | 0.2         | 17.0       |
| Lua        |             | 6.57     | 5    | 0.2         | 2.6        |
| Ruby2      | JRuby_InDy  | 6.93     | 5    | 1.62        | 942.6      |
| Python2    | Jython      | 13.64    | 5    | 1.39        | 592.3      |
| Ruby2      | JRuby       | 14.97    | 5    | 1.66        | 1228.6     |
| Ruby2      | JIT         | 16.7     | 5    | 0.25        | 21.1       |
| Ruby2      |             | 16.74    | 5    | 0.28        | 20.8       |
| Ruby3      |             | 18.44    | 5    | 0.23        | 22.9       |
| Ruby3      | JIT         | 18.52    | 5    | 0.46        | 24.0       |
| Python3    | MYPYC       | 22.69    | 5    | 2.47        | 16.7       |
| Python3    | Nuitka      | 29.64    | 4    | 3.91        | 19.2       |
| Python3    |             | 31.44    | 3    | 0.19        | 16.7       |
| Python2    |             | 32.41    | 3    | 0.19        | 14.9       |
| Ruby2      | Rbx         | > 120    | 0    | 0.38        | 797.7      |


## matmul
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 0.24     | 5    | 0.28        | 16.5       |
| Crystal    |             | 0.25     | 5    | 10.7        | 28.1       |
| Javascript | Node        | 0.26     | 5    | 0.26        | 98.4       |
| Lua        | JIT         | 0.27     | 5    | 0.21        | 57.5       |
| Javascript | GraalVM_JVM | 0.3      | 5    | 2.12        | 759.3      |
| Python3    | PYPY        | 0.35     | 5    | 0.29        | 82.2       |
| Python2    | PYPY        | 0.35     | 5    | 0.2         | 85.7       |
| Python3    | Cython      | 0.39     | 5    | 1.15        | 84.7       |
| Javascript | GraalVM     | 0.51     | 5    | 0.5         | 399.3      |
| Python3    | GraalVM_JVM | 1.36     | 5    | 3.56        | 1308.7     |
| Ruby2      | GraalVM_JVM | 1.41     | 5    | 1.92        | 3029.5     |
| Ruby2      | Topaz       | 1.76     | 5    | 0.22        | 89.1       |
| Ruby2      | GraalVM     | 1.8      | 5    | 0.29        | 1152.2     |
| Python3    | GraalVM     | 2.3      | 5    | 0.38        | 1066.0     |
| Lua        |             | 7.8      | 5    | 0.24        | 167.4      |
| Ruby3      | JIT         | 11.3     | 5    | 1.0         | 70.7       |
| Ruby3      |             | 18.0     | 4    | 0.24        | 68.3       |
| Ruby2      |             | 18.21    | 4    | 0.24        | 66.0       |
| Ruby2      | JIT         | 20.69    | 3    | 0.67        | 66.5       |
| Python2    |             | 21.9     | 3    | 0.17        | 21.9       |
| Python3    |             | 22.2     | 3    | 0.19        | 25.2       |
| Python3    | Nuitka      | 23.5     | 3    | 3.67        | 26.6       |
| Python3    | MYPYC       | 24.98    | 3    | 2.65        | 25.1       |
| Ruby2      | JRuby_InDy  | 26.75    | 2    | 2.14        | 871.6      |
| Ruby2      | JRuby       | 27.2     | 2    | 1.72        | 875.0      |
| Python2    | Jython      | 27.71    | 2    | 1.39        | 580.4      |
| Ruby2      | Rbx         | > 80     | 0    | 0.32        | 729.9      |


## nbody
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | MYPYC       | 0.0      | 1    | 3.16        | -          |
| Python3    | Cython      | 0.56     | 5    | 0.83        | 8.1        |
| C          |             | 0.56     | 5    | 0.31        | 1.1        |
| Crystal    |             | 0.76     | 5    | 10.8        | 2.8        |
| Javascript | Node        | 0.82     | 5    | 0.33        | 49.6       |
| Ruby2      | GraalVM_JVM | 0.84     | 5    | 1.93        | 967.2      |
| Ruby2      | GraalVM     | 0.86     | 5    | 0.27        | 402.1      |
| Lua        | JIT         | 1.23     | 5    | 0.67        | 2.5        |
| Python3    | GraalVM_JVM | 3.07     | 5    | 2.94        | 1235.7     |
| Python3    | GraalVM     | 3.83     | 5    | 0.31        | 593.1      |
| Python3    | PYPY        | 4.35     | 1    | 0.26        | 59.8       |
| Javascript | GraalVM     | 4.85     | 5    | 0.53        | 505.5      |
| Ruby2      | Topaz       | 5.4      | 5    | 0.19        | 33.7       |
| Javascript | GraalVM_JVM | 5.66     | 5    | 2.11        | 1130.0     |
| Python2    | PYPY        | 5.99     | 5    | 0.23        | 68.2       |
| PHP        | JIT         | 7.0      | 5    | 0.68        | 19.7       |
| Ruby2      | JRuby_InDy  | 14.83    | 5    | 2.2         | 789.8      |
| Lua        |             | 20.06    | 3    | 0.25        | 2.7        |
| PHP        |             | 23.84    | 3    | 0.18        | 17.0       |
| Ruby3      | JIT         | 33.48    | 2    | 0.91        | 26.4       |
| Ruby2      | JIT         | 37.04    | 2    | 0.74        | 21.0       |
| Ruby2      |             | 43.13    | 1    | 0.26        | 20.9       |
| Ruby3      |             | 47.81    | 1    | 0.26        | 22.9       |
| Ruby2      | JRuby       | 51.19    | 1    | 1.64        | 940.8      |
| Python3    |             | 53.34    | 1    | 0.16        | 8.6        |
| Python2    |             | 56.16    | 1    | 0.2         | 286.5      |
| Python3    | Nuitka      | 63.32    | 1    | 4.1         | 11.1       |
| Python2    | Jython      | 63.63    | 1    | 1.28        | 804.1      |
| Ruby2      | Rbx         | > 80     | 0    | 0.4         | 615.1      |


## pidigits
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 1.61     | 5    | 0.34        | 5.6        |
| PHP        | JIT         | 1.7      | 5    | 0.21        | 22.0       |
| PHP        |             | 1.72     | 5    | 0.22        | 18.5       |
| Python3    | Cython      | 1.73     | 5    | 1.03        | 11.9       |
| Javascript | Node        | 2.13     | 5    | 0.3         | 52.2       |
| Javascript | GraalVM     | 3.03     | 5    | 0.5         | 346.1      |
| Javascript | GraalVM_JVM | 3.67     | 5    | 2.39        | 768.0      |
| Crystal    |             | 4.71     | 5    | 10.91       | 8.0        |
| Python3    | MYPYC       | 6.11     | 5    | 2.48        | 9.1        |
| Python3    |             | 6.2      | 5    | 0.17        | 9.7        |
| Python2    |             | 6.51     | 5    | 0.22        | 7.8        |
| Python3    | Nuitka      | 6.78     | 5    | 3.64        | 12.1       |
| Ruby2      | Topaz       | 7.46     | 5    | 0.21        | 35.0       |
| Ruby2      | GraalVM_JVM | 7.62     | 5    | 1.84        | 1636.5     |
| Ruby2      | JRuby       | 7.89     | 5    | 1.66        | 1617.8     |
| Python2    | PYPY        | 7.89     | 5    | 0.22        | 71.6       |
| Ruby2      | JRuby_InDy  | 7.98     | 5    | 1.67        | 1565.0     |
| Python3    | PYPY        | 8.12     | 5    | 0.22        | 63.6       |
| Python2    | Jython      | 8.97     | 5    | 1.3         | 582.5      |
| Python3    | GraalVM_JVM | 9.77     | 5    | 3.53        | 1528.8     |
| Ruby3      |             | 10.51    | 5    | 0.31        | 119.6      |
| Ruby3      | JIT         | 10.56    | 5    | 0.41        | 148.4      |
| Ruby2      | GraalVM     | 10.63    | 5    | 0.24        | 480.0      |
| Ruby2      |             | 11.25    | 5    | 0.26        | 171.8      |
| Ruby2      | JIT         | 11.33    | 5    | 0.32        | 163.4      |
| Python3    | GraalVM     | 15.29    | 4    | 0.27        | 737.5      |
| Ruby2      | Rbx         | 22.6     | 3    | 0.36        | 89.5       |


## regexdna
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Crystal    |             | 0.45     | 1    | 10.87       | 152.3      |
| Javascript | Node        | 1.11     | 1    | 0.71        | 384.1      |
| PHP        | JIT         | 1.42     | 1    | 0.26        | 83.5       |
| PHP        |             | 1.42     | 1    | 0.24        | 101.8      |
| Python2    | PYPY        | 2.56     | 1    | 0.39        | 281.5      |
| Python3    | PYPY        | 2.66     | 1    | 0.52        | 307.4      |
| Ruby2      | Topaz       | 3.11     | 1    | 0.63        | 323.0      |
| Python3    | MYPYC       | 5.23     | 1    | 3.29        | 142.0      |
| Ruby2      | GraalVM_JVM | 5.48     | 1    | 2.78        | 2049.0     |
| C          |             | 5.54     | 1    | 0.41        | 88.8       |
| Python3    |             | 5.75     | 1    | 1.2         | 143.1      |
| Python2    |             | 5.96     | 1    | 1.26        | 118.3      |
| Python3    | Nuitka      | 5.97     | 1    | 4.57        | 163.8      |
| Python3    | Cython      | 6.58     | 1    | 1.84        | 197.7      |
| Ruby2      |             | 6.87     | 1    | 0.37        | 112.9      |
| Ruby2      | JIT         | 6.9      | 1    | 0.48        | 114.8      |
| Ruby3      | JIT         | 7.56     | 1    | 0.66        | 116.8      |
| Javascript | GraalVM_JVM | 7.74     | 1    | 5.76        | 1914.5     |
| Ruby3      |             | 7.86     | 1    | 0.65        | 114.8      |
| Python2    | Jython      | 9.03     | 1    | 3.08        | 738.4      |
| Python3    | GraalVM_JVM | 9.21     | 1    | 8.54        | 2334.7     |
| Ruby2      | GraalVM     | 10.12    | 1    | 1.48        | 2439.5     |
| Lua        |             | 10.15    | 1    | 0.85        | 414.7      |
| Ruby2      | JRuby_InDy  | 10.67    | 1    | 2.18        | 589.0      |
| Lua        | JIT         | 10.81    | 1    | 1.03        | 210.0      |
| Javascript | GraalVM     | 10.94    | 1    | 4.04        | 763.3      |
| Ruby2      | JRuby       | 11.39    | 1    | 1.85        | 558.5      |
| Ruby2      | Rbx         | 13.19    | 1    | 2.11        | 396.0      |
| Python3    | GraalVM     | 13.28    | 1    | 4.88        | 1130.9     |


## revcomp
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 0.54     | 1    | 0.3         | 147.8      |
| PHP        | JIT         | 2.24     | 1    | 0.21        | 368.9      |
| Python3    |             | 2.37     | 1    | 0.17        | 921.2      |
| Python2    |             | 2.38     | 1    | 0.21        | 867.6      |
| PHP        |             | 2.46     | 1    | 0.22        | 384.5      |
| Python3    | Nuitka      | 2.69     | 1    | 3.51        | 868.4      |
| Python2    | PYPY        | 2.72     | 1    | 0.28        | 1304.9     |
| Lua        | JIT         | 3.16     | 1    | 0.25        | 309.6      |
| Javascript | Node        | 3.19     | 1    | 0.31        | 245.6      |
| Ruby3      | JIT         | 3.53     | 1    | 0.45        | 169.1      |
| Ruby3      |             | 3.66     | 1    | 0.33        | 167.8      |
| Python3    | PYPY        | 4.0      | 1    | 0.23        | 1297.4     |
| Ruby2      | JIT         | 4.16     | 1    | 0.24        | 164.6      |
| Ruby2      |             | 4.23     | 1    | 0.2         | 164.6      |
| Python3    | GraalVM_JVM | 4.74     | 1    | 2.95        | 4273.5     |
| Crystal    |             | 5.4      | 1    | 10.59       | 916.3      |
| Ruby2      | Topaz       | 7.23     | 1    | 0.25        | 787.4      |
| Javascript | GraalVM     | 8.35     | 1    | 0.49        | 1729.2     |
| Lua        |             | 8.57     | 1    | 0.22        | 840.6      |
| Javascript | GraalVM_JVM | 9.28     | 1    | 2.26        | 2105.4     |
| Ruby2      | JRuby       | 9.32     | 1    | 1.66        | 835.1      |
| Ruby2      | JRuby_InDy  | 9.54     | 1    | 1.58        | 841.6      |
| Python3    | GraalVM     | 11.23    | 1    | 0.33        | 3012.6     |
| Ruby2      | GraalVM_JVM | 15.1     | 1    | 1.85        | 2272.3     |
| Ruby2      | GraalVM     | 15.71    | 1    | 0.25        | 1315.3     |
| Python3    | MYPYC       | -        | 0    | 2.42        | -          |
| Python2    | Jython      | -        | 0    | 1.26        | 800.7      |
| Ruby2      | Rbx         | > 60     | 0    | 0.33        | 504.6      |


## spectralnorm
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | Cython      | 0.11     | 5    | 1.06        | 10.3       |
| C          |             | 0.11     | 5    | 0.31        | 1.2        |
| Javascript | Node        | 0.11     | 5    | 0.33        | 49.3       |
| Crystal    |             | 0.11     | 5    | 10.58       | 3.5        |
| Lua        | JIT         | 0.12     | 5    | 0.19        | 2.9        |
| Javascript | GraalVM_JVM | 0.12     | 5    | 2.15        | 1133.4     |
| Javascript | GraalVM     | 0.13     | 5    | 0.62        | 439.1      |
| Ruby2      | GraalVM_JVM | 0.21     | 5    | 1.92        | 713.0      |
| Ruby2      | GraalVM     | 0.21     | 5    | 0.21        | 367.0      |
| Python3    | GraalVM_JVM | 0.62     | 5    | 2.94        | 1722.0     |
| Python2    | PYPY        | 0.64     | 5    | 0.22        | 68.2       |
| Python3    | PYPY        | 0.7      | 5    | 0.19        | 61.7       |
| Python3    | GraalVM     | 0.75     | 5    | 0.27        | 800.1      |
| Ruby2      | Topaz       | 1.45     | 5    | 0.2         | 32.0       |
| PHP        | JIT         | 2.59     | 5    | 0.27        | 20.5       |
| Ruby2      | JRuby_InDy  | 4.15     | 5    | 1.68        | 1237.5     |
| Lua        |             | 5.5      | 5    | 0.18        | 3.3        |
| PHP        |             | 6.68     | 5    | 0.16        | 17.3       |
| Ruby2      | JRuby       | 10.43    | 5    | 1.6         | 1329.7     |
| Ruby3      | JIT         | 10.79    | 5    | 0.49        | 25.1       |
| Python3    | MYPYC       | 12.94    | 5    | 2.61        | 8.5        |
| Ruby2      | JIT         | 13.07    | 5    | 0.74        | 21.3       |
| Ruby3      |             | 14.87    | 5    | 0.29        | 23.1       |
| Python2    |             | 15.66    | 5    | 0.22        | 6.8        |
| Ruby2      |             | 17.29    | 4    | 0.23        | 21.2       |
| Python3    |             | 20.27    | 3    | 0.21        | 8.8        |
| Python3    | Nuitka      | 21.08    | 3    | 3.57        | 11.2       |
| Python2    | Jython      | 40.96    | 1    | 1.32        | 374.0      |
| Ruby2      | Rbx         | > 80     | 0    | 0.36        | 624.5      |


## Versions
| Language    | Version                              |
|-------------|--------------------------------------|
| c           | 12.2.0                               |
| crystal     | 1.7.1                                |
| cython      | 0.29.30                              |
| graalnode   | 22.3.0 (node: 16.17.1)               |
| graalpython | 22.3.0 (python: 3.8.5)               |
| java        | openjdk 19.0.1                       |
| jruby       | 9.4.0.0                              |
| jython      | 2.7.3                                |
| lua         | 5.3.6                                |
| luajit      | 2.1.0-beta3                          |
| mypyc       | 0.991                                |
| nodejs      | 18.7.0                               |
| nuitka      | 1.3.8 (python: 3.10.7, gcc: 12.2.0)  |
| php         | 8.1.7                                |
| pypy2       | 7.3.6 (python: 2.7.18, gcc: 7.3.1)   |
| pypy3       | 7.3.11 (python: 3.9.16, gcc: 10.2.1) |
| python2     | 2.7.18                               |
| python3     | 3.10.7                               |
| rbx         | 5.0                                  |
| ruby2       | 2.7.7p221                            |
| ruby3       | 3.2.0p0                              |
| topaz       | https://github.com/kostya/topaz      |
| truffleruby | 22.3.0 (ruby: 3.0.3)                 |


## Run
Currently possible to run on x86_64 and aarch64. Tested Ubuntu x86_64 and Apple M1.

Install [docker-compose-plugin v2](https://docs.docker.com/engine/install/ubuntu/#set-up-the-repository) and Ruby, on your local machine.

Run control script for more info:

		./dc

Example build and run binarytrees benchmark for ruby and crystal:

		./dc init crystal,ruby
		./dc up crystal,ruby
		./dc versions crystal,ruby
		./dc build binarytrees crystal,ruby
		./dc check binarytrees crystal,ruby
		./dc run binarytrees crystal,ruby
		./dc down
		./dc readme binarytrees crystal,ruby
