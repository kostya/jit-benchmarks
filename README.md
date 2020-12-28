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

## Spectralnorm (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.11     | 0.11        | 0.0       | 0.75       |
| Python3    | Cython      | 0.11     | 0.12        | 0.0       | 10.18      |
| Javascript | Node        | 0.11     | 0.12        | 0.1       | 38.99      |
| Crystal    |             | 0.12     | 0.12        | 0.0       | 4.38       |
| Lua        | JIT         | 0.12     | 0.13        | 0.0       | 2.31       |
| Ruby       | GraalVM     | 0.22     | 0.33        | 0.0       | 389.04     |
| Ruby       | GraalVM_JVM | 0.22     | 0.88        | 1.5       | 511.50     |
| Javascript | GraalVM     | 0.24     | 0.59        | 0.1       | 612.95     |
| Javascript | GraalVM_JVM | 0.31     | 0.85        | 1.7       | 716.00     |
| Python2    | Pypy        | 0.66     | 0.68        | 0.0       | 66.62      |
| Python3    | Pypy        | 0.77     | 0.80        | 0.0       | 62.97      |
| Ruby       | Topaz       | 1.50     | 1.57        | 0.0       | 31.77      |
| Lua        |             | 4.36     | 4.39        | 0.0       | 2.71       |
| Ruby       | JRuby_InDy  | 4.52     | 4.87        | 1.0       | 367.36     |
| Ruby       | JRuby       | 10.35    | 10.65       | 1.0       | 416.74     |
| Ruby3      | JIT         | 11.05    | 11.37       | 0.0       | 14.26      |
| Python3    | GraalVM_JVM | 11.65    | 15.98       | 4.2       | 932.14     |
| Ruby2.7    | JIT         | 11.78    | 12.06       | 0.0       | 14.15      |
| Ruby2.7    |             | 14.06    | 14.44       | 0.0       | 13.59      |
| Python2    |             | 14.56    | 14.90       | 0.0       | 7.21       |
| Ruby3      |             | 15.86    | 16.17       | 0.0       | 13.80      |
| Python3    |             | 18.49    | 19.01       | 0.0       | 8.12       |
| Python3    | GraalVM     | 19.98    | 20.05       | 0.1       | 1156.09    |
| Python3    | Nuitka      | 24.29    | 24.35       | 0.0       | 11.25      |
| Python2    | Jython      | 42.32    | 42.32       | 1.6       | 502.34     |
| Ruby       | Rbx         | > 80     | > 80        | > 80      | 614.48     |


## Knucleotide (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Lua        | JIT         | 0.87     | 1.06        | 0.0       | 45.12      |
| C++        | g++         | 1.84     | 1.89        | 0.2       | 30.57      |
| Python2    | Pypy        | 2.16     | 2.21        | 0.1       | 136.68     |
| Crystal    |             | 2.34     | 2.37        | 0.0       | 52.71      |
| Python3    | GraalVM_JVM | 3.45     | 6.34        | 10.1      | 1195.05    |
| Python3    | Pypy        | 3.68     | 3.73        | 0.3       | 146.56     |
| Lua        |             | 4.46     | 4.57        | 0.1       | 63.41      |
| Ruby       | Topaz       | 4.99     | 5.06        | 0.2       | 117.61     |
| Javascript | Node        | 5.37     | 6.07        | 0.2       | 158.18     |
| Javascript | GraalVM_JVM | 6.99     | 8.74        | 5.7       | 953.99     |
| Python2    |             | 7.18     | 7.32        | 0.1       | 263.13     |
| Python3    | GraalVM     | 7.73     | 9.96        | 2.6       | 1089.27    |
| Ruby       | JRuby_InDy  | 8.36     | 8.65        | 1.6       | 577.04     |
| Python3    | Cython      | 9.07     | 9.17        | 0.1       | 49.75      |
| Python3    |             | 9.24     | 9.43        | 0.1       | 48.92      |
| Ruby2.7    | JIT         | 9.28     | 9.57        | 0.1       | 91.71      |
| Python2    | Jython      | 9.33     | 10.57       | 2.2       | 1749.84    |
| Ruby3      | JIT         | 9.51     | 9.62        | 0.1       | 96.46      |
| Ruby       | JRuby       | 9.63     | 10.14       | 1.6       | 528.44     |
| Javascript | GraalVM     | 10.18    | 11.18       | 4.5       | 1121.25    |
| Python3    | Nuitka      | 10.36    | 10.47       | 0.1       | 51.61      |
| Ruby2.7    |             | 10.70    | 10.78       | 0.1       | 89.00      |
| Ruby3      |             | 11.16    | 11.29       | 0.1       | 99.64      |
| Ruby       | Rbx         | > 60     | > 60        | > 60      | 492.36     |
| Ruby       | GraalVM     | > 60     | > 60        | > 60      | 671.57     |
| Ruby       | GraalVM_JVM | > 60     | > 60        | > 60      | 625.28     |


