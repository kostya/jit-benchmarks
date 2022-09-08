# Benchmark for interpreted languages implementations.

Most programs from [benchmarks game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/index.html). All programs are chosen to be simplest, single-thread and without any low-level hacks. Also, the code for all languages trying to be implemented with one algorithm, use the same language constructs and containers, and be semantically similar to each other. The goal of the benchmark is to find the most successful JIT solutions. My other benchmarks: [Benchmarks](https://github.com/kostya/benchmarks), [Crystal Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game).

Compare:
		
		* Ruby (Ruby2.7, Ruby3, Graal, Topaz, JRuby, Rbx)
		* Python (Cpython, Graal, Pypy, Cython, Jython, Nuitka, Mypyc)
		* Lua (JIT)
		* Javascript (Node, Graal)
		* PHP8.1 (JIT)
		* C, Crystal as a basis

Running on AMD Ryzen 7 3800X, 16Gb DDR-4 3200 Mghz, docker on Ubuntu 22.04.1.

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
| Crystal    |             | 0.52     | 0.54        | 0.0       | 29.12      |
| C++        | g++         | 0.54     | 0.55        | 0.0       | 17.02      |
| Ruby       | GraalVM_JVM | 0.60     | 1.32        | 1.6       | 942.69     |
| Ruby       | JRuby_InDy  | 0.79     | 1.22        | 1.5       | 1089.84    |
| Ruby       | GraalVM     | 1.01     | 1.47        | 0.0       | 536.51     |
| Javascript | Node        | 1.07     | 1.44        | 0.1       | 153.93     |
| Python3    | Cython      | 1.09     | 1.20        | 0.0       | 24.05      |
| C          | gcc         | 1.13     | 1.14        | 0.0       | 49.84      |
| Javascript | GraalVM_JVM | 1.35     | 2.06        | 1.8       | 1196.87    |
| Python3    | GraalVM_JVM | 1.91     | 3.83        | 2.6       | 2000.39    |
| Javascript | GraalVM     | 2.10     | 2.50        | 0.2       | 632.89     |
| Ruby       | Topaz       | 2.33     | 2.51        | 0.0       | 63.11      |
| Python3    | GraalVM     | 2.97     | 3.91        | 0.1       | 1032.20    |
| Ruby       | JRuby       | 3.09     | 3.36        | 1.4       | 576.82     |
| PHP        | JIT         | 3.96     | 4.32        | 0.0       | 76.36      |
| Python3    | Pypy        | 4.48     | 4.59        | 0.0       | 127.10     |
| Python2    | Pypy        | 4.59     | 4.73        | 0.0       | 141.54     |
| Ruby3      | JIT         | 4.70     | 4.72        | 0.1       | 296.77     |
| Ruby3      |             | 5.91     | 5.96        | 0.0       | 41.72      |
| Ruby2.7    | JIT         | 5.99     | 6.08        | 0.0       | 36.94      |
| Ruby2.7    |             | 6.75     | 6.80        | 0.0       | 36.42      |
| Lua        | JIT         | 7.46     | 7.81        | 0.0       | 298.48     |
| PHP        |             | 7.68     | 7.93        | 0.0       | 72.98      |
| Lua        |             | 15.23    | 18.59       | 0.0       | 169.85     |
| Ruby       | Rbx         | 17.34    | 17.67       | 0.1       | 421.29     |
| Python2    | Jython      | 22.28    | 22.56       | 1.5       | 1343.52    |
| Python3    | Mypyc       | 22.65    | 22.88       | 0.0       | 0.89       |
| Python3    | Nuitka      | 69.18    | 69.18       | 0.0       | 107.01     |
| Python3    |             | 77.34    | 77.34       | 0.0       | 104.25     |
| Python2    |             | 96.73    | 96.73       | 0.0       | 205.74     |


## Brainfuck (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 2.50     | 2.52        | 0.0       | 1.82       |
| Crystal    |             | 4.67     | 4.73        | 0.0       | 3.44       |
| Javascript | Node        | 5.22     | 6.08        | 0.1       | 46.34      |
| Python2    | Pypy        | 8.19     | 8.45        | 0.1       | 62.71      |
| Python3    | Pypy        | 9.78     | 10.80       | 0.1       | 64.94      |
| Ruby       | GraalVM_JVM | 17.73    | 19.07       | 1.6       | 354.50     |
| Ruby       | Topaz       | 17.77    | 17.82       | 0.0       | 29.24      |
| Ruby       | GraalVM     | 18.59    | 19.99       | 0.1       | 396.55     |
| Python3    | GraalVM_JVM | 38.39    | 39.76       | 3.2       | 827.26     |
| Python3    | GraalVM     | 43.11    | 46.32       | 0.3       | 888.39     |
| Ruby       | JRuby_InDy  | 55.93    | 56.82       | 1.4       | 391.89     |
| Javascript | GraalVM_JVM | 68.19    | 68.55       | 2.0       | 561.75     |
| Javascript | GraalVM     | 85.81    | 93.81       | 0.3       | 529.29     |
| Python3    | Mypyc       | 89.45    | 89.54       | 0.0       | 0.93       |
| Ruby2.7    | JIT         | 105.56   | 105.56      | 0.0       | 13.03      |
| Ruby3      | JIT         | 111.10   | 111.10      | 0.1       | 270.01     |
| Ruby2.7    |             | 119.87   | 119.87      | 0.0       | 12.83      |
| Ruby3      |             | 120.16   | 120.16      | 0.0       | 13.41      |
| Ruby       | JRuby       | 125.88   | 125.88      | 1.5       | 426.43     |
| Python3    | Nuitka      | 164.14   | 164.14      | 0.0       | 10.95      |
| Python3    | Cython      | 172.51   | 172.51      | 0.0       | 9.60       |
| Ruby       | Rbx         | > 190    | > 190       | 0.1       | 960.41     |
| Python2    |             | > 190    | > 190       | 0.0       | 6.38       |
| Python3    |             | > 190    | > 190       | 0.0       | 9.20       |
| Python2    | Jython      | > 190    | > 190       | 1.5       | 537.36     |


## Brainfuck2 (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.95     | 1.97        | 0.0       | 0.87       |
| Crystal    |             | 2.41     | 2.43        | 0.0       | 3.14       |
| Javascript | Node        | 3.68     | 6.52        | 0.1       | 46.25      |
| Ruby       | GraalVM_JVM | 5.88     | 8.93        | 1.6       | 755.97     |
| Ruby       | GraalVM     | 6.43     | 8.88        | 0.1       | 610.87     |
| Lua        | JIT         | 7.76     | 8.55        | 0.0       | 2.37       |
| Python2    | Pypy        | 12.05    | 12.27       | 0.1       | 66.58      |
| Python3    | Pypy        | 12.19    | 12.22       | 0.1       | 65.61      |
| Javascript | GraalVM     | 12.47    | 12.91       | 0.4       | 579.70     |
| Javascript | GraalVM_JVM | 12.78    | 14.21       | 2.3       | 660.16     |
| Python3    | GraalVM_JVM | 14.21    | 14.37       | 3.4       | 902.70     |
| Python3    | GraalVM     | 15.17    | 15.18       | 0.4       | 1024.09    |
| Ruby       | Topaz       | 24.35    | 24.38       | 0.0       | 31.79      |
| Ruby       | JRuby_InDy  | 50.76    | 50.92       | 1.4       | 331.54     |
| Ruby3      | JIT         | 52.57    | 52.81       | 0.1       | 270.11     |
| Lua        |             | 56.61    | 57.06       | 0.0       | 1.57       |
| Ruby2.7    | JIT         | 60.46    | 60.72       | 0.0       | 13.02      |
| Python3    | Mypyc       | 82.42    | 82.44       | 0.0       | 0.89       |
| Ruby3      |             | 93.32    | 93.87       | 0.0       | 13.30      |
| Ruby2.7    |             | 98.23    | 98.24       | 0.0       | 12.66      |
| Ruby       | JRuby       | 99.60    | 99.73       | 1.5       | 393.09     |
| Python3    | Nuitka      | 134.87   | 134.87      | 0.0       | 10.90      |
| Python3    | Cython      | 187.53   | 187.53      | 0.0       | 9.71       |
| Python3    |             | 187.90   | 187.90      | 0.0       | 9.49       |
| Ruby       | Rbx         | > 215    | > 215       | 0.1       | 909.98     |
| Python2    |             | > 215    | > 215       | 0.0       | 6.09       |
| Python2    | Jython      | > 215    | > 215       | 1.6       | 620.30     |


## Fannkuchredux (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.12     | 0.12        | 0.0       | 7.85       |
| Javascript | Node        | 0.15     | 0.18        | 0.1       | 45.84      |
| Javascript | GraalVM_JVM | 0.18     | 0.66        | 2.2       | 375.71     |
| Javascript | GraalVM     | 0.19     | 0.49        | 0.3       | 326.25     |
| C          | gcc         | 0.21     | 0.21        | 0.0       | 0.88       |
| Crystal    |             | 0.22     | 0.22        | 0.0       | 3.13       |
| Ruby       | GraalVM_JVM | 0.22     | 0.86        | 1.6       | 367.01     |
| Ruby       | GraalVM     | 0.30     | 0.60        | 0.0       | 323.62     |
| Lua        | JIT         | 0.35     | 0.35        | 0.0       | 2.29       |
| Python3    | GraalVM_JVM | 0.36     | 2.02        | 2.9       | 727.01     |
| Ruby       | Topaz       | 0.44     | 0.49        | 0.0       | 29.66      |
| Python3    | GraalVM     | 0.55     | 1.22        | 0.2       | 566.15     |
| Python2    | Pypy        | 0.84     | 0.90        | 0.0       | 64.82      |
| PHP        | JIT         | 0.89     | 0.92        | 0.0       | 19.96      |
| Ruby       | JRuby_InDy  | 1.25     | 2.32        | 1.4       | 373.26     |
| Lua        |             | 2.13     | 2.16        | 0.0       | 1.55       |
| Ruby       | JRuby       | 2.34     | 2.57        | 1.4       | 363.23     |
| PHP        |             | 2.90     | 2.93        | 0.0       | 17.05      |
| Python3    | Mypyc       | 3.63     | 3.65        | 0.0       | 0.88       |
| Python3    | Nuitka      | 4.03     | 4.05        | 0.0       | 10.17      |
| Python3    | Pypy        | 4.35     | 4.35        | 0.0       | 61.40      |
| Ruby2.7    |             | 4.80     | 4.80        | 0.0       | 12.73      |
| Ruby2.7    | JIT         | 4.80     | 4.80        | 0.0       | 13.04      |
| Python2    | Jython      | 4.90     | 5.53        | 1.7       | 593.74     |
| Python2    |             | 5.61     | 5.62        | 0.0       | 6.16       |
| Python3    |             | 5.96     | 5.98        | 0.0       | 7.68       |
| Ruby3      |             | 6.19     | 6.21        | 0.0       | 13.36      |
| Ruby3      | JIT         | 6.21     | 6.22        | 0.1       | 270.00     |
| Ruby       | Rbx         | > 60     | > 60        | 0.1       | 482.40     |


## Fasta (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.59     | 0.60        | 0.0       | 0.97       |
| Crystal    |             | 0.88     | 0.88        | 0.0       | 3.69       |
| Lua        | JIT         | 1.74     | 1.76        | 0.0       | 2.46       |
| PHP        | JIT         | 2.54     | 2.55        | 0.0       | 20.22      |
| Ruby       | GraalVM_JVM | 2.87     | 4.06        | 1.6       | 582.73     |
| Python2    | Pypy        | 3.03     | 3.07        | 0.0       | 68.95      |
| Python3    | Pypy        | 3.48     | 3.51        | 0.0       | 66.20      |
| Javascript | Node        | 3.54     | 3.59        | 0.1       | 54.83      |
| Ruby       | GraalVM     | 3.81     | 4.48        | 0.0       | 559.41     |
| Lua        |             | 4.11     | 4.12        | 0.0       | 1.53       |
| Ruby       | Topaz       | 4.70     | 4.80        | 0.0       | 40.82      |
| Python3    | GraalVM_JVM | 4.79     | 9.83        | 2.6       | 790.98     |
| PHP        |             | 5.18     | 5.21        | 0.0       | 17.01      |
| Python3    | GraalVM     | 6.09     | 9.07        | 0.1       | 788.34     |
| Python3    | Cython      | 6.71     | 6.74        | 0.0       | 8.21       |
| Python3    | Mypyc       | 6.71     | 7.08        | 0.0       | 0.99       |
| Javascript | GraalVM_JVM | 8.71     | 16.21       | 2.0       | 673.69     |
| Python3    |             | 9.48     | 9.58        | 0.0       | 7.76       |
| Python3    | Nuitka      | 10.13    | 10.58       | 0.0       | 10.18      |
| Javascript | GraalVM     | 11.59    | 16.53       | 0.2       | 811.66     |
| Python2    |             | 13.17    | 13.23       | 0.0       | 19.62      |
| Ruby3      | JIT         | 13.54    | 13.59       | 0.1       | 289.57     |
| Ruby2.7    | JIT         | 17.00    | 17.04       | 0.0       | 67.96      |
| Ruby3      |             | 17.17    | 17.23       | 0.0       | 33.16      |
| Ruby2.7    |             | 18.25    | 18.31       | 0.0       | 70.27      |
| Ruby       | JRuby_InDy  | 20.50    | 21.25       | 1.4       | 287.89     |
| Ruby       | JRuby       | 27.52    | 27.93       | 1.4       | 311.97     |
| Python2    | Jython      | 39.07    | 39.26       | 1.5       | 545.18     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 519.44     |


## Knucleotide (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Lua        | JIT         | 0.93     | 1.10        | 0.0       | 51.77      |
| C++        | g++         | 1.98     | 2.02        | 0.2       | 30.74      |
| PHP        | JIT         | 2.14     | 2.19        | 0.0       | 47.78      |
| Crystal    |             | 2.37     | 2.41        | 0.0       | 59.81      |
| Python2    | Pypy        | 2.41     | 2.51        | 0.1       | 137.24     |
| PHP        |             | 3.11     | 3.14        | 0.0       | 44.40      |
| Lua        |             | 3.75     | 3.80        | 0.1       | 63.40      |
| Python3    | Pypy        | 3.86     | 4.28        | 0.1       | 148.42     |
| Javascript | Node        | 4.34     | 4.53        | 0.2       | 188.16     |
| Python3    | GraalVM_JVM | 5.25     | 8.97        | 3.5       | 791.36     |
| Ruby       | Topaz       | 5.42     | 5.47        | 0.2       | 118.82     |
| Ruby       | GraalVM_JVM | 5.71     | 9.78        | 2.8       | 1261.06    |
| Python3    | GraalVM     | 5.90     | 8.22        | 0.5       | 687.20     |
| Python2    |             | 7.17     | 7.92        | 0.1       | 262.84     |
| Javascript | GraalVM_JVM | 7.45     | 8.52        | 4.0       | 696.01     |
| Python3    | Cython      | 7.91     | 8.05        | 0.1       | 49.58      |
| Python3    | Nuitka      | 8.37     | 8.52        | 0.1       | 51.37      |
| Python3    | Mypyc       | 9.06     | 9.13        | 0.1       | 0.90       |
| Ruby2.7    | JIT         | 9.07     | 9.21        | 0.1       | 64.38      |
| Ruby       | GraalVM     | 9.13     | 13.98       | 0.8       | 1250.32    |
| Ruby       | JRuby_InDy  | 9.19     | 9.91        | 1.9       | 667.29     |
| Python3    |             | 9.46     | 9.92        | 0.1       | 48.89      |
| Ruby3      | JIT         | 9.47     | 9.92        | 0.2       | 340.44     |
| Ruby       | JRuby       | 9.63     | 10.74       | 1.6       | 585.38     |
| Python2    | Jython      | 9.86     | 11.98       | 1.9       | 2156.48    |
| Ruby2.7    |             | 10.43    | 10.76       | 0.1       | 62.98      |
| Ruby3      |             | 11.15    | 12.45       | 0.1       | 87.83      |
| Javascript | GraalVM     | 12.58    | 13.33       | 1.7       | 589.98     |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 492.21     |


## Mandelbrot (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.44     | 0.44        | 0.0       | 0.88       |
| Crystal    |             | 0.45     | 0.46        | 0.0       | 3.12       |
| Python3    | Cython      | 0.46     | 0.46        | 0.0       | 7.68       |
| Javascript | Node        | 0.47     | 0.48        | 0.1       | 79.60      |
| Lua        | JIT         | 0.49     | 0.50        | 0.0       | 1.19       |
| Javascript | GraalVM_JVM | 0.51     | 1.79        | 2.0       | 617.50     |
| Python3    | Pypy        | 0.53     | 1.67        | 0.0       | 81.68      |
| Python2    | Pypy        | 0.55     | 1.74        | 0.0       | 86.48      |
| PHP        | JIT         | 0.57     | 0.58        | 0.0       | 20.12      |
| Javascript | GraalVM     | 0.57     | 1.70        | 0.2       | 637.46     |
| Ruby       | GraalVM     | 0.97     | 2.12        | 0.1       | 394.44     |
| Ruby       | GraalVM_JVM | 0.99     | 2.49        | 1.8       | 489.50     |
| Ruby       | Topaz       | 1.05     | 1.09        | 0.0       | 26.46      |
| Python3    | GraalVM_JVM | 1.21     | 2.71        | 3.1       | 622.23     |
| Python3    | GraalVM     | 1.22     | 1.58        | 0.1       | 401.61     |
| Lua        |             | 5.55     | 5.56        | 0.0       | 1.54       |
| Ruby       | JRuby_InDy  | 5.90     | 7.28        | 1.7       | 686.26     |
| PHP        |             | 8.54     | 8.57        | 0.0       | 16.77      |
| Python2    | Jython      | 14.91    | 33.91       | 1.0       | 809.20     |
| Ruby       | JRuby       | 17.42    | 19.64       | 1.7       | 508.38     |
| Ruby2.7    | JIT         | 19.89    | 20.06       | 0.0       | 13.02      |
| Ruby2.7    |             | 20.01    | 20.40       | 0.0       | 12.68      |
| Ruby3      |             | 20.15    | 20.80       | 0.0       | 13.39      |
| Ruby3      | JIT         | 20.79    | 20.98       | 0.1       | 269.96     |
| Python3    | Mypyc       | 22.79    | 24.88       | 0.0       | 0.90       |
| Python3    | Nuitka      | 28.06    | 28.30       | 0.0       | 18.81      |
| Python2    |             | 37.50    | 39.66       | 0.0       | 15.01      |
| Python3    |             | 44.91    | 44.97       | 0.0       | 16.54      |
| Ruby       | Rbx         | > 120    | > 120       | 0.1       | 746.98     |


## Matmul (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.23     | 0.24        | 0.0       | 16.48      |
| Crystal    |             | 0.26     | 0.26        | 0.0       | 22.30      |
| Javascript | Node        | 0.26     | 0.27        | 0.1       | 97.43      |
| Lua        | JIT         | 0.27     | 0.27        | 0.0       | 53.37      |
| Javascript | GraalVM_JVM | 0.29     | 4.31        | 1.9       | 506.17     |
| Python2    | Pypy        | 0.34     | 0.36        | 0.1       | 84.71      |
| Python3    | Pypy        | 0.35     | 0.36        | 0.2       | 91.87      |
| Python3    | Cython      | 0.39     | 0.40        | 0.0       | 83.84      |
| Javascript | GraalVM     | 0.50     | 4.11        | 0.4       | 390.90     |
| Ruby       | GraalVM_JVM | 0.70     | 1.57        | 1.7       | 1034.36    |
| Python3    | GraalVM_JVM | 0.92     | 2.08        | 3.3       | 665.66     |
| Ruby       | GraalVM     | 0.96     | 1.92        | 0.2       | 609.43     |
| Python3    | GraalVM     | 1.36     | 2.04        | 0.3       | 584.59     |
| Ruby       | Topaz       | 1.79     | 1.89        | 0.1       | 88.83      |
| Lua        |             | 6.71     | 6.79        | 0.0       | 74.16      |
| Ruby3      | JIT         | 16.21    | 16.28       | 0.1       | 315.68     |
| Ruby3      |             | 17.85    | 17.88       | 0.0       | 58.90      |
| Ruby2.7    |             | 19.21    | 19.25       | 0.0       | 58.12      |
| Ruby       | JRuby_InDy  | 20.02    | 28.04       | 1.4       | 620.15     |
| Ruby2.7    | JIT         | 21.19    | 21.28       | 0.0       | 58.38      |
| Python3    | Nuitka      | 22.63    | 22.71       | 0.0       | 26.35      |
| Python3    | Mypyc       | 22.93    | 23.09       | 0.0       | 0.93       |
| Python2    |             | 28.19    | 28.38       | 0.0       | 21.80      |
| Python3    |             | 28.81    | 28.83       | 0.0       | 24.88      |
| Ruby       | JRuby       | 33.91    | 34.15       | 1.5       | 575.14     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 699.50     |
| Python2    | Jython      | > 80     | > 80        | 1.5       | 519.99     |


## Nbody (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Mypyc       | 0.00     | 0.00        | 0.0       | 0.00       |
| C          | gcc         | 0.63     | 0.67        | 0.0       | 1.10       |
| Python3    | Cython      | 0.69     | 0.71        | 0.0       | 7.83       |
| Crystal    |             | 0.77     | 0.78        | 0.0       | 3.50       |
| Ruby       | GraalVM     | 0.90     | 1.32        | 0.0       | 400.71     |
| Ruby       | GraalVM_JVM | 0.93     | 1.76        | 1.9       | 418.11     |
| Lua        | JIT         | 1.20     | 1.21        | 0.0       | 2.38       |
| Javascript | Node        | 1.26     | 1.30        | 0.1       | 47.93      |
| Python3    | GraalVM_JVM | 3.47     | 5.00        | 2.8       | 629.71     |
| Python3    | GraalVM     | 4.09     | 4.58        | 0.1       | 446.45     |
| Javascript | GraalVM     | 4.73     | 5.24        | 0.2       | 652.75     |
| Javascript | GraalVM_JVM | 5.23     | 5.75        | 2.0       | 547.09     |
| Ruby       | Topaz       | 5.82     | 9.44        | 0.0       | 33.46      |
| Python2    | Pypy        | 6.66     | 6.94        | 0.0       | 66.74      |
| Ruby       | JRuby_InDy  | 8.07     | 8.92        | 1.8       | 497.79     |
| PHP        | JIT         | 8.09     | 8.18        | 0.0       | 20.16      |
| Lua        |             | 18.10    | 18.14       | 0.0       | 1.54       |
| PHP        |             | 23.68    | 23.89       | 0.0       | 17.00      |
| Ruby3      | JIT         | 27.15    | 27.20       | 0.1       | 270.20     |
| Python3    | Pypy        | 33.96    | 33.96       | 0.0       | 66.03      |
| Ruby2.7    | JIT         | 35.41    | 35.70       | 0.0       | 13.07      |
| Ruby2.7    |             | 45.70    | 45.70       | 0.0       | 12.77      |
| Ruby3      |             | 48.61    | 48.61       | 0.0       | 13.35      |
| Ruby       | JRuby       | 55.48    | 55.48       | 2.0       | 497.47     |
| Python2    | Jython      | 61.44    | 61.44       | 1.5       | 1035.87    |
| Python3    | Nuitka      | 65.64    | 65.64       | 0.0       | 10.39      |
| Python2    |             | 72.26    | 72.26       | 0.0       | 286.48     |
| Python3    |             | 74.50    | 74.50       | 0.0       | 8.07       |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 584.54     |


## Pidigits (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.61     | 1.61        | 0.0       | 5.55       |
| PHP        | JIT         | 1.68     | 1.69        | 0.0       | 22.19      |
| PHP        |             | 1.71     | 1.71        | 0.0       | 18.82      |
| Python3    | Cython      | 1.72     | 1.72        | 0.0       | 11.57      |
| Javascript | Node        | 2.12     | 2.16        | 0.1       | 51.31      |
| Javascript | GraalVM     | 3.03     | 3.22        | 0.3       | 342.91     |
| Javascript | GraalVM_JVM | 3.80     | 4.21        | 1.9       | 488.67     |
| Python3    | Mypyc       | 6.04     | 6.07        | 0.0       | 0.93       |
| Python3    |             | 6.11     | 6.13        | 0.0       | 9.50       |
| Python2    |             | 6.25     | 6.26        | 0.0       | 7.82       |
| Python3    | Nuitka      | 6.80     | 6.87        | 0.0       | 12.00      |
| Ruby       | Topaz       | 7.19     | 7.32        | 0.0       | 35.22      |
| Ruby       | GraalVM_JVM | 7.69     | 8.07        | 1.5       | 619.31     |
| Python2    | Pypy        | 7.75     | 7.79        | 0.0       | 70.88      |
| Python3    | Pypy        | 7.78     | 7.94        | 0.0       | 67.14      |
| Crystal    |             | 8.24     | 9.65        | 0.0       | 7.36       |
| Ruby       | JRuby_InDy  | 9.07     | 11.25       | 1.4       | 624.63     |
| Ruby       | JRuby       | 9.09     | 11.01       | 1.3       | 563.04     |
| Python3    | GraalVM_JVM | 9.73     | 10.40       | 2.5       | 885.03     |
| Python2    | Jython      | 9.87     | 10.08       | 1.4       | 910.48     |
| Ruby3      |             | 10.83    | 11.10       | 0.0       | 79.89      |
| Ruby       | GraalVM     | 10.93    | 10.98       | 0.0       | 470.18     |
| Ruby3      | JIT         | 10.95    | 11.07       | 0.1       | 337.35     |
| Ruby2.7    | JIT         | 11.53    | 11.64       | 0.0       | 163.96     |
| Ruby2.7    |             | 11.57    | 11.66       | 0.0       | 163.63     |
| Python3    | GraalVM     | 15.05    | 15.45       | 0.1       | 909.98     |
| Ruby       | Rbx         | 22.15    | 22.60       | 0.1       | 89.04      |


## Regexdna (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Javascript | Node        | 0.45     | 1.12        | 0.5       | 520.22     |
| Crystal    |             | 1.36     | 1.44        | 0.1       | 408.37     |
| PHP        |             | 1.51     | 1.61        | 0.0       | 139.98     |
| PHP        | JIT         | 1.54     | 1.57        | 0.0       | 150.40     |
| Ruby       | GraalVM_JVM | 1.70     | 4.83        | 2.5       | 2226.61    |
| Ruby       | GraalVM     | 1.70     | 9.07        | 1.2       | 2627.81    |
| Python2    | Pypy        | 2.25     | 2.37        | 0.1       | 366.89     |
| Ruby       | Topaz       | 2.44     | 3.32        | 0.5       | 440.74     |
| Javascript | GraalVM_JVM | 2.65     | 7.20        | 5.7       | 1278.45    |
| Python3    | GraalVM_JVM | 2.70     | 9.27        | 5.7       | 2681.35    |
| Javascript | GraalVM     | 2.83     | 10.23       | 3.1       | 1099.70    |
| Python3    | GraalVM     | 3.73     | 12.90       | 2.2       | 1558.16    |
| Python3    | Mypyc       | 5.33     | 5.51        | 1.0       | 0.86       |
| Python3    |             | 5.33     | 5.39        | 1.0       | 180.27     |
| Python2    |             | 5.65     | 5.72        | 1.1       | 175.53     |
| C          | gcc         | 5.76     | 6.39        | 0.1       | 90.16      |
| Python3    | Nuitka      | 6.14     | 6.32        | 1.2       | 184.30     |
| Python3    | Cython      | 6.16     | 6.42        | 0.3       | 227.84     |
| Ruby2.7    | JIT         | 6.92     | 7.49        | 0.2       | 180.98     |
| Python2    | Jython      | 6.93     | 7.30        | 2.6       | 3190.83    |
| Ruby3      |             | 7.06     | 7.12        | 0.3       | 137.80     |
| Ruby3      | JIT         | 7.06     | 7.12        | 0.3       | 394.38     |
| Ruby2.7    |             | 7.09     | 7.63        | 0.2       | 181.13     |
| Ruby       | Rbx         | 7.29     | 12.62       | 1.6       | 461.59     |
| Lua        | JIT         | 8.89     | 8.96        | 0.6       | 295.70     |
| Lua        |             | 9.50     | 9.58        | 0.5       | 280.23     |
| Python3    | Pypy        | 11.80    | 11.80       | 0.2       | 351.41     |
| Ruby       | JRuby_InDy  | 11.94    | 13.75       | 1.7       | 481.93     |
| Ruby       | JRuby       | 12.27    | 14.00       | 1.7       | 451.22     |


## Revcomp (1 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.43     | 0.43        | 0.0       | 147.52     |
| Python2    |             | 2.27     | 2.27        | 0.0       | 862.75     |
| Python3    |             | 2.32     | 2.32        | 0.0       | 1178.08    |
| Python3    | Cython      | 2.42     | 2.42        | 0.0       | 1178.03    |
| Python3    | Nuitka      | 2.54     | 2.54        | 0.0       | 1180.54    |
| Python2    | Pypy        | 2.93     | 2.93        | 0.0       | 1462.03    |
| Lua        | JIT         | 3.18     | 3.18        | 0.0       | 381.83     |
| Javascript | Node        | 3.29     | 3.29        | 0.0       | 250.12     |
| Ruby2.7    | JIT         | 3.92     | 3.92        | 0.0       | 156.77     |
| Crystal    |             | 4.17     | 4.17        | 0.0       | 912.29     |
| Ruby2.7    |             | 4.31     | 4.31        | 0.0       | 156.52     |
| Ruby3      |             | 4.43     | 4.43        | 0.0       | 156.85     |
| Ruby3      | JIT         | 4.50     | 4.50        | 0.0       | 413.45     |
| Python3    | Pypy        | 5.04     | 5.04        | 0.0       | 1378.02    |
| Ruby       | Topaz       | 5.06     | 5.06        | 0.0       | 754.41     |
| Ruby       | JRuby_InDy  | 7.71     | 7.71        | 0.0       | 866.62     |
| Ruby       | JRuby       | 7.85     | 7.85        | 0.0       | 725.31     |
| Lua        |             | 8.82     | 8.82        | 0.0       | 806.30     |
| Javascript | GraalVM     | 8.86     | 8.86        | 0.0       | 933.43     |
| Python3    | GraalVM_JVM | 9.08     | 9.08        | 0.0       | 2728.39    |
| Python2    | Jython      | 11.54    | 11.54       | 0.0       | 2243.99    |
| Python3    | GraalVM     | 11.81    | 11.81       | 0.0       | 2746.70    |
| Ruby       | GraalVM_JVM | 13.40    | 13.40       | 0.0       | 2155.68    |
| Ruby       | GraalVM     | 14.15    | 14.15       | 0.0       | 1857.70    |
| Javascript | GraalVM_JVM | 14.48    | 14.48       | 0.0       | 1170.34    |
| Python3    | Mypyc       | crashed  | crashed     | crashed   | 0.00       |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 483.64     |
| PHP        |             | 443.32   |
| PHP        | JIT         | 444.19   |


## Spectralnorm (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.11     | 0.11        | 0.0       | 10.29      |
| C          | gcc         | 0.11     | 0.11        | 0.0       | 1.08       |
| Javascript | Node        | 0.11     | 0.12        | 0.1       | 48.09      |
| Crystal    |             | 0.11     | 0.12        | 0.0       | 4.08       |
| Lua        | JIT         | 0.12     | 0.12        | 0.0       | 2.42       |
| Javascript | GraalVM     | 0.13     | 0.63        | 0.2       | 441.21     |
| Javascript | GraalVM_JVM | 0.14     | 0.85        | 2.0       | 603.03     |
| Ruby       | GraalVM     | 0.22     | 0.36        | 0.0       | 338.00     |
| Python2    | Pypy        | 0.71     | 0.72        | 0.0       | 66.57      |
| Python3    | Pypy        | 0.79     | 0.83        | 0.0       | 64.31      |
| Python3    | GraalVM_JVM | 1.22     | 5.68        | 2.6       | 795.77     |
| Ruby       | Topaz       | 1.59     | 1.63        | 0.0       | 31.69      |
| Python3    | GraalVM     | 1.65     | 5.06        | 0.2       | 721.40     |
| PHP        | JIT         | 2.56     | 2.60        | 0.0       | 20.78      |
| Ruby       | JRuby_InDy  | 4.24     | 4.76        | 1.5       | 625.90     |
| Lua        |             | 4.54     | 4.56        | 0.0       | 2.73       |
| Ruby       | GraalVM_JVM | 4.82     | 5.39        | 1.7       | 630.11     |
| PHP        |             | 6.72     | 6.76        | 0.0       | 17.40      |
| Ruby3      | JIT         | 10.55    | 10.59       | 0.1       | 270.85     |
| Ruby       | JRuby       | 12.32    | 12.53       | 1.4       | 476.27     |
| Ruby2.7    | JIT         | 12.76    | 13.21       | 0.0       | 13.54      |
| Python3    | Mypyc       | 13.43    | 13.46       | 0.0       | 0.89       |
| Ruby3      |             | 16.04    | 16.05       | 0.0       | 14.36      |
| Ruby2.7    |             | 16.70    | 16.72       | 0.0       | 12.99      |
| Python2    |             | 18.89    | 19.23       | 0.0       | 6.95       |
| Python3    | Nuitka      | 20.65    | 20.81       | 0.0       | 11.02      |
| Python3    |             | 23.53    | 23.66       | 0.0       | 8.35       |
| Python2    | Jython      | 41.51    | 41.51       | 1.0       | 617.67     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 594.21     |

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
* `topaz (ruby-2.4.0p0) (git rev unknown) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
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
