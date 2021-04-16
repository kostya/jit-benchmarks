# Benchmark for interpreted languages implementations.

Most programs from [benchmarks game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/index.html). All programs are chosen to be simplest, single-thread and without any low-level hacks. Also, the code for all languages trying to be implemented with one algorithm, use the same language constructs and containers, and be semantically similar to each other. The goal of the benchmark is to find the most successful JIT solutions. My other benchmarks: [Benchmarks](https://github.com/kostya/benchmarks), [Crystal Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game).

Compare:
		
		* Ruby (Ruby2.7, Ruby3, Graal, [Topaz](https://github.com/kostya/topaz), JRuby, Rbx)
		* Python (Cpython, Graal, Pypy, Cython, Jython, Nuitka)
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

## Spectralnorm (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.11     | 0.11        | 0.0       | 0.83       |
| Python3    | Cython      | 0.11     | 0.11        | 0.0       | 10.05      |
| Javascript | Node        | 0.11     | 0.13        | 0.1       | 38.92      |
| Crystal    |             | 0.12     | 0.12        | 0.0       | 4.40       |
| Lua        | JIT         | 0.12     | 0.13        | 0.0       | 2.39       |
| Ruby       | GraalVM     | 0.22     | 0.39        | 0.2       | 420.65     |
| Ruby       | GraalVM_JVM | 0.22     | 0.93        | 1.9       | 523.73     |
| Javascript | GraalVM     | 0.24     | 0.62        | 0.3       | 573.21     |
| Javascript | GraalVM_JVM | 0.37     | 0.84        | 1.9       | 707.74     |
| Python2    | Pypy        | 0.67     | 0.69        | 0.0       | 67.96      |
| Python3    | Pypy        | 0.77     | 0.81        | 0.0       | 69.39      |
| Ruby       | Topaz       | 1.49     | 1.54        | 0.0       | 32.17      |
| Lua        |             | 4.36     | 4.40        | 0.0       | 2.75       |
| Ruby       | JRuby_InDy  | 5.39     | 5.72        | 1.0       | 450.43     |
| Ruby3      | JIT         | 10.00    | 10.52       | 0.0       | 14.35      |
| Ruby       | JRuby       | 10.12    | 10.45       | 1.2       | 376.28     |
| Ruby2.7    | JIT         | 12.51    | 12.52       | 0.0       | 14.38      |
| Python3    | GraalVM_JVM | 12.52    | 15.69       | 4.8       | 977.92     |
| Python2    |             | 15.24    | 15.30       | 0.0       | 7.16       |
| Ruby2.7    |             | 15.62    | 15.66       | 0.0       | 13.73      |
| Ruby3      |             | 16.47    | 16.71       | 0.0       | 14.03      |
| Python3    |             | 18.30    | 18.34       | 0.0       | 8.23       |
| Python3    | GraalVM     | 19.80    | 20.14       | 0.1       | 1151.59    |
| Python3    | Nuitka      | 25.42    | 25.70       | 0.0       | 11.38      |
| Python2    | Jython      | 40.25    | 40.25       | 1.7       | 528.58     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 614.75     |


## Knucleotide (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Lua        | JIT         | 0.89     | 1.04        | 0.0       | 45.11      |
| C++        | g++         | 2.16     | 2.21        | 0.2       | 30.59      |
| Python2    | Pypy        | 2.18     | 2.27        | 0.1       | 138.36     |
| Crystal    |             | 2.36     | 2.39        | 0.0       | 52.98      |
| Python3    | Pypy        | 3.53     | 3.55        | 0.1       | 147.86     |
| Python3    | GraalVM_JVM | 3.66     | 6.23        | 9.7       | 1121.65    |
| Lua        |             | 4.46     | 4.50        | 0.1       | 63.45      |
| Ruby       | Topaz       | 5.12     | 5.19        | 0.2       | 119.28     |
| Javascript | Node        | 5.23     | 6.18        | 0.2       | 160.95     |
| Javascript | GraalVM_JVM | 6.40     | 8.99        | 8.6       | 971.75     |
| Python2    |             | 6.68     | 6.76        | 0.1       | 263.32     |
| Python3    | GraalVM     | 7.32     | 10.61       | 2.6       | 1103.11    |
| Ruby       | JRuby       | 8.58     | 9.28        | 1.5       | 558.90     |
| Ruby       | JRuby_InDy  | 8.79     | 9.11        | 1.6       | 649.40     |
| Python3    |             | 8.97     | 8.99        | 0.1       | 48.93      |
| Ruby2.7    | JIT         | 9.25     | 9.45        | 0.1       | 88.64      |
| Python3    | Cython      | 9.45     | 9.48        | 0.1       | 49.76      |
| Javascript | GraalVM     | 9.96     | 11.81       | 4.2       | 1118.26    |
| Python2    | Jython      | 10.40    | 11.12       | 2.2       | 1605.11    |
| Ruby3      | JIT         | 10.43    | 10.73       | 0.1       | 98.71      |
| Python3    | Nuitka      | 10.67    | 10.81       | 0.1       | 51.77      |
| Ruby2.7    |             | 11.11    | 11.25       | 0.1       | 89.09      |
| Ruby3      |             | 12.57    | 12.64       | 0.1       | 97.70      |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 492.53     |
| Ruby       | GraalVM     | > 60     | > 60        | 1.1       | 662.25     |
| Ruby       | GraalVM_JVM | > 60     | > 60        | 4.5       | 630.57     |


## Fannkuchredux (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.14     | 0.14        | 0.0       | 8.09       |
| Javascript | Node        | 0.16     | 0.20        | 0.1       | 37.11      |
| Javascript | GraalVM_JVM | 0.20     | 0.68        | 1.8       | 516.73     |
| Crystal    |             | 0.21     | 0.21        | 0.0       | 3.11       |
| C          | gcc         | 0.22     | 0.22        | 0.0       | 0.57       |
| Javascript | GraalVM     | 0.23     | 0.43        | 0.1       | 419.37     |
| Lua        | JIT         | 0.27     | 0.27        | 0.0       | 2.25       |
| Ruby       | GraalVM_JVM | 0.29     | 1.15        | 1.7       | 529.16     |
| Ruby       | GraalVM     | 0.34     | 0.71        | 0.0       | 534.18     |
| Python3    | GraalVM_JVM | 0.40     | 1.50        | 4.4       | 849.17     |
| Ruby       | Topaz       | 0.43     | 0.49        | 0.0       | 30.10      |
| Python3    | GraalVM     | 0.55     | 1.27        | 0.2       | 715.26     |
| Python2    | Pypy        | 0.69     | 0.71        | 0.0       | 66.36      |
| Ruby       | JRuby_InDy  | 1.32     | 2.25        | 1.1       | 206.75     |
| Lua        |             | 1.66     | 1.70        | 0.0       | 1.31       |
| Ruby       | JRuby       | 2.24     | 2.65        | 1.1       | 175.72     |
| Python3    | Pypy        | 3.53     | 3.53        | 0.1       | 60.59      |
| Python2    |             | 3.80     | 3.82        | 0.0       | 6.34       |
| Python3    |             | 3.99     | 4.00        | 0.0       | 7.64       |
| Python3    | Nuitka      | 4.11     | 4.12        | 0.0       | 10.51      |
| Ruby3      |             | 4.16     | 4.20        | 0.0       | 13.30      |
| Ruby3      | JIT         | 4.16     | 4.49        | 0.0       | 13.64      |
| Python2    | Jython      | 4.44     | 4.92        | 1.8       | 506.50     |
| Ruby2.7    |             | 4.59     | 4.64        | 0.0       | 13.56      |
| Ruby2.7    | JIT         | 4.61     | 4.76        | 0.0       | 13.60      |
| Ruby       | Rbx         | > 60     | > 60        | 0.1       | 502.85     |


## Pidigits (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.64     | 1.65        | 0.0       | 5.34       |
| Python3    | Cython      | 1.76     | 1.84        | 0.0       | 11.55      |
| Javascript | Node        | 2.25     | 2.35        | 0.1       | 42.18      |
| Javascript | GraalVM     | 3.41     | 3.77        | 0.2       | 715.29     |
| Javascript | GraalVM_JVM | 4.70     | 5.35        | 2.1       | 677.35     |
| Crystal    |             | 5.63     | 6.80        | 0.0       | 8.51       |
| Python3    |             | 6.26     | 6.30        | 0.0       | 9.16       |
| Python2    |             | 6.33     | 6.42        | 0.0       | 7.96       |
| Python3    | Nuitka      | 7.03     | 7.35        | 0.0       | 12.07      |
| Ruby       | Topaz       | 8.04     | 8.25        | 0.0       | 35.38      |
| Python2    | Pypy        | 8.68     | 8.82        | 0.0       | 70.85      |
| Python3    | Pypy        | 8.73     | 8.91        | 0.0       | 67.73      |
| Ruby       | JRuby       | 8.83     | 9.21        | 1.0       | 383.46     |
| Ruby       | JRuby_InDy  | 9.16     | 10.13       | 1.0       | 407.77     |
| Ruby       | GraalVM_JVM | 9.62     | 10.34       | 1.8       | 777.07     |
| Python2    | Jython      | 10.26    | 10.74       | 1.7       | 773.18     |
| Ruby3      | JIT         | 11.27    | 11.73       | 0.0       | 152.80     |
| Ruby3      |             | 11.34    | 11.53       | 0.0       | 152.88     |
| Ruby       | GraalVM     | 11.67    | 12.11       | 0.0       | 898.81     |
| Ruby2.7    | JIT         | 11.78    | 11.94       | 0.0       | 164.42     |
| Ruby2.7    |             | 11.80    | 12.16       | 0.0       | 164.27     |
| Python3    | GraalVM_JVM | 12.75    | 13.28       | 4.2       | 1084.82    |
| Python3    | GraalVM     | 15.81    | 16.39       | 0.1       | 1170.71    |
| Ruby       | Rbx         | 23.45    | 23.64       | 0.1       | 89.30      |


## Binarytrees (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 0.45     | 0.45        | 0.0       | 16.80      |
| Crystal    |             | 0.68     | 0.78        | 0.0       | 37.94      |
| Ruby       | GraalVM_JVM | 0.69     | 3.63        | 1.6       | 1167.12    |
| Python3    | Cython      | 0.77     | 0.84        | 0.0       | 24.22      |
| Ruby       | JRuby_InDy  | 0.80     | 1.36        | 1.2       | 765.91     |
| C          | gcc         | 0.85     | 0.85        | 0.0       | 49.92      |
| Ruby       | GraalVM     | 1.01     | 2.09        | 0.0       | 860.02     |
| Javascript | Node        | 1.29     | 1.56        | 0.1       | 144.84     |
| Javascript | GraalVM_JVM | 1.95     | 3.66        | 2.6       | 1449.33    |
| Ruby       | Topaz       | 2.07     | 2.22        | 0.0       | 63.47      |
| Javascript | GraalVM     | 2.50     | 3.22        | 0.1       | 1062.63    |
| Ruby       | JRuby       | 2.67     | 2.96        | 1.1       | 557.80     |
| Python3    | GraalVM_JVM | 3.29     | 21.59       | 5.8       | 1754.27    |
| Python3    | Pypy        | 4.23     | 4.45        | 0.0       | 127.47     |
| Python2    | Pypy        | 4.54     | 4.75        | 0.0       | 140.46     |
| Ruby3      | JIT         | 4.86     | 5.03        | 0.0       | 53.75      |
| Python3    | GraalVM     | 5.26     | 13.42       | 0.1       | 1541.63    |
| Ruby3      |             | 5.48     | 5.55        | 0.0       | 53.50      |
| Ruby2.7    | JIT         | 5.87     | 5.91        | 0.0       | 40.19      |
| Ruby2.7    |             | 6.33     | 6.37        | 0.0       | 39.12      |
| Lua        | JIT         | 8.90     | 10.03       | 0.0       | 184.50     |
| Ruby       | Rbx         | 15.68    | 15.96       | 0.1       | 421.41     |
| Lua        |             | 22.19    | 24.72       | 0.0       | 145.56     |
| Python2    | Jython      | 24.92    | 25.41       | 2.0       | 1289.77    |
| Python3    | Nuitka      | 83.60    | 83.60       | 0.0       | 108.20     |
| Python3    |             | 85.84    | 85.84       | 0.0       | 105.23     |
| Python2    |             | > 100    | > 100       | 0.0       | 205.80     |


## Revcomp (1 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.46     | 0.46        | 0.0       | 147.41     |
| Python2    |             | 2.20     | 2.20        | 0.0       | 815.62     |
| Python3    |             | 2.25     | 2.25        | 0.0       | 1183.05    |
| Python3    | Cython      | 2.64     | 2.64        | 0.0       | 1183.71    |
| Python3    | Nuitka      | 2.70     | 2.70        | 0.0       | 1186.21    |
| Lua        | JIT         | 2.75     | 2.75        | 0.0       | 395.34     |
| Python2    | Pypy        | 3.10     | 3.10        | 0.0       | 1402.64    |
| Crystal    |             | 3.84     | 3.84        | 0.0       | 916.49     |
| Ruby2.7    | JIT         | 3.90     | 3.90        | 0.0       | 157.33     |
| Javascript | Node        | 4.00     | 4.00        | 0.0       | 230.50     |
| Ruby2.7    |             | 4.00     | 4.00        | 0.0       | 157.07     |
| Ruby3      | JIT         | 4.20     | 4.20        | 0.0       | 157.43     |
| Ruby3      |             | 4.40     | 4.40        | 0.0       | 157.31     |
| Ruby       | Topaz       | 4.84     | 4.84        | 0.0       | 841.23     |
| Python3    | Pypy        | 5.47     | 5.47        | 0.0       | 1441.71    |
| Ruby       | JRuby       | 7.34     | 7.34        | 0.0       | 828.41     |
| Ruby       | JRuby_InDy  | 8.14     | 8.14        | 0.0       | 831.43     |
| Lua        |             | 9.20     | 9.20        | 0.0       | 649.44     |
| Javascript | GraalVM     | 11.47    | 11.47       | 0.0       | 1414.57    |
| Ruby       | GraalVM     | 13.42    | 13.42       | 0.0       | 1985.41    |
| Ruby       | GraalVM_JVM | 16.06    | 16.06       | 0.0       | 2008.59    |
| Javascript | GraalVM_JVM | 22.31    | 22.31       | 0.0       | 1197.00    |
| Python3    | GraalVM_JVM | 24.26    | 24.26       | 0.0       | 2141.66    |
| Python3    | GraalVM     | 40.05    | 40.05       | 0.0       | 3206.81    |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 483.73     |
| Python2    | Jython      | crashed  | crashed     | crashed   | 1503.15    |


## Nbody (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.73     | 0.75        | 0.0       | 7.86       |
| C          | gcc         | 0.74     | 0.75        | 0.0       | 0.88       |
| Javascript | Node        | 0.75     | 0.77        | 0.1       | 38.64      |
| Crystal    |             | 0.78     | 0.79        | 0.0       | 3.23       |
| Lua        | JIT         | 1.14     | 1.16        | 0.0       | 2.39       |
| Ruby       | GraalVM_JVM | 1.18     | 2.41        | 2.7       | 552.54     |
| Ruby       | GraalVM     | 1.20     | 1.68        | 0.2       | 618.84     |
| Javascript | GraalVM     | 3.78     | 4.07        | 0.1       | 685.03     |
| Python3    | GraalVM_JVM | 3.79     | 4.66        | 4.7       | 735.32     |
| Python3    | GraalVM     | 4.49     | 4.91        | 0.1       | 608.31     |
| Ruby       | Topaz       | 5.67     | 9.46        | 0.0       | 33.80      |
| Javascript | GraalVM_JVM | 6.19     | 6.83        | 1.9       | 677.36     |
| Python2    | Pypy        | 6.28     | 6.45        | 0.0       | 67.85      |
| Ruby       | JRuby_InDy  | 8.18     | 9.60        | 1.7       | 731.75     |
| Lua        |             | 18.18    | 18.27       | 0.0       | 1.25       |
| Python3    | Pypy        | 31.17    | 31.17       | 0.0       | 63.87      |
| Ruby2.7    | JIT         | 35.80    | 35.85       | 0.0       | 13.73      |
| Ruby       | JRuby       | 45.82    | 45.82       | 1.7       | 620.23     |
| Ruby2.7    |             | 48.09    | 48.09       | 0.0       | 13.45      |
| Python3    |             | 48.59    | 48.59       | 0.0       | 8.00       |
| Ruby3      | JIT         | 51.82    | 51.82       | 0.0       | 13.55      |
| Ruby3      |             | 52.22    | 52.22       | 0.0       | 13.31      |
| Python2    |             | 55.94    | 55.94       | 0.0       | 286.77     |
| Python2    | Jython      | 61.66    | 61.66       | 1.6       | 1088.25    |
| Python3    | Nuitka      | 73.61    | 73.61       | 0.0       | 10.95      |
| Ruby       | Rbx         | > 80     | > 80        | 0.2       | 594.85     |


## Fasta (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.62     | 0.63        | 0.0       | 0.55       |
| Crystal    |             | 0.84     | 0.85        | 0.0       | 4.25       |
| Lua        | JIT         | 1.55     | 1.55        | 0.0       | 2.37       |
| Ruby       | GraalVM_JVM | 2.56     | 5.53        | 1.7       | 810.31     |
| Ruby       | GraalVM     | 2.95     | 3.91        | 0.0       | 883.45     |
| Python2    | Pypy        | 2.97     | 3.01        | 0.0       | 68.42      |
| Python3    | Pypy        | 3.51     | 3.57        | 0.0       | 66.28      |
| Javascript | Node        | 3.53     | 3.59        | 0.1       | 45.56      |
| Lua        |             | 3.84     | 3.86        | 0.0       | 1.25       |
| Ruby       | Topaz       | 4.07     | 4.18        | 0.0       | 43.01      |
| Python3    | Cython      | 5.75     | 5.83        | 0.0       | 8.52       |
| Python3    | GraalVM_JVM | 6.19     | 14.16       | 4.5       | 1006.68    |
| Python3    |             | 8.47     | 8.53        | 0.0       | 7.60       |
| Python3    | GraalVM     | 9.05     | 15.15       | 0.1       | 1109.50    |
| Python2    |             | 11.63    | 11.72       | 0.0       | 19.93      |
| Javascript | GraalVM_JVM | 11.93    | 25.83       | 1.9       | 946.60     |
| Python3    | Nuitka      | 12.81    | 12.85       | 0.0       | 10.57      |
| Ruby       | JRuby_InDy  | 14.86    | 15.40       | 1.2       | 364.30     |
| Ruby2.7    |             | 16.42    | 16.70       | 0.0       | 52.07      |
| Ruby3      | JIT         | 16.43    | 16.49       | 0.0       | 42.64      |
| Ruby2.7    | JIT         | 18.88    | 19.06       | 0.1       | 69.99      |
| Ruby3      |             | 19.25    | 19.53       | 0.0       | 42.45      |
| Javascript | GraalVM     | 20.42    | 25.17       | 0.1       | 983.49     |
| Ruby       | JRuby       | 23.59    | 23.86       | 1.1       | 355.91     |
| Python2    | Jython      | 37.21    | 37.40       | 1.6       | 520.98     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 539.89     |


## Regexdna (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Javascript | Node        | 0.48     | 1.05        | 0.6       | 610.61     |
| Javascript | GraalVM_JVM | 2.02     | 14.10       | 10.6      | 1331.86    |
| Python2    | Pypy        | 2.22     | 2.33        | 0.3       | 367.70     |
| Ruby       | Topaz       | 2.35     | 3.16        | 0.4       | 476.29     |
| Python3    |             | 5.00     | 5.05        | 0.9       | 183.53     |
| Javascript | GraalVM     | 5.06     | 25.54       | 8.9       | 1319.13    |
| Python2    |             | 5.16     | 5.22        | 1.0       | 180.33     |
| Crystal    |             | 5.55     | 5.58        | 0.1       | 372.58     |
| C          | gcc         | 5.77     | 6.59        | 0.1       | 90.18      |
| Ruby2.7    |             | 5.98     | 6.44        | 0.2       | 181.71     |
| Ruby2.7    | JIT         | 5.99     | 6.36        | 0.2       | 181.75     |
| Ruby3      |             | 6.26     | 6.62        | 0.2       | 182.16     |
| Ruby3      | JIT         | 6.28     | 6.65        | 0.2       | 182.13     |
| Python3    | Cython      | 6.32     | 6.37        | 0.3       | 224.84     |
| Python3    | Nuitka      | 6.34     | 6.37        | 1.0       | 183.49     |
| Ruby       | Rbx         | 7.02     | 12.32       | 1.6       | 450.87     |
| Python2    | Jython      | 7.13     | 8.14        | 3.1       | 1777.36    |
| Ruby       | GraalVM_JVM | 8.06     | 9.04        | 3.7       | 1383.88    |
| Lua        | JIT         | 9.07     | 9.18        | 0.6       | 274.49     |
| Lua        |             | 9.56     | 9.61        | 0.5       | 293.83     |
| Ruby       | JRuby_InDy  | 9.92     | 11.33       | 1.3       | 453.32     |
| Ruby       | JRuby       | 10.04    | 11.36       | 1.5       | 457.89     |
| Python3    | Pypy        | 11.82    | 11.82       | 0.3       | 357.60     |
| Ruby       | GraalVM     | 14.32    | 15.19       | 1.0       | 1658.77    |
| Python3    | GraalVM     | crashed  | crashed     | crashed   | 4134.39    |
| Python3    | GraalVM_JVM | crashed  | crashed     | crashed   | 1362.53    |


## Brainfuck (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 2.40     | 2.43        | 0.0       | 1.48       |
| Crystal    |             | 4.91     | 4.91        | 0.0       | 3.16       |
| Javascript | Node        | 5.27     | 9.64        | 0.1       | 37.36      |
| Python2    | Pypy        | 6.86     | 7.89        | 0.0       | 63.17      |
| Python3    | Pypy        | 9.76     | 9.94        | 0.1       | 66.76      |
| Ruby       | GraalVM_JVM | 17.58    | 18.91       | 2.4       | 552.24     |
| Ruby       | Topaz       | 17.61    | 17.62       | 0.1       | 29.76      |
| Ruby       | GraalVM     | 19.11    | 19.90       | 0.3       | 623.05     |
| Javascript | GraalVM_JVM | 39.25    | 42.22       | 1.9       | 844.95     |
| Python3    | GraalVM     | 43.30    | 45.49       | 0.9       | 802.16     |
| Python3    | GraalVM_JVM | 44.74    | 44.81       | 5.2       | 1002.43    |
| Javascript | GraalVM     | 50.14    | 51.46       | 0.2       | 773.80     |
| Ruby       | JRuby_InDy  | 53.91    | 55.24       | 1.1       | 412.81     |
| Ruby2.7    | JIT         | 105.16   | 105.30      | 0.0       | 13.52      |
| Ruby3      | JIT         | 105.91   | 106.32      | 0.0       | 13.59      |
| Ruby2.7    |             | 121.42   | 121.82      | 0.0       | 13.38      |
| Ruby3      |             | 122.18   | 122.22      | 0.1       | 13.24      |
| Ruby       | JRuby       | 127.82   | 127.82      | 1.5       | 398.49     |
| Python3    | Cython      | 182.86   | 182.86      | 0.0       | 9.41       |
| Python3    | Nuitka      | 204.84   | 204.84      | 0.0       | 11.00      |
| Python2    |             | 229.81   | 229.81      | 0.0       | 6.07       |
| Ruby       | Rbx         | > 250    | > 250       | 0.2       | 1133.30    |
| Python3    |             | > 250    | > 250       | 0.0       | 8.91       |
| Python2    | Jython      | > 250    | > 250       | 1.8       | 488.32     |


## Matmul (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.24     | 0.24        | 0.0       | 16.34      |
| Crystal    |             | 0.26     | 0.27        | 0.0       | 22.29      |
| Javascript | Node        | 0.27     | 0.28        | 0.1       | 75.75      |
| Lua        | JIT         | 0.28     | 0.29        | 0.0       | 46.45      |
| Python2    | Pypy        | 0.36     | 0.37        | 0.0       | 84.85      |
| Python3    | Pypy        | 0.36     | 0.38        | 0.0       | 84.04      |
| Python3    | Cython      | 0.41     | 0.41        | 0.0       | 84.28      |
| Ruby       | Topaz       | 1.96     | 2.05        | 0.0       | 88.97      |
| Ruby       | GraalVM_JVM | 1.98     | 3.90        | 1.7       | 975.52     |
| Python3    | GraalVM_JVM | 2.21     | 4.22        | 5.4       | 840.76     |
| Python3    | GraalVM     | 2.30     | 3.00        | 0.3       | 821.47     |
| Javascript | GraalVM_JVM | 2.35     | 4.13        | 2.2       | 604.33     |
| Ruby       | GraalVM     | 2.35     | 3.35        | 0.0       | 856.48     |
| Javascript | GraalVM     | 2.86     | 4.17        | 0.1       | 461.75     |
| Lua        |             | 5.85     | 6.04        | 0.0       | 74.20      |
| Ruby2.7    | JIT         | 14.16    | 14.51       | 0.0       | 59.11      |
| Ruby2.7    |             | 18.54    | 19.02       | 0.0       | 58.81      |
| Python3    |             | 18.65    | 18.84       | 0.0       | 24.52      |
| Ruby3      |             | 19.53    | 19.64       | 0.0       | 58.90      |
| Ruby3      | JIT         | 20.40    | 20.57       | 0.0       | 59.11      |
| Python2    |             | 24.11    | 24.24       | 0.0       | 22.29      |
| Ruby       | JRuby_InDy  | 25.52    | 28.12       | 1.0       | 485.28     |
| Python3    | Nuitka      | 26.38    | 26.66       | 0.0       | 26.57      |
| Ruby       | JRuby       | 28.75    | 36.79       | 1.0       | 702.28     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 720.14     |
| Python2    | Jython      | > 80     | > 80        | 2.1       | 589.69     |


## Brainfuck2 (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.26     | 1.27        | 0.0       | 0.49       |
| Crystal    |             | 2.11     | 2.12        | 0.0       | 3.11       |
| Javascript | Node        | 3.89     | 9.22        | 0.1       | 37.46      |
| Lua        | JIT         | 6.01     | 6.48        | 0.0       | 2.29       |
| Ruby       | GraalVM_JVM | 10.64    | 13.28       | 2.1       | 1090.10    |
| Python3    | GraalVM_JVM | 11.15    | 15.53       | 6.8       | 977.66     |
| Python2    | Pypy        | 11.85    | 11.86       | 0.0       | 67.96      |
| Python3    | Pypy        | 11.87    | 12.06       | 0.0       | 64.79      |
| Ruby       | GraalVM     | 11.91    | 19.61       | 0.0       | 931.88     |
| Python3    | GraalVM     | 13.48    | 14.90       | 0.3       | 852.70     |
| Javascript | GraalVM     | 14.08    | 15.06       | 0.1       | 724.22     |
| Javascript | GraalVM_JVM | 16.53    | 17.13       | 1.9       | 727.48     |
| Ruby       | Topaz       | 23.62    | 23.62       | 0.0       | 31.73      |
| Ruby       | JRuby_InDy  | 42.32    | 44.35       | 1.4       | 507.82     |
| Lua        |             | 51.19    | 52.79       | 0.0       | 1.24       |
| Ruby2.7    | JIT         | 56.45    | 56.61       | 0.0       | 13.73      |
| Ruby3      | JIT         | 57.68    | 58.18       | 0.0       | 13.49      |
| Ruby       | JRuby       | 91.72    | 93.29       | 1.2       | 364.79     |
| Ruby2.7    |             | 95.75    | 98.10       | 0.0       | 13.36      |
| Ruby3      |             | 113.55   | 113.74      | 0.0       | 13.27      |
| Python3    | Nuitka      | 149.00   | 149.00      | 0.0       | 11.44      |
| Python3    |             | 152.45   | 152.45      | 0.0       | 8.80       |
| Python2    |             | 167.61   | 167.61      | 0.0       | 6.64       |
| Python3    | Cython      | 187.85   | 187.85      | 0.0       | 9.49       |
| Python2    | Jython      | 192.09   | 192.09      | 2.1       | 523.74     |
| Ruby       | Rbx         | > 250    | > 250       | 0.2       | 1021.73    |


## Mandelbrot (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.46     | 0.47        | 0.0       | 0.49       |
| Crystal    |             | 0.46     | 0.46        | 0.0       | 3.05       |
| Python3    | Cython      | 0.46     | 0.47        | 0.0       | 7.86       |
| Javascript | Node        | 0.48     | 0.49        | 0.1       | 71.52      |
| Lua        | JIT         | 0.51     | 0.51        | 0.0       | 0.93       |
| Javascript | GraalVM     | 0.56     | 1.46        | 0.1       | 806.21     |
| Javascript | GraalVM_JVM | 0.56     | 1.65        | 2.2       | 611.68     |
| Python2    | Pypy        | 0.58     | 1.87        | 0.0       | 85.16      |
| Python3    | Pypy        | 0.58     | 1.90        | 0.0       | 82.15      |
| Ruby       | GraalVM     | 0.87     | 1.98        | 0.0       | 668.09     |
| Ruby       | GraalVM_JVM | 0.95     | 3.75        | 1.7       | 707.86     |
| Ruby       | Topaz       | 1.00     | 1.02        | 0.0       | 27.09      |
| Python3    | GraalVM     | 1.30     | 1.98        | 0.1       | 739.14     |
| Python3    | GraalVM_JVM | 1.37     | 2.39        | 5.4       | 790.57     |
| Ruby       | JRuby_InDy  | 5.71     | 6.41        | 1.1       | 440.02     |
| Lua        |             | 5.81     | 5.86        | 0.0       | 1.29       |
| Ruby       | JRuby       | 13.68    | 14.78       | 1.1       | 411.16     |
| Python2    | Jython      | 17.18    | 37.50       | 2.0       | 874.00     |
| Ruby2.7    | JIT         | 20.05    | 20.10       | 0.0       | 13.61      |
| Ruby2.7    |             | 20.34    | 20.45       | 0.0       | 13.65      |
| Ruby3      |             | 21.78    | 22.08       | 0.0       | 13.55      |
| Ruby3      | JIT         | 21.86    | 22.05       | 0.0       | 13.73      |
| Python3    |             | 29.32    | 30.05       | 0.0       | 16.26      |
| Python3    | Nuitka      | 33.36    | 33.50       | 0.0       | 19.16      |
| Python2    |             | 35.20    | 36.08       | 0.0       | 15.32      |
| Ruby       | Rbx         | > 120    | > 120       | 0.1       | 787.88     |

## Versions: 
* `Python 2.7.18`
* `Python 3.9.2`
* `Crystal 1.0.0 [dd40a2442] (2021-03-22)`
* `gcc (Debian 10.2.1-6) 10.2.1 20210110`
* `g++ (Debian 10.2.1-6) 10.2.1 20210110`
* `Lua 5.4.2  Copyright (C) 1994-2020 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/`
* `Nodejs v12.21.0`
* `ruby 2.7.3p183 (2021-04-05 revision 6847ee089d) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev d9acd472) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.2.17.0 (2.5.8) 2021-03-29 84d363da97 OpenJDK 64-Bit Server VM 17-ea+17-Debian-1 on 17-ea+17-Debian-1 +jit [linux-x86_64]`
* `Cython version 0.29.21`
* `truffleruby 21.0.0.2, like ruby 2.7.2, GraalVM CE Native [x86_64-linux]`
* `truffleruby 21.0.0.2, like ruby 2.7.2, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.18 (63df5ef41012, Apr 04 2021, 10:19:14) [PyPy 7.3.4 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.7.10 (51efa818fd9b, Apr 04 2021, 11:22:34) [PyPy 7.3.4 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `openjdk version "17-ea" 2021-09-14`
* `Python 3.8.5 (GraalVM CE Native 21.0.0.2)`
* `Python 3.8.5 (GraalVM CE JVM 21.0.0.2)`
* `GraalNode v12.20.1`
* `Jython 2.7.2`
* `Nuitka 0.6.13`
* `ruby 3.0.1p64 (2021-04-05 revision 0fb782ee38) [x86_64-linux]`
* `rubinius 5.0 (10.0 a0a9ed90 2020-05-16 7.0.0) [x86_64-linux-gnu]`