## Fannkuchredux (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.13     | 0.14        | 0.0       | 7.85       |
| Javascript | Node        | 0.16     | 0.20        | 0.1       | 36.73      |
| Javascript | GraalVM_JVM | 0.20     | 0.60        | 1.7       | 509.31     |
| Crystal    |             | 0.22     | 0.22        | 0.0       | 3.20       |
| C          | gcc         | 0.22     | 0.22        | 0.0       | 0.50       |
| Javascript | GraalVM     | 0.23     | 0.42        | 0.1       | 420.98     |
| Lua        | JIT         | 0.27     | 0.28        | 0.0       | 2.30       |
| Ruby       | GraalVM_JVM | 0.28     | 1.13        | 1.7       | 519.00     |
| Ruby       | GraalVM     | 0.33     | 0.67        | 0.0       | 529.47     |
| Python3    | GraalVM_JVM | 0.38     | 1.39        | 4.3       | 815.60     |
| Ruby       | Topaz       | 0.44     | 0.49        | 0.0       | 29.80      |
| Python3    | GraalVM     | 0.54     | 1.24        | 0.1       | 712.70     |
| Python2    | Pypy        | 0.69     | 0.72        | 0.0       | 65.57      |
| Ruby       | JRuby_InDy  | 1.26     | 2.70        | 1.1       | 188.80     |
| Lua        |             | 1.66     | 1.70        | 0.0       | 1.17       |
| Ruby       | JRuby       | 2.16     | 2.31        | 1.1       | 170.26     |
| Python3    | Pypy        | 3.60     | 3.60        | 0.0       | 59.84      |
| Python2    |             | 3.85     | 3.89        | 0.0       | 6.09       |
| Python3    |             | 3.98     | 4.01        | 0.0       | 7.61       |
| Ruby3      |             | 4.25     | 4.32        | 0.0       | 13.24      |
| Ruby3      | JIT         | 4.27     | 4.37        | 0.0       | 13.42      |
| Python3    | Nuitka      | 4.32     | 4.36        | 0.0       | 10.31      |
| Ruby2.7    |             | 4.49     | 4.58        | 0.0       | 13.45      |
| Ruby2.7    | JIT         | 4.50     | 4.60        | 0.0       | 13.52      |
| Python2    | Jython      | 4.79     | 5.09        | 1.6       | 460.62     |
| Ruby       | Rbx         | > 60     | > 60        | > 60      | 502.80     |


