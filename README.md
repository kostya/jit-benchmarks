# Benchmark for interpreted languages implementations.

Most programs from [benchmarks game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/index.html). All programs are chosen to be simplest, single-thread and without any low-level hacks. Also, the code for all languages trying to be implemented with one algorithm, use the same language constructs and containers, and be semantically similar to each other. The goal of the benchmark is to find the most successful JIT solutions. My other benchmarks: [Benchmarks](https://github.com/kostya/benchmarks), [Crystal Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game).

Compare:
		
		* Ruby (Ruby2.7, Ruby3, Graal, Topaz, JRuby, Rbx)
		* Python (Cpython, Graal, Pypy, Cython, Jython, Nuitka, Mypyc)
		* Lua (JIT)
		* Javascript (Node, Graal)
		* C, Crystal as a basis

Running on AMD Ryzen 7 3800X, 16Gb DDR-4 3200 Mghz, host os Windows10, VirtualBox with Ubuntu 20.04.01, in docker with os Debian/Testing. (This looks like big overhead - vm in vm, but i also test in Docker on pure Ubuntu, and perfomance is the same, and surprisingly on Windows it sometimes even faster O_o, AMD-V is something awesome).

Build Docker image (4.5Gb):

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
| C++        | g++         | 0.47     | 0.48        | 0.0       | 17.04      |
| Crystal    |             | 0.53     | 0.56        | 0.0       | 28.97      |
| Ruby       | GraalVM_JVM | 0.69     | 1.96        | 1.7       | 739.38     |
| Ruby       | JRuby_InDy  | 0.78     | 1.18        | 1.5       | 592.58     |
| Python3    | Cython      | 0.84     | 0.91        | 0.0       | 23.86      |
| C          | gcc         | 0.92     | 0.95        | 0.0       | 49.77      |
| Javascript | Node        | 0.94     | 1.06        | 0.1       | 139.31     |
| Ruby       | GraalVM     | 1.03     | 1.64        | 0.0       | 615.84     |
| Javascript | GraalVM_JVM | 1.42     | 2.46        | 1.8       | 761.21     |
| Python3    | GraalVM_JVM | 2.01     | 3.47        | 3.0       | 1048.27    |
| Ruby       | Topaz       | 2.04     | 2.19        | 0.0       | 63.32      |
| Javascript | GraalVM     | 2.06     | 2.81        | 0.2       | 810.99     |
| Ruby       | JRuby       | 3.03     | 3.34        | 1.5       | 562.57     |
| Python3    | GraalVM     | 3.07     | 4.14        | 0.1       | 974.04     |
| Python3    | Pypy        | 3.93     | 4.01        | 0.0       | 126.85     |
| Python2    | Pypy        | 3.99     | 4.18        | 0.0       | 141.14     |
| Ruby3      | JIT         | 4.29     | 4.31        | 0.1       | 296.94     |
| Ruby3      |             | 5.64     | 5.67        | 0.0       | 41.32      |
| Ruby2.7    | JIT         | 6.06     | 6.10        | 0.0       | 27.80      |
| Ruby2.7    |             | 6.73     | 6.75        | 0.0       | 47.03      |
| Lua        | JIT         | 7.17     | 8.09        | 0.0       | 184.43     |
| Ruby       | Rbx         | 15.65    | 16.11       | 0.1       | 421.44     |
| Lua        |             | 17.24    | 19.68       | 0.0       | 169.71     |
| Python2    | Jython      | 22.42    | 23.24       | 1.1       | 1021.79    |
| Python3    | Mypyc       | 26.47    | 26.76       | 0.0       | 0.73       |
| Python3    |             | 74.23    | 74.23       | 0.0       | 105.33     |
| Python3    | Nuitka      | 75.57    | 75.57       | 0.0       | 107.87     |
| Python2    |             | 90.99    | 90.99       | 0.0       | 205.93     |


## Brainfuck (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 2.56     | 2.56        | 0.0       | 1.59       |
| Crystal    |             | 4.76     | 4.76        | 0.0       | 3.16       |
| Javascript | Node        | 5.27     | 9.67        | 0.1       | 36.19      |
| Python2    | Pypy        | 6.70     | 7.41        | 0.0       | 61.90      |
| Python3    | Pypy        | 8.65     | 9.28        | 0.0       | 59.38      |
| Ruby       | GraalVM_JVM | 16.38    | 18.02       | 1.8       | 362.05     |
| Ruby       | Topaz       | 16.74    | 16.79       | 0.0       | 29.42      |
| Ruby       | GraalVM     | 17.11    | 18.21       | 0.0       | 308.84     |
| Python3    | GraalVM_JVM | 28.78    | 29.85       | 3.6       | 584.96     |
| Python3    | GraalVM     | 41.66    | 44.89       | 0.3       | 609.61     |
| Javascript | GraalVM_JVM | 50.90    | 51.14       | 1.9       | 483.73     |
| Ruby       | JRuby_InDy  | 57.93    | 58.84       | 1.5       | 297.98     |
| Javascript | GraalVM     | 73.07    | 75.16       | 0.2       | 602.63     |
| Python3    | Mypyc       | 102.52   | 102.63      | 0.0       | 0.73       |
| Ruby3      | JIT         | 109.28   | 109.28      | 0.1       | 270.12     |
| Ruby2.7    | JIT         | 111.57   | 111.57      | 0.0       | 13.15      |
| Ruby2.7    |             | 121.86   | 121.86      | 0.0       | 12.82      |
| Ruby3      |             | 124.13   | 124.13      | 0.0       | 13.40      |
| Ruby       | JRuby       | 142.35   | 142.35      | 1.5       | 279.37     |
| Python3    | Nuitka      | 163.35   | 163.35      | 0.0       | 10.71      |
| Python3    | Cython      | 174.77   | 174.77      | 0.0       | 9.28       |
| Ruby       | Rbx         | > 190    | > 190       | 0.1       | 1001.40    |
| Python2    |             | > 190    | > 190       | 0.0       | 6.07       |
| Python3    |             | > 190    | > 190       | 0.0       | 8.95       |
| Python2    | Jython      | > 190    | > 190       | 1.1       | 466.74     |


## Brainfuck2 (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.26     | 1.27        | 0.0       | 0.71       |
| Crystal    |             | 2.11     | 2.11        | 0.0       | 3.07       |
| Javascript | Node        | 3.85     | 9.10        | 0.1       | 37.87      |
| Lua        | JIT         | 5.93     | 6.36        | 0.0       | 2.23       |
| Ruby       | GraalVM_JVM | 6.58     | 10.64       | 1.7       | 713.26     |
| Ruby       | GraalVM     | 7.04     | 10.65       | 0.0       | 541.31     |
| Python3    | Pypy        | 11.16    | 11.25       | 0.1       | 68.75      |
| Python2    | Pypy        | 11.45    | 11.86       | 0.0       | 67.41      |
| Javascript | GraalVM_JVM | 12.41    | 12.95       | 1.9       | 659.43     |
| Python3    | GraalVM_JVM | 13.10    | 14.03       | 3.6       | 817.14     |
| Javascript | GraalVM     | 13.45    | 13.52       | 0.2       | 496.74     |
| Python3    | GraalVM     | 14.64    | 14.68       | 0.5       | 793.48     |
| Ruby       | Topaz       | 23.14    | 23.18       | 0.0       | 31.81      |
| Ruby       | JRuby_InDy  | 40.37    | 41.46       | 1.5       | 262.98     |
| Ruby3      | JIT         | 46.81    | 46.85       | 0.1       | 270.29     |
| Lua        |             | 57.35    | 57.36       | 0.0       | 1.43       |
| Ruby2.7    | JIT         | 66.88    | 67.00       | 0.0       | 13.23      |
| Python3    | Mypyc       | 75.70    | 75.91       | 0.0       | 0.72       |
| Ruby3      |             | 95.12    | 95.33       | 0.0       | 13.54      |
| Ruby       | JRuby       | 95.80    | 96.64       | 1.5       | 227.44     |
| Ruby2.7    |             | 97.67    | 97.80       | 0.0       | 12.79      |
| Python3    | Nuitka      | 133.79   | 133.79      | 0.0       | 10.70      |
| Python2    |             | 155.23   | 155.23      | 0.0       | 6.12       |
| Python3    |             | 155.71   | 155.71      | 0.0       | 8.86       |
| Python3    | Cython      | 188.72   | 188.72      | 0.0       | 9.50       |
| Python2    | Jython      | 209.80   | 209.80      | 1.1       | 476.05     |
| Ruby       | Rbx         | > 250    | > 250       | 0.1       | 1021.77    |


## Fannkuchredux (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.14     | 0.14        | 0.0       | 7.93       |
| Javascript | Node        | 0.16     | 0.20        | 0.1       | 36.50      |
| Javascript | GraalVM_JVM | 0.18     | 0.70        | 1.7       | 339.42     |
| C          | gcc         | 0.21     | 0.22        | 0.0       | 0.70       |
| Javascript | GraalVM     | 0.22     | 0.44        | 0.2       | 272.80     |
| Ruby       | GraalVM_JVM | 0.22     | 1.19        | 1.7       | 364.52     |
| Crystal    |             | 0.22     | 0.22        | 0.0       | 3.11       |
| Lua        | JIT         | 0.27     | 0.27        | 0.0       | 2.36       |
| Ruby       | GraalVM     | 0.31     | 0.65        | 0.0       | 293.14     |
| Python3    | GraalVM_JVM | 0.39     | 1.69        | 3.1       | 490.96     |
| Ruby       | Topaz       | 0.43     | 0.48        | 0.0       | 29.80      |
| Python3    | GraalVM     | 0.59     | 1.10        | 0.1       | 505.86     |
| Python2    | Pypy        | 0.70     | 0.72        | 0.0       | 65.46      |
| Ruby       | JRuby_InDy  | 1.13     | 2.12        | 1.5       | 260.50     |
| Lua        |             | 1.97     | 1.97        | 0.0       | 1.37       |
| Ruby       | JRuby       | 2.34     | 2.55        | 1.4       | 182.84     |
| Python3    | Mypyc       | 3.13     | 3.16        | 0.0       | 0.66       |
| Python3    | Pypy        | 3.36     | 3.36        | 0.0       | 59.70      |
| Python3    | Nuitka      | 3.67     | 3.72        | 0.0       | 9.84       |
| Python2    |             | 3.75     | 3.75        | 0.0       | 6.21       |
| Python3    |             | 4.19     | 4.20        | 0.0       | 7.85       |
| Python2    | Jython      | 4.43     | 5.34        | 1.1       | 455.48     |
| Ruby2.7    | JIT         | 4.73     | 4.79        | 0.0       | 12.88      |
| Ruby2.7    |             | 4.77     | 4.88        | 0.0       | 12.86      |
| Ruby3      |             | 5.54     | 5.55        | 0.0       | 13.44      |
| Ruby3      | JIT         | 5.62     | 5.64        | 0.1       | 270.05     |
| Ruby       | Rbx         | > 60     | > 60        | 0.1       | 502.86     |


## Fasta (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.63     | 0.63        | 0.0       | 0.65       |
| Crystal    |             | 0.85     | 0.86        | 0.0       | 3.75       |
| Lua        | JIT         | 1.54     | 1.56        | 0.0       | 2.34       |
| Ruby       | GraalVM_JVM | 2.66     | 5.46        | 2.3       | 448.52     |
| Python2    | Pypy        | 2.88     | 2.91        | 0.2       | 68.69      |
| Python3    | Pypy        | 3.30     | 3.35        | 0.2       | 67.69      |
| Javascript | Node        | 3.33     | 3.41        | 0.1       | 45.63      |
| Lua        |             | 3.67     | 3.69        | 0.0       | 1.32       |
| Ruby       | GraalVM     | 3.73     | 4.58        | 0.3       | 400.38     |
| Ruby       | Topaz       | 4.12     | 4.22        | 0.0       | 40.77      |
| Python3    | GraalVM_JVM | 4.77     | 10.78       | 3.5       | 662.95     |
| Python3    | Cython      | 5.66     | 5.69        | 0.0       | 8.35       |
| Python3    | Mypyc       | 6.31     | 6.34        | 0.0       | 0.72       |
| Python3    |             | 8.31     | 8.37        | 0.0       | 7.41       |
| Javascript | GraalVM_JVM | 8.73     | 17.16       | 2.0       | 614.66     |
| Python3    | GraalVM     | 8.87     | 12.67       | 0.6       | 596.14     |
| Python2    |             | 11.37    | 11.42       | 0.0       | 19.63      |
| Python3    | Nuitka      | 12.14    | 12.18       | 0.0       | 10.02      |
| Javascript | GraalVM     | 13.16    | 17.89       | 0.4       | 550.05     |
| Ruby3      | JIT         | 13.50    | 13.57       | 0.1       | 289.82     |
| Ruby2.7    | JIT         | 17.62    | 17.75       | 0.0       | 57.29      |
| Ruby2.7    |             | 17.73    | 17.80       | 0.0       | 59.11      |
| Ruby3      |             | 17.79    | 18.02       | 0.1       | 33.23      |
| Ruby       | JRuby_InDy  | 20.46    | 20.83       | 1.5       | 256.93     |
| Ruby       | JRuby       | 28.48    | 28.53       | 1.8       | 288.71     |
| Python2    | Jython      | 36.60    | 37.13       | 1.3       | 559.30     |
| Ruby       | Rbx         | > 80     | > 80        | 0.2       | 539.93     |


## Knucleotide (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Lua        | JIT         | 0.87     | 1.03        | 0.0       | 44.98      |
| C++        | g++         | 2.01     | 2.04        | 0.2       | 30.66      |
| Python2    | Pypy        | 2.06     | 2.18        | 0.1       | 138.47     |
| Crystal    |             | 2.48     | 2.55        | 0.0       | 59.78      |
| Python3    | GraalVM_JVM | 2.79     | 4.29        | 3.8       | 697.67     |
| Python3    | Pypy        | 3.45     | 3.56        | 0.1       | 146.07     |
| Lua        |             | 3.92     | 4.09        | 0.1       | 63.02      |
| Ruby       | Topaz       | 5.09     | 5.35        | 0.2       | 118.86     |
| Javascript | Node        | 5.12     | 5.97        | 0.1       | 148.23     |
| Python3    | GraalVM     | 5.97     | 6.66        | 0.9       | 549.47     |
| Javascript | GraalVM_JVM | 6.13     | 7.25        | 3.8       | 556.20     |
| Ruby       | GraalVM_JVM | 6.19     | 9.71        | 3.3       | 690.75     |
| Python2    |             | 7.32     | 7.64        | 0.1       | 262.72     |
| Python3    | Cython      | 8.90     | 8.95        | 0.1       | 49.56      |
| Ruby       | JRuby_InDy  | 9.32     | 10.23       | 1.7       | 361.02     |
| Ruby       | GraalVM     | 9.33     | 13.55       | 1.0       | 990.39     |
| Python3    | Mypyc       | 9.39     | 9.46        | 0.1       | 0.73       |
| Python3    |             | 9.41     | 9.50        | 0.1       | 49.05      |
| Python2    | Jython      | 9.52     | 10.38       | 1.3       | 1392.27    |
| Ruby       | JRuby       | 9.56     | 11.03       | 1.7       | 440.48     |
| Ruby2.7    | JIT         | 9.92     | 10.31       | 0.1       | 61.23      |
| Javascript | GraalVM     | 10.09    | 10.97       | 2.7       | 658.43     |
| Python3    | Nuitka      | 10.23    | 10.29       | 0.1       | 51.04      |
| Ruby3      | JIT         | 10.64    | 11.15       | 0.2       | 336.45     |
| Ruby2.7    |             | 10.88    | 11.20       | 0.1       | 64.49      |
| Ruby3      |             | 12.15    | 12.31       | 0.1       | 87.00      |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 492.45     |


## Mandelbrot (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.46     | 0.46        | 0.0       | 0.65       |
| Crystal    |             | 0.46     | 0.46        | 0.0       | 3.12       |
| Python3    | Cython      | 0.46     | 0.47        | 0.0       | 7.95       |
| Javascript | Node        | 0.47     | 0.49        | 0.1       | 71.46      |
| Lua        | JIT         | 0.50     | 0.51        | 0.0       | 0.95       |
| Javascript | GraalVM_JVM | 0.51     | 1.89        | 1.9       | 388.29     |
| Python3    | Pypy        | 0.54     | 1.70        | 0.0       | 83.55      |
| Javascript | GraalVM     | 0.55     | 1.50        | 0.2       | 457.70     |
| Python2    | Pypy        | 0.56     | 1.80        | 0.0       | 87.02      |
| Ruby       | GraalVM     | 0.91     | 1.86        | 0.0       | 316.61     |
| Ruby       | GraalVM_JVM | 0.91     | 2.86        | 2.2       | 398.54     |
| Ruby       | Topaz       | 0.96     | 1.00        | 0.0       | 26.53      |
| Python3    | GraalVM_JVM | 1.01     | 1.66        | 3.2       | 441.50     |
| Python3    | GraalVM     | 1.30     | 1.45        | 0.1       | 338.18     |
| Lua        |             | 5.04     | 5.07        | 0.0       | 1.43       |
| Ruby       | JRuby_InDy  | 5.43     | 6.01        | 1.4       | 460.41     |
| Python2    | Jython      | 11.54    | 32.59       | 1.1       | 655.66     |
| Ruby       | JRuby       | 16.56    | 19.60       | 1.6       | 643.15     |
| Ruby2.7    | JIT         | 17.75    | 17.78       | 0.0       | 13.09      |
| Ruby2.7    |             | 17.76    | 17.80       | 0.0       | 12.86      |
| Ruby3      |             | 19.16    | 19.43       | 0.0       | 13.50      |
| Ruby3      | JIT         | 19.98    | 20.29       | 0.1       | 270.22     |
| Python3    | Mypyc       | 23.75    | 23.87       | 0.0       | 0.66       |
| Python3    |             | 28.83    | 28.86       | 0.0       | 16.29      |
| Python3    | Nuitka      | 30.42    | 30.58       | 0.0       | 18.51      |
| Python2    |             | 32.98    | 33.06       | 0.0       | 15.20      |
| Ruby       | Rbx         | > 120    | > 120       | 0.1       | 787.76     |


## Matmul (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.24     | 0.24        | 0.0       | 16.38      |
| Crystal    |             | 0.26     | 0.27        | 0.0       | 22.35      |
| Javascript | Node        | 0.26     | 0.28        | 0.1       | 76.88      |
| Lua        | JIT         | 0.28     | 0.28        | 0.0       | 47.64      |
| Javascript | GraalVM_JVM | 0.30     | 4.46        | 1.9       | 417.91     |
| Python3    | Pypy        | 0.35     | 0.37        | 0.0       | 82.00      |
| Python2    | Pypy        | 0.35     | 0.37        | 0.0       | 84.81      |
| Python3    | Cython      | 0.41     | 0.41        | 0.0       | 83.94      |
| Javascript | GraalVM     | 0.45     | 3.99        | 0.2       | 355.30     |
| Python3    | GraalVM_JVM | 0.48     | 1.72        | 3.5       | 532.79     |
| Python3    | GraalVM     | 0.49     | 0.94        | 0.2       | 458.04     |
| Ruby       | GraalVM_JVM | 0.68     | 2.17        | 1.7       | 511.51     |
| Ruby       | GraalVM     | 1.05     | 2.04        | 0.0       | 673.50     |
| Ruby       | Topaz       | 1.84     | 1.88        | 0.0       | 88.95      |
| Lua        |             | 6.13     | 6.18        | 0.0       | 73.95      |
| Ruby3      | JIT         | 15.65    | 15.70       | 0.1       | 315.77     |
| Ruby2.7    | JIT         | 16.85    | 16.93       | 0.0       | 58.50      |
| Ruby3      |             | 18.54    | 18.58       | 0.0       | 58.99      |
| Ruby2.7    |             | 19.00    | 19.05       | 0.0       | 58.22      |
| Python3    |             | 19.48    | 19.79       | 0.0       | 24.50      |
| Python2    |             | 22.46    | 22.63       | 0.0       | 21.88      |
| Python3    | Nuitka      | 22.70    | 22.73       | 0.0       | 25.86      |
| Python3    | Mypyc       | 23.91    | 24.07       | 0.0       | 0.66       |
| Ruby       | JRuby_InDy  | 25.50    | 27.74       | 1.5       | 657.30     |
| Ruby       | JRuby       | 35.45    | 35.74       | 1.5       | 576.41     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 720.04     |
| Python2    | Jython      | > 80     | > 80        | 1.2       | 450.19     |


## Nbody (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.68     | 0.69        | 0.0       | 7.79       |
| Javascript | Node        | 0.75     | 0.78        | 0.1       | 39.81      |
| Crystal    |             | 0.77     | 0.77        | 0.0       | 3.24       |
| C          | gcc         | 0.80     | 0.80        | 0.0       | 1.01       |
| Ruby       | GraalVM_JVM | 0.84     | 1.65        | 2.0       | 380.34     |
| Ruby       | GraalVM     | 1.02     | 1.32        | 0.3       | 299.38     |
| Lua        | JIT         | 1.15     | 1.17        | 0.0       | 1.02       |
| Python3    | GraalVM_JVM | 3.37     | 4.46        | 3.1       | 557.64     |
| Python3    | GraalVM     | 4.33     | 4.63        | 0.2       | 428.38     |
| Ruby       | Topaz       | 5.45     | 9.14        | 0.0       | 33.46      |
| Javascript | GraalVM     | 5.80     | 6.37        | 0.2       | 536.71     |
| Javascript | GraalVM_JVM | 6.24     | 7.83        | 2.4       | 386.59     |
| Python2    | Pypy        | 6.36     | 6.42        | 0.0       | 67.15      |
| Ruby       | JRuby_InDy  | 8.15     | 8.86        | 1.5       | 418.39     |
| Lua        |             | 17.44    | 17.52       | 0.0       | 1.38       |
| Ruby3      | JIT         | 27.73    | 27.75       | 0.1       | 270.29     |
| Python3    | Pypy        | 32.23    | 32.23       | 0.0       | 64.93      |
| Ruby2.7    | JIT         | 36.78    | 36.80       | 0.0       | 13.24      |
| Ruby2.7    |             | 42.80    | 42.80       | 0.0       | 12.88      |
| Ruby3      |             | 44.52    | 44.52       | 0.0       | 13.39      |
| Ruby       | JRuby       | 49.89    | 49.89       | 1.5       | 269.25     |
| Python3    |             | 49.90    | 49.90       | 0.0       | 8.09       |
| Python2    |             | 58.56    | 58.56       | 0.0       | 286.70     |
| Python2    | Jython      | 62.50    | 62.50       | 1.1       | 1072.20    |
| Python3    | Nuitka      | 66.95    | 66.95       | 0.0       | 10.20      |
| Ruby       | Rbx         | > 80     | > 80        | 0.2       | 605.08     |
| Python3    | Mypyc       | crashed  |             |           |            |


## Pidigits (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.63     | 1.64        | 0.0       | 5.49       |
| Python3    | Cython      | 1.75     | 1.75        | 0.0       | 11.51      |
| Javascript | Node        | 2.23     | 2.42        | 0.1       | 42.22      |
| Javascript | GraalVM     | 3.15     | 3.59        | 0.2       | 474.75     |
| Javascript | GraalVM_JVM | 3.79     | 4.38        | 2.1       | 342.32     |
| Crystal    |             | 5.82     | 6.55        | 0.0       | 7.39       |
| Python2    |             | 6.27     | 6.41        | 0.0       | 7.54       |
| Python3    | Mypyc       | 6.41     | 6.42        | 0.0       | 0.72       |
| Python3    |             | 6.46     | 6.57        | 0.0       | 9.11       |
| Python3    | Nuitka      | 7.00     | 7.03        | 0.0       | 11.50      |
| Ruby       | Topaz       | 7.39     | 7.43        | 0.0       | 35.21      |
| Ruby       | GraalVM_JVM | 8.09     | 8.55        | 1.7       | 665.53     |
| Python2    | Pypy        | 8.42     | 8.82        | 0.0       | 69.98      |
| Ruby       | JRuby_InDy  | 8.49     | 9.38        | 1.4       | 387.00     |
| Python3    | Pypy        | 8.68     | 8.90        | 0.0       | 65.58      |
| Ruby       | JRuby       | 8.83     | 9.59        | 1.5       | 461.59     |
| Python2    | Jython      | 9.64     | 10.15       | 1.1       | 696.97     |
| Python3    | GraalVM_JVM | 10.46    | 11.17       | 3.1       | 737.56     |
| Ruby       | GraalVM     | 11.02    | 11.22       | 0.0       | 383.44     |
| Ruby3      | JIT         | 11.12    | 11.18       | 0.1       | 337.36     |
| Ruby3      |             | 11.23    | 11.66       | 0.0       | 79.91      |
| Ruby2.7    |             | 11.71    | 11.80       | 0.0       | 163.69     |
| Ruby2.7    | JIT         | 11.72    | 11.81       | 0.0       | 163.64     |
| Python3    | GraalVM     | 15.34    | 15.63       | 0.1       | 665.70     |
| Ruby       | Rbx         | 22.49    | 22.60       | 0.1       | 89.05      |


## Regexdna (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Javascript | Node        | 0.45     | 0.99        | 0.4       | 608.45     |
| Crystal    |             | 1.34     | 1.38        | 0.1       | 408.23     |
| Ruby       | GraalVM_JVM | 1.67     | 6.14        | 3.7       | 1657.30    |
| Ruby       | GraalVM     | 1.67     | 9.52        | 1.3       | 2503.38    |
| Python3    | GraalVM_JVM | 2.06     | 7.54        | 5.2       | 1676.43    |
| Javascript | GraalVM_JVM | 2.13     | 7.64        | 7.0       | 1608.17    |
| Python2    | Pypy        | 2.17     | 2.27        | 0.1       | 329.50     |
| Javascript | GraalVM     | 2.18     | 11.39       | 3.7       | 1061.76    |
| Ruby       | Topaz       | 2.26     | 3.14        | 0.4       | 440.91     |
| Python3    | GraalVM     | 2.86     | 9.97        | 1.4       | 998.57     |
| Python3    |             | 5.12     | 5.13        | 0.8       | 185.02     |
| Python3    | Mypyc       | 5.13     | 5.19        | 0.8       | 0.73       |
| Python2    |             | 5.56     | 5.67        | 0.8       | 179.55     |
| C          | gcc         | 5.63     | 6.36        | 0.1       | 90.09      |
| Ruby2.7    | JIT         | 5.89     | 6.24        | 0.2       | 181.27     |
| Ruby2.7    |             | 5.99     | 6.33        | 0.2       | 181.10     |
| Python3    | Nuitka      | 6.42     | 6.44        | 1.1       | 182.44     |
| Ruby3      |             | 6.55     | 6.61        | 0.3       | 137.89     |
| Ruby3      | JIT         | 6.57     | 6.61        | 0.3       | 394.39     |
| Python3    | Cython      | 6.58     | 6.63        | 0.3       | 228.38     |
| Ruby       | Rbx         | 6.74     | 11.78       | 1.5       | 429.74     |
| Python2    | Jython      | 7.04     | 7.37        | 2.3       | 1352.54    |
| Lua        |             | 8.88     | 8.96        | 0.5       | 300.92     |
| Lua        | JIT         | 8.96     | 9.01        | 0.6       | 274.47     |
| Ruby       | JRuby_InDy  | 9.97     | 11.08       | 1.7       | 404.66     |
| Ruby       | JRuby       | 10.71    | 11.77       | 1.6       | 442.88     |
| Python3    | Pypy        | 11.48    | 11.48       | 0.2       | 363.45     |


## Revcomp (1 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.47     | 0.47        | 0.0       | 137.14     |
| Python3    |             | 2.09     | 2.09        | 0.0       | 1183.07    |
| Python2    |             | 2.10     | 2.10        | 0.0       | 805.16     |
| Python3    | Nuitka      | 2.26     | 2.26        | 0.0       | 1185.86    |
| Lua        | JIT         | 2.62     | 2.62        | 0.0       | 395.30     |
| Python2    | Pypy        | 2.64     | 2.64        | 0.0       | 1312.89    |
| Javascript | Node        | 3.49     | 3.49        | 0.0       | 231.54     |
| Python3    | Cython      | 3.55     | 3.55        | 0.0       | 1183.47    |
| Python3    | Pypy        | 3.80     | 3.80        | 0.0       | 1341.07    |
| Ruby2.7    | JIT         | 4.07     | 4.07        | 0.0       | 156.77     |
| Ruby3      | JIT         | 4.15     | 4.15        | 0.0       | 413.34     |
| Ruby2.7    |             | 4.27     | 4.27        | 0.0       | 156.10     |
| Ruby3      |             | 4.37     | 4.37        | 0.0       | 156.89     |
| Ruby       | Topaz       | 4.44     | 4.44        | 0.0       | 815.95     |
| Crystal    |             | 5.15     | 5.15        | 0.0       | 911.25     |
| Ruby       | JRuby       | 6.92     | 6.92        | 0.0       | 764.96     |
| Ruby       | JRuby_InDy  | 6.94     | 6.94        | 0.0       | 849.57     |
| Lua        |             | 7.89     | 7.89        | 0.0       | 806.25     |
| Javascript | GraalVM     | 8.28     | 8.28        | 0.0       | 940.21     |
| Python3    | GraalVM     | 11.29    | 11.29       | 0.0       | 2773.11    |
| Javascript | GraalVM_JVM | 12.90    | 12.90       | 0.0       | 914.90     |
| Ruby       | GraalVM_JVM | 14.12    | 14.12       | 0.0       | 1473.93    |
| Ruby       | GraalVM     | 15.88    | 15.88       | 0.0       | 1687.89    |
| Python3    | Mypyc       | crashed  | crashed     | crashed   | 0.00       |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 494.32     |
| Python3    | GraalVM_JVM | crashed  | crashed     | crashed   | 1489.10    |
| Python2    | Jython      | crashed  | crashed     | crashed   | 1219.54    |


## Spectralnorm (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.11     | 0.11        | 0.0       | 0.89       |
| Python3    | Cython      | 0.11     | 0.11        | 0.0       | 10.44      |
| Javascript | Node        | 0.11     | 0.13        | 0.1       | 38.93      |
| Crystal    |             | 0.12     | 0.12        | 0.0       | 4.20       |
| Lua        | JIT         | 0.13     | 0.13        | 0.0       | 2.36       |
| Javascript | GraalVM     | 0.13     | 0.73        | 0.2       | 426.36     |
| Ruby       | GraalVM     | 0.22     | 0.43        | 0.0       | 314.66     |
| Javascript | GraalVM_JVM | 0.28     | 1.61        | 1.9       | 511.43     |
| Ruby       | GraalVM_JVM | 0.37     | 1.19        | 1.8       | 450.49     |
| Python2    | Pypy        | 0.68     | 0.69        | 0.0       | 67.19      |
| Python3    | Pypy        | 0.73     | 0.77        | 0.0       | 64.39      |
| Python3    | GraalVM_JVM | 1.17     | 7.32        | 3.2       | 540.57     |
| Ruby       | Topaz       | 1.52     | 1.57        | 0.0       | 31.89      |
| Python3    | GraalVM     | 1.70     | 5.41        | 0.1       | 601.62     |
| Ruby       | JRuby_InDy  | 3.60     | 3.83        | 1.5       | 395.70     |
| Lua        |             | 4.43     | 4.46        | 0.0       | 2.62       |
| Ruby3      | JIT         | 9.75     | 9.79        | 0.1       | 270.93     |
| Ruby       | JRuby       | 11.25    | 11.50       | 1.5       | 399.87     |
| Ruby2.7    | JIT         | 13.13    | 13.50       | 0.0       | 13.67      |
| Python3    | Mypyc       | 14.64    | 14.75       | 0.0       | 0.66       |
| Python2    |             | 14.68    | 14.74       | 0.0       | 7.06       |
| Ruby3      |             | 15.63    | 15.68       | 0.0       | 14.47      |
| Ruby2.7    |             | 16.75    | 16.80       | 0.0       | 14.28      |
| Python3    |             | 17.14    | 17.30       | 0.0       | 8.20       |
| Python3    | Nuitka      | 20.56    | 20.65       | 0.0       | 10.52      |
| Python2    | Jython      | 41.36    | 41.36       | 1.1       | 458.44     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 614.80     |


## Versions:
* `Python 2.7.18`
* `Python 3.9.10`
* `Crystal 1.3.2 [932f193ae] (2022-01-18)`
* `gcc (Debian 11.2.0-16) 11.2.0`
* `g++ (Debian 11.2.0-16) 11.2.0`
* `Lua 5.4.4  Copyright (C) 1994-2022 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/`
* `Nodejs v12.22.9`
* `ruby 2.7.5p203 (2021-11-24 revision f69aeb8314) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev d9acd472) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.3.3.0 (2.6.8) 2022-01-19 b26de1f5c5 OpenJDK 64-Bit Server VM 17.0.2+8-Debian-1 on 17.0.2+8-Debian-1 +jit [linux-x86_64]`
* `Cython version 0.29.28`
* `truffleruby 22.0.0.2, like ruby 3.0.2, GraalVM CE Native [x86_64-linux]`
* `truffleruby 22.0.0.2, like ruby 3.0.2, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.18 (b89256933b0b, Oct 04 2021, 15:22:08) [PyPy 7.3.6 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.8.12 (d00b0afd2a5dd3c13fcda75d738262c864c62fa7, Feb 18 2022, 09:52:33) [PyPy 7.3.8 with GCC 10.2.1 20210130 (Red Hat 10.2.1-11)]`
* `openjdk version "17.0.2" 2022-01-18`
* `GraalVM Python 3.8.5 (GraalVM CE Native 22.0.0.2)`
* `GraalVM Python 3.8.5 (GraalVM CE JVM 22.0.0.2)`
* `GraalNode v14.18.1`
* `Jython 2.7.2`
* `Nuitka 0.7.3`
* `ruby 3.1.1p18 (2022-02-18 revision 53f5fc4236) [x86_64-linux]`
* `rubinius 5.0 (10.0 a0a9ed90 2020-05-16 7.0.0) [x86_64-linux-gnu]`
* `mypy 0.931`