## Pidigits (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.64     | 1.66        | 0.0       | 5.36       |
| Python3    | Cython      | 1.76     | 1.79        | 0.0       | 11.38      |
| Javascript | Node        | 2.29     | 2.42        | 0.1       | 42.12      |
| Javascript | GraalVM     | 3.36     | 3.76        | 0.2       | 721.22     |
| Javascript | GraalVM_JVM | 4.64     | 5.51        | 2.7       | 729.89     |
| Crystal    |             | 5.21     | 5.84        | 0.0       | 7.80       |
| Python2    |             | 6.40     | 6.42        | 0.0       | 7.92       |
| Python3    |             | 6.55     | 6.69        | 0.0       | 9.08       |
| Python3    | Nuitka      | 6.78     | 6.94        | 0.0       | 12.02      |
| Ruby       | Topaz       | 7.69     | 7.85        | 0.0       | 35.12      |
| Python3    | Pypy        | 8.56     | 8.65        | 0.0       | 67.14      |
| Python2    | Pypy        | 8.59     | 8.64        | 0.0       | 69.90      |
| Ruby       | JRuby_InDy  | 8.90     | 9.46        | 1.0       | 383.43     |
| Ruby       | JRuby       | 8.98     | 9.21        | 1.0       | 436.29     |
| Ruby       | GraalVM_JVM | 9.32     | 9.76        | 1.6       | 864.71     |
| Python2    | Jython      | 10.03    | 10.54       | 1.9       | 875.26     |
| Ruby3      |             | 11.12    | 11.22       | 0.0       | 149.17     |
| Ruby3      | JIT         | 11.20    | 11.40       | 0.0       | 150.37     |
| Ruby       | GraalVM     | 11.42    | 11.65       | 0.0       | 898.19     |
| Ruby2.7    |             | 11.42    | 11.49       | 0.0       | 163.82     |
| Ruby2.7    | JIT         | 11.47    | 11.61       | 0.0       | 164.09     |
| Python3    | GraalVM_JVM | 11.95    | 13.14       | 4.0       | 1081.50    |
| Python3    | GraalVM     | 15.24    | 15.54       | 0.1       | 1173.75    |
| Ruby       | Rbx         | 22.60    | 22.93       | 0.1       | 89.23      |


## Binarytrees (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 0.45     | 0.47        | 0.0       | 16.87      |
| Crystal    |             | 0.61     | 0.92        | 0.0       | 37.77      |
| Ruby       | GraalVM_JVM | 0.67     | 3.48        | 1.6       | 1199.15    |
| Python3    | Cython      | 0.78     | 0.85        | 0.0       | 24.14      |
| C          | gcc         | 0.88     | 0.90        | 0.0       | 49.71      |
| Javascript | Node        | 0.92     | 1.04        | 0.1       | 145.45     |
| Ruby       | GraalVM     | 0.94     | 2.01        | 0.0       | 869.73     |
| Javascript | GraalVM_JVM | 1.48     | 2.58        | 1.6       | 1233.04    |
| Ruby       | JRuby_InDy  | 1.63     | 2.18        | 1.0       | 569.35     |
| Ruby       | Topaz       | 1.98     | 2.15        | 0.0       | 63.23      |
| Javascript | GraalVM     | 2.03     | 2.50        | 0.1       | 1177.59    |
| Python3    | GraalVM_JVM | 2.68     | 17.62       | 4.0       | 1363.07    |
| Ruby       | JRuby       | 2.80     | 3.08        | 1.1       | 432.52     |
| Python3    | Pypy        | 3.68     | 3.88        | 0.0       | 117.85     |
| Ruby3      | JIT         | 3.85     | 3.94        | 0.0       | 53.28      |
| Python2    | Pypy        | 3.89     | 4.02        | 0.0       | 131.89     |
| Python3    | GraalVM     | 4.29     | 9.74        | 0.1       | 1583.86    |
| Ruby3      |             | 5.41     | 5.52        | 0.0       | 52.61      |
| Ruby2.7    | JIT         | 5.94     | 5.99        | 0.0       | 40.01      |
| Ruby2.7    |             | 6.51     | 6.63        | 0.0       | 37.32      |
| Lua        | JIT         | 7.16     | 7.68        | 0.0       | 183.39     |
| Ruby       | Rbx         | 15.54    | 15.81       | 0.1       | 421.14     |
| Lua        |             | 16.72    | 21.91       | 0.0       | 145.41     |
| Python2    | Jython      | 22.97    | 23.42       | 1.5       | 1024.74    |
| Python3    |             | 72.31    | 72.31       | 0.0       | 105.19     |
| Python3    | Nuitka      | 83.54    | 83.54       | 0.0       | 107.96     |
| Python2    |             | 89.59    | 89.59       | 0.0       | 206.03     |


## Revcomp (1 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.42     | 0.42        | 0.0       | 135.24     |
| Python3    |             | 2.02     | 2.02        | 0.0       | 1183.14    |
| Python2    |             | 2.03     | 2.03        | 0.0       | 894.20     |
| Python3    | Cython      | 2.30     | 2.30        | 0.0       | 1183.56    |
| Python3    | Nuitka      | 2.38     | 2.38        | 0.0       | 1186.21    |
| Python2    | Pypy        | 2.49     | 2.49        | 0.0       | 1348.89    |
| Lua        | JIT         | 2.62     | 2.62        | 0.0       | 395.28     |
| Javascript | Node        | 3.49     | 3.49        | 0.0       | 229.41     |
| Crystal    |             | 3.55     | 3.55        | 0.0       | 916.47     |
| Ruby2.7    |             | 3.66     | 3.66        | 0.0       | 157.25     |
| Ruby2.7    | JIT         | 3.67     | 3.67        | 0.0       | 157.31     |
| Ruby3      | JIT         | 4.03     | 4.03        | 0.0       | 157.36     |
| Ruby3      |             | 4.23     | 4.23        | 0.0       | 157.02     |
| Ruby       | Topaz       | 4.24     | 4.24        | 0.0       | 771.52     |
| Python3    | Pypy        | 4.94     | 4.94        | 0.0       | 1427.55    |
| Ruby       | JRuby       | 6.49     | 6.49        | 0.0       | 844.52     |
| Ruby       | JRuby_InDy  | 6.90     | 6.90        | 0.0       | 824.24     |
| Lua        |             | 8.77     | 8.77        | 0.0       | 649.49     |
| Javascript | GraalVM     | 9.17     | 9.17        | 0.0       | 1430.37    |
| Python2    | Jython      | 10.30    | 10.30       | 0.0       | 1770.99    |
| Ruby       | GraalVM     | 12.05    | 12.05       | 0.0       | 1983.95    |
| Ruby       | GraalVM_JVM | 13.46    | 13.46       | 0.0       | 1904.73    |
| Python3    | GraalVM_JVM | 17.78    | 17.78       | 0.0       | 2173.94    |
| Javascript | GraalVM_JVM | 18.05    | 18.05       | 0.0       | 1197.40    |
| Python3    | GraalVM     | 35.03    | 35.03       | 0.0       | 3130.14    |
| Ruby       | Rbx         | > 60     | > 60        | 0.0       | 504.65     |


## Nbody (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Python3    | Cython      | 0.72     | 0.72        | 0.0       | 7.71       |
| C          | gcc         | 0.72     | 0.72        | 0.0       | 0.80       |
| Javascript | Node        | 0.74     | 0.76        | 0.1       | 37.69      |
| Crystal    |             | 0.77     | 0.79        | 0.0       | 3.02       |
| Lua        | JIT         | 1.13     | 1.13        | 0.0       | 2.29       |
| Ruby       | GraalVM_JVM | 1.13     | 2.14        | 2.0       | 528.63     |
| Ruby       | GraalVM     | 1.18     | 1.51        | 0.1       | 616.97     |
| Javascript | GraalVM     | 3.75     | 4.03        | 0.1       | 687.41     |
| Python3    | GraalVM_JVM | 3.77     | 5.17        | 5.0       | 770.04     |
| Python3    | GraalVM     | 4.48     | 4.84        | 0.1       | 636.11     |
| Ruby       | Topaz       | 5.62     | 9.43        | 0.0       | 33.38      |
| Javascript | GraalVM_JVM | 6.07     | 6.88        | 1.8       | 654.21     |
| Python2    | Pypy        | 6.32     | 6.46        | 0.0       | 65.28      |
| Ruby       | JRuby_InDy  | 8.84     | 10.17       | 1.5       | 801.84     |
| Lua        |             | 16.49    | 16.80       | 0.0       | 1.17       |
| Python3    | Pypy        | 30.80    | 30.80       | 0.0       | 62.75      |
| Ruby3      | JIT         | 31.38    | 31.66       | 0.0       | 13.46      |
| Ruby2.7    | JIT         | 36.14    | 36.54       | 0.0       | 13.66      |
| Ruby       | JRuby       | 38.17    | 38.17       | 1.2       | 689.32     |
| Ruby3      |             | 46.75    | 46.75       | 0.0       | 13.25      |
| Ruby2.7    |             | 47.13    | 47.13       | 0.0       | 13.49      |
| Python3    |             | 51.05    | 51.05       | 0.0       | 7.98       |
| Python2    |             | 55.56    | 55.56       | 0.0       | 286.49     |
| Python2    | Jython      | 61.61    | 61.61       | 1.9       | 1138.62    |
| Python3    | Nuitka      | 74.54    | 74.54       | 0.0       | 10.34      |
| Ruby       | Rbx         | > 80     | > 80        | 0.2       | 614.93     |


## Fasta (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.62     | 0.62        | 0.0       | 0.55       |
| Crystal    |             | 0.83     | 0.84        | 0.0       | 4.29       |
| Lua        | JIT         | 1.53     | 1.54        | 0.0       | 2.35       |
| Ruby       | GraalVM_JVM | 2.44     | 5.13        | 1.6       | 814.00     |
| Ruby       | GraalVM     | 2.87     | 3.84        | 0.0       | 894.29     |
| Python2    | Pypy        | 2.93     | 2.98        | 0.0       | 67.32      |
| Python3    | Pypy        | 3.42     | 3.47        | 0.0       | 63.94      |
| Javascript | Node        | 3.67     | 3.78        | 0.1       | 43.82      |
| Lua        |             | 3.82     | 3.84        | 0.0       | 1.17       |
| Ruby       | Topaz       | 4.15     | 4.27        | 0.0       | 42.74      |
| Python3    | Cython      | 5.71     | 5.83        | 0.0       | 8.46       |
| Python3    | GraalVM_JVM | 6.18     | 14.25       | 5.0       | 1139.16    |
| Python3    |             | 8.61     | 8.65        | 0.0       | 7.39       |
| Python3    | GraalVM     | 9.13     | 14.84       | 0.1       | 1125.36    |
| Python2    |             | 11.20    | 11.24       | 0.0       | 19.60      |
| Python3    | Nuitka      | 12.08    | 12.11       | 0.0       | 10.37      |
| Javascript | GraalVM_JVM | 12.73    | 26.23       | 2.2       | 1107.13    |
| Ruby3      | JIT         | 15.03    | 15.27       | 0.0       | 42.42      |
| Ruby2.7    | JIT         | 15.34    | 15.72       | 0.0       | 61.82      |
| Ruby2.7    |             | 16.22    | 16.28       | 0.0       | 51.70      |
| Ruby3      |             | 17.93    | 18.30       | 0.0       | 42.24      |
| Ruby       | JRuby_InDy  | 18.21    | 18.97       | 1.1       | 287.70     |
| Javascript | GraalVM     | 19.15    | 24.45       | 0.1       | 981.35     |
| Ruby       | JRuby       | 26.55    | 26.93       | 1.1       | 232.96     |
| Python2    | Jython      | 38.11    | 38.33       | 1.9       | 581.96     |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 539.79     |


## Regexdna (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Javascript | Node        | 0.46     | 1.03        | 0.7       | 609.41     |
| Javascript | GraalVM_JVM | 2.01     | 13.75       | 13.1      | 1406.89    |
| Python2    | Pypy        | 2.19     | 2.32        | 0.3       | 366.89     |
| Ruby       | Topaz       | 2.29     | 3.03        | 0.4       | 476.17     |
| Javascript | GraalVM     | 4.30     | 25.49       | 7.9       | 1311.97    |
| Python3    |             | 5.02     | 5.04        | 0.8       | 181.88     |
| Crystal    |             | 5.54     | 5.61        | 0.1       | 371.51     |
| C          | gcc         | 5.68     | 6.40        | 0.1       | 90.17      |
| Python2    |             | 5.76     | 5.79        | 0.8       | 176.89     |
| Ruby2.7    |             | 5.95     | 6.32        | 0.2       | 181.76     |
| Ruby2.7    | JIT         | 5.97     | 6.31        | 0.2       | 181.77     |
| Ruby3      | JIT         | 6.02     | 6.45        | 0.2       | 226.69     |
| Ruby3      |             | 6.05     | 6.41        | 0.2       | 182.96     |
| Python3    | Nuitka      | 6.18     | 6.21        | 1.0       | 190.96     |
| Python3    | Cython      | 6.31     | 6.34        | 0.3       | 222.29     |
| Ruby       | Rbx         | 6.90     | 11.87       | 1.5       | 461.57     |
| Python2    | Jython      | 7.01     | 7.57        | 3.6       | 1525.10    |
| Ruby       | GraalVM_JVM | 7.74     | 9.13        | 4.7       | 1529.14    |
| Lua        | JIT         | 8.93     | 8.95        | 0.6       | 274.53     |
| Lua        |             | 9.32     | 9.40        | 0.5       | 270.18     |
| Ruby       | JRuby_InDy  | 9.81     | 10.97       | 1.7       | 438.57     |
| Ruby       | JRuby       | 10.50    | 10.83       | 1.7       | 485.07     |
| Python3    | Pypy        | 11.58    | 11.58       | 0.3       | 372.52     |
| Ruby       | GraalVM     | 14.07    | 14.90       | 1.0       | 1675.02    |
| Python3    | GraalVM     | > 60     | > 60        | 0.0       | 4434.77    |
| Python3    | GraalVM_JVM | crashed  | crashed     | crashed   | 1363.82    |


## Brainfuck (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C++        | g++         | 2.33     | 2.34        | 0.0       | 1.48       |
| Javascript | Node        | 5.27     | 9.60        | 0.1       | 37.10      |
| Crystal    |             | 5.29     | 5.29        | 0.0       | 3.04       |
| Python2    | Pypy        | 6.89     | 7.76        | 0.0       | 64.29      |
| Python3    | Pypy        | 9.67     | 9.96        | 0.1       | 65.98      |
| Ruby       | Topaz       | 16.91    | 16.98       | 0.1       | 29.79      |
| Ruby       | GraalVM_JVM | 17.67    | 19.56       | 2.3       | 578.70     |
| Ruby       | GraalVM     | 19.79    | 20.28       | 0.3       | 625.48     |
| Javascript | GraalVM_JVM | 39.78    | 43.41       | 2.3       | 1118.08    |
| Python3    | GraalVM_JVM | 41.30    | 47.28       | 6.0       | 1047.49    |
| Python3    | GraalVM     | 44.67    | 44.89       | 0.9       | 795.68     |
| Ruby       | JRuby_InDy  | 52.59    | 54.77       | 1.5       | 600.74     |
| Javascript | GraalVM     | 54.97    | 55.12       | 0.1       | 791.38     |
| Ruby2.7    | JIT         | 103.48   | 103.68      | 0.0       | 13.63      |
| Ruby3      | JIT         | 103.92   | 105.44      | 0.0       | 13.43      |
| Ruby2.7    |             | 116.24   | 118.15      | 0.0       | 13.34      |
| Ruby3      |             | 118.89   | 120.51      | 0.1       | 13.20      |
| Ruby       | JRuby       | 132.71   | 132.71      | 1.7       | 476.02     |
| Python3    | Cython      | 169.18   | 169.18      | 0.0       | 9.52       |
| Python3    | Nuitka      | 200.83   | 200.83      | 0.0       | 10.87      |
| Python2    |             | 215.58   | 215.58      | 0.0       | 6.22       |
| Python3    |             | 234.46   | 234.46      | 0.0       | 8.83       |
| Ruby       | Rbx         | > 250    | > 250       | 0.2       | 1143.53    |
| Python2    | Jython      | > 250    | > 250       | 2.0       | 606.98     |


## Matmul (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 0.24     | 0.24        | 0.0       | 16.54      |
| Crystal    |             | 0.26     | 0.26        | 0.0       | 22.32      |
| Javascript | Node        | 0.26     | 0.28        | 0.1       | 77.29      |
| Lua        | JIT         | 0.27     | 0.28        | 0.0       | 47.29      |
| Python3    | Pypy        | 0.35     | 0.38        | 0.0       | 82.78      |
| Python2    | Pypy        | 0.35     | 0.38        | 0.0       | 83.79      |
| Python3    | Cython      | 0.41     | 0.41        | 0.0       | 83.84      |
| Ruby       | Topaz       | 1.92     | 1.96        | 0.0       | 88.83      |
| Ruby       | GraalVM     | 2.02     | 3.13        | 0.0       | 858.47     |
| Ruby       | GraalVM_JVM | 2.06     | 3.42        | 2.0       | 1126.29    |
| Python3    | GraalVM_JVM | 2.15     | 4.53        | 6.0       | 926.86     |
| Python3    | GraalVM     | 2.20     | 2.86        | 0.3       | 818.72     |
| Javascript | GraalVM_JVM | 2.34     | 4.20        | 2.3       | 613.57     |
| Javascript | GraalVM     | 2.85     | 4.13        | 0.1       | 486.33     |
| Lua        |             | 6.37     | 6.43        | 0.0       | 74.11      |
| Ruby2.7    | JIT         | 14.43    | 14.74       | 0.0       | 59.20      |
| Ruby3      | JIT         | 15.41    | 15.56       | 0.0       | 59.21      |
| Ruby3      |             | 17.62    | 17.72       | 0.0       | 58.78      |
| Python3    |             | 18.38    | 18.73       | 0.0       | 24.58      |
| Ruby2.7    |             | 18.89    | 19.28       | 0.0       | 58.70      |
| Python2    |             | 19.48    | 19.53       | 0.0       | 22.04      |
| Ruby       | JRuby_InDy  | 21.00    | 27.09       | 1.4       | 781.67     |
| Ruby       | JRuby       | 24.01    | 35.06       | 1.4       | 748.38     |
| Python3    | Nuitka      | 33.71    | 33.75       | 0.0       | 26.50      |
| Ruby       | Rbx         | > 80     | > 80        | 0.1       | 710.01     |
| Python2    | Jython      | > 80     | > 80        | 2.0       | 563.73     |


## Brainfuck2 (2 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| C          | gcc         | 1.26     | 1.26        | 0.0       | 0.49       |
| Crystal    |             | 2.10     | 2.11        | 0.0       | 3.12       |
| Javascript | Node        | 3.82     | 8.96        | 0.1       | 37.55      |
| Lua        | JIT         | 6.03     | 6.43        | 0.0       | 2.29       |
| Ruby       | GraalVM     | 8.25     | 12.56       | 0.0       | 944.18     |
| Ruby       | GraalVM_JVM | 10.72    | 13.75       | 2.0       | 1127.52    |
| Python3    | GraalVM_JVM | 10.92    | 13.44       | 6.2       | 1021.02    |
| Python3    | Pypy        | 11.36    | 11.42       | 0.0       | 63.96      |
| Python2    | Pypy        | 11.45    | 11.48       | 0.0       | 66.67      |
| Python3    | GraalVM     | 12.54    | 13.95       | 0.3       | 850.96     |
| Javascript | GraalVM     | 13.88    | 15.56       | 0.1       | 739.73     |
| Javascript | GraalVM_JVM | 16.20    | 16.59       | 2.2       | 739.11     |
| Ruby       | Topaz       | 23.22    | 23.25       | 0.0       | 31.71      |
| Ruby       | JRuby_InDy  | 41.61    | 44.35       | 1.4       | 538.14     |
| Lua        |             | 50.42    | 50.45       | 0.0       | 1.28       |
| Ruby3      | JIT         | 53.53    | 53.70       | 0.0       | 13.46      |
| Ruby2.7    | JIT         | 56.64    | 56.66       | 0.0       | 13.61      |
| Ruby2.7    |             | 92.18    | 92.38       | 0.0       | 13.49      |
| Ruby       | JRuby       | 92.83    | 93.10       | 1.4       | 423.86     |
| Ruby3      |             | 107.48   | 107.56      | 0.0       | 13.27      |
| Python3    |             | 147.38   | 147.38      | 0.0       | 8.86       |
| Python2    |             | 154.79   | 154.79      | 0.0       | 6.72       |
| Python3    | Nuitka      | 160.25   | 160.25      | 0.0       | 11.45      |
| Python3    | Cython      | 185.86   | 185.86      | 0.0       | 9.66       |
| Python2    | Jython      | 201.40   | 201.40      | 2.0       | 553.93     |
| Ruby       | Rbx         | > 250    | > 250       | 0.1       | 1032.34    |


## Mandelbrot (5 runs)
| Language   | Interpreter | Best T,s | Longest T,s | Start T,s | MaxMem, Mb |
|------------|-------------|----------|-------------|-----------|------------|
| Crystal    |             | 0.46     | 0.46        | 0.0       | 3.15       |
| C          | gcc         | 0.46     | 0.46        | 0.0       | 0.49       |
| Python3    | Cython      | 0.46     | 0.46        | 0.0       | 8.02       |
| Javascript | Node        | 0.47     | 0.49        | 0.1       | 70.88      |
| Lua        | JIT         | 0.49     | 0.51        | 0.0       | 0.80       |
| Javascript | GraalVM     | 0.55     | 1.41        | 0.1       | 755.56     |
| Python3    | Pypy        | 0.55     | 1.76        | 0.0       | 75.20      |
| Javascript | GraalVM_JVM | 0.55     | 1.70        | 2.2       | 631.79     |
| Python2    | Pypy        | 0.56     | 1.79        | 0.0       | 84.07      |
| Ruby       | GraalVM     | 0.85     | 1.93        | 0.0       | 669.49     |
| Ruby       | GraalVM_JVM | 0.94     | 4.05        | 1.9       | 698.55     |
| Ruby       | Topaz       | 0.97     | 0.99        | 0.0       | 26.90      |
| Python3    | GraalVM     | 1.25     | 1.57        | 0.1       | 741.37     |
| Python3    | GraalVM_JVM | 1.33     | 2.30        | 5.0       | 807.79     |
| Ruby       | JRuby_InDy  | 5.48     | 6.82        | 1.4       | 792.89     |
| Lua        |             | 5.71     | 5.74        | 0.0       | 1.23       |
| Python2    | Jython      | 12.27    | 33.92       | 1.8       | 818.67     |
| Ruby       | JRuby       | 13.11    | 13.72       | 1.3       | 800.69     |
| Ruby3      | JIT         | 19.99    | 20.03       | 0.0       | 13.98      |
| Ruby3      |             | 20.10    | 20.16       | 0.0       | 13.47      |
| Ruby2.7    |             | 20.50    | 20.90       | 0.0       | 13.61      |
| Ruby2.7    | JIT         | 20.50    | 20.55       | 0.0       | 13.68      |
| Python3    |             | 29.99    | 30.04       | 0.0       | 16.38      |
| Python2    |             | 31.63    | 32.34       | 0.0       | 15.20      |
| Python3    | Nuitka      | 34.04    | 34.32       | 0.0       | 19.22      |
| Ruby       | Rbx         | > 120    | > 120       | 0.1       | 789.38     |


## Versions:
* `Python 2.7.18`
* `Python 3.9.1+`
* `Crystal 0.36.1 [c3a3c1823] (2021-02-02)`
* `gcc (Debian 10.2.1-6) 10.2.1 20210110`
* `g++ (Debian 10.2.1-6) 10.2.1 20210110`
* `Lua 5.4.2  Copyright (C) 1994-2020 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/`
* `Nodejs v12.20.1`
* `ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev d9acd472) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.2.14.0 (2.5.7) 2020-12-08 ebe64bafb9 OpenJDK 64-Bit Server VM 17-ea+7-Debian-1 on 17-ea+7-Debian-1 +jit [linux-x86_64]`
* `Cython version 0.29.21`
* `truffleruby 21.0.0, like ruby 2.7.2, GraalVM CE Native [x86_64-linux]`
* `truffleruby 21.0.0, like ruby 2.7.2, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.18 (a29ef73f9b32, Nov 09 2020, 18:42:06) [PyPy 7.3.3 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.7.9 (7e6e2bb30ac5, Nov 18 2020, 10:55:52) [PyPy 7.3.3-beta0 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `openjdk version "17-ea" 2021-09-14`
* `Python 3.8.5 (GraalVM CE Native 21.0.0)`
* `Python 3.8.5 (GraalVM CE JVM 21.0.0)`
* `GraalNode v12.20.1`
* `Jython 2.7.2`
* `Nuitka 0.6.11`
* `ruby 3.0.0p0 (2020-12-25 revision 95aff21468) [x86_64-linux]`
* `rubinius 5.0 (10.0 a0a9ed90 2020-05-16 7.0.0) [x86_64-linux-gnu]`
