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

## Update: 2023-02-28 (round 1)                                                                                                                                                              
                                                                                                                                                                                             
## binarytrees                                                                                                                                                                               
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |                                                                                                                    
|------------|-------------|----------|------|-------------|------------|                                                                                                                    
| C++        |             | 0.44     | 5    | 0.76        | 17.3       |                                                                                                                    
| Crystal    |             | 0.6      | 5    | 9.45        | 22.2       |                                                                                                                    
| Ruby2      | GraalVM_JVM | 0.69     | 5    | 1.86        | 2200.7     |                                                                                                                    
| Python3    | Cython      | 0.81     | 5    | 1.01        | 24.3       |                                                                                                                    
| C          |             | 0.87     | 5    | 0.58        | 49.6       |                                                                                                                    
| Javascript | Node        | 1.08     | 5    | 0.19        | 141.3      |                                                                                                                    
| Ruby2      | GraalVM     | 1.08     | 5    | 0.21        | 693.9      |                                                                                                                    
| Ruby2      | JRuby_InDy  | 1.24     | 5    | 1.64        | 2110.1     |                                                                                                                    
| Javascript | GraalVM_JVM | 1.39     | 5    | 1.99        | 2302.4     |                                                                                                                    
| Ruby2      | Topaz       | 1.97     | 5    | 0.22        | 63.1       |                                                                                                                    
| Python3    | GraalVM_JVM | 2.02     | 5    | 2.79        | 3265.2     |                                                                                                                    
| Javascript | GraalVM     | 2.16     | 5    | 0.5         | 656.9      |                                                                                                                    
| Ruby2      | JRuby       | 2.83     | 5    | 1.64        | 1224.6     |                                                                                                                    
| PHP        | JIT         | 2.93     | 5    | 0.16        | 71.8       |                                                                                                                    
| Python3    | GraalVM     | 3.41     | 5    | 0.32        | 1362.1     |                                                                                                                    
| Python3    | PYPY        | 3.84     | 5    | 0.21        | 123.8      |                                                                                                                    
| Python2    | PYPY        | 3.9      | 5    | 0.22        | 136.6      |                                                                                                                    
| Ruby3      | JIT         | 4.61     | 5    | 0.47        | 80.9       |                                                                                                                    
| PHP        |             | 5.84     | 5    | 0.18        | 68.0       |                                                                                                                    
| Ruby2      | JIT         | 6.06     | 5    | 0.23        | 45.1       |
| Ruby3      |             | 6.16     | 5    | 0.26        | 57.2       |
| Lua        | JIT         | 6.73     | 5    | 0.16        | 307.5      |
| Ruby2      |             | 6.75     | 5    | 0.2         | 44.6       |
| Lua        |             | 15.03    | 5    | 0.14        | 145.2      |
| Ruby2      | Rbx         | 15.47    | 5    | 0.34        | 420.7      |
| Python2    | Jython      | 22.79    | 4    | 1.39        | 795.5      |
| Python3    | MYPYC       | 23.25    | 4    | 2.47        | 56.3       |
| Python3    | Nuitka      | 72.55    | 1    | 3.73        | 107.0      |
| Python3    |             | 73.15    | 1    | 0.19        | 98.5       |
| Python2    |             | 92.39    | 1    | 0.22        | 205.7      |


## brainfuck
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C++        |             | 2.4      | 5    | 0.65        | 1.8        |
| Crystal    |             | 4.87     | 5    | 9.67        | 2.8        |
| Javascript | Node        | 5.88     | 5    | 0.24        | 46.9       |
| Python2    | PYPY        | 6.39     | 5    | 0.22        | 57.6       |
| Python3    | PYPY        | 8.77     | 5    | 0.25        | 61.3       |
| Python3    | GraalVM_JVM | 14.22    | 5    | 3.55        | 1767.9     |
| Ruby2      | GraalVM_JVM | 15.31    | 5    | 2.18        | 1368.9     |
| Ruby2      | GraalVM     | 15.47    | 4    | 0.21        | 563.6      |
| Ruby2      | Topaz       | 17.41    | 5    | 0.23        | 29.9       |
| Python3    | GraalVM     | 19.24    | 5    | 0.34        | 871.6      |
| Javascript | GraalVM_JVM | 52.08    | 3    | 2.71        | 1151.6     |
| Ruby2      | JRuby_InDy  | 53.48    | 3    | 2.17        | 798.7      |
| Javascript | GraalVM     | 76.16    | 2    | 0.55        | 435.2      |
| Python3    | MYPYC       | 93.55    | 2    | 2.8         | 9.4        |
| Ruby2      | JIT         | 102.28   | 1    | 0.68        | 21.1       |
| Ruby3      | JIT         | 103.92   | 1    | 0.83        | 24.8       |
| Ruby2      | JRuby       | 113.31   | 1    | 1.67        | 974.5      |
| Ruby2      |             | 115.31   | 1    | 0.27        | 20.9       |
| Ruby3      |             | 118.9    | 1    | 0.26        | 22.8       |
| Python3    | Cython      | 165.97   | 1    | 2.54        | 10.0       |
| Python3    | Nuitka      | 181.87   | 1    | 4.02        | 11.1       |
| Python2    | Jython      | > 190    | 0    | 1.49        | 410.9      |
| Python2    |             | > 190    | 0    | 0.21        | 6.4        |
| Python3    |             | > 190    | 0    | 0.19        | 9.4        |
| Ruby2      | Rbx         | > 190    | 0    | 0.35        | 1011.4     |


## brainfuck2
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 1.25     | 5    | 0.23        | 0.9        |
| Crystal    |             | 1.96     | 5    | 9.87        | 2.7        |
| Javascript | Node        | 3.65     | 5    | 0.17        | 46.0       |
| Ruby2      | GraalVM_JVM | 4.68     | 5    | 1.84        | 2015.0     |
| Ruby2      | GraalVM     | 5.57     | 5    | 0.23        | 586.4      |
| Lua        | JIT         | 8.32     | 5    | 0.18        | 2.6        |
| Javascript | GraalVM_JVM | 10.39    | 5    | 2.1         | 1329.5     |
| Python2    | PYPY        | 11.02    | 5    | 0.19        | 62.5       |
| Python3    | PYPY        | 11.03    | 5    | 0.25        | 63.1       |
| Javascript | GraalVM     | 11.42    | 5    | 0.48        | 543.6      |
| Python3    | GraalVM_JVM | 11.44    | 5    | 3.34        | 1769.2     |
| Python3    | GraalVM     | 14.47    | 5    | 0.4         | 1103.1     |
| Ruby2      | Topaz       | 22.71    | 5    | 0.23        | 31.8       |
| Lua        |             | 47.67    | 4    | 0.24        | 2.2        |
| Ruby2      | JRuby_InDy  | 50.68    | 4    | 2.07        | 792.6      |
| Ruby3      | JIT         | 60.37    | 3    | 0.97        | 25.4       |
| Ruby2      | JIT         | 64.41    | 3    | 0.76        | 21.1       |
| Python3    | MYPYC       | 77.25    | 2    | 2.75        | 9.4        |
| Ruby3      |             | 90.85    | 2    | 0.28        | 22.9       |
| Ruby2      | JRuby       | 92.37    | 2    | 1.54        | 804.2      |
| Ruby2      |             | 93.93    | 2    | 0.25        | 20.7       |
| Python3    |             | 142.26   | 1    | 0.2         | 9.5        |
| Python3    | Nuitka      | 142.7    | 1    | 3.83        | 11.1       |
| Python2    |             | 157.09   | 1    | 0.2         | 6.3        |
| Python2    | Jython      | 189.07   | 1    | 1.36        | 379.3      |
| Ruby2      | Rbx         | > 215    | 0    | 0.35        | 960.8      |


## fannkuchredux
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | Cython      | 0.13     | 5    | 0.96        | 8.2        |
| Javascript | Node        | 0.15     | 5    | 0.24        | 45.4       |
| Javascript | GraalVM_JVM | 0.18     | 5    | 2.11        | 732.1      |
| Crystal    |             | 0.19     | 5    | 9.51        | 2.8        |
| Javascript | GraalVM     | 0.19     | 5    | 0.49        | 332.9      |
| C          |             | 0.21     | 5    | 0.31        | 0.9        |
| Ruby2      | GraalVM_JVM | 0.24     | 5    | 1.82        | 784.6      |
| Lua        | JIT         | 0.27     | 5    | 0.2         | 2.7        |
| Ruby2      | GraalVM     | 0.27     | 5    | 0.21        | 330.3      |
| Python3    | GraalVM_JVM | 0.36     | 5    | 2.84        | 1366.3     |
| Ruby2      | Topaz       | 0.43     | 5    | 0.22        | 29.9       |
| Python3    | GraalVM     | 0.61     | 5    | 0.31        | 601.5      |
| Python2    | PYPY        | 0.71     | 5    | 0.2         | 60.5       |
| Python3    | PYPY        | 0.71     | 1    | 0.26        | 57.6       |
| PHP        | JIT         | 0.77     | 5    | 0.13        | 16.3       |
| Ruby2      | JRuby_InDy  | 1.19     | 5    | 1.61        | 374.1      |
| Lua        |             | 1.62     | 5    | 0.19        | 2.1        |
| Ruby2      | JRuby       | 2.0      | 5    | 1.59        | 362.1      |
| PHP        |             | 2.54     | 5    | 0.19        | 12.0       |
| Python3    | MYPYC       | 2.74     | 5    | 2.49        | 7.6        |
| Python3    | Nuitka      | 3.52     | 5    | 3.79        | 10.6       |
| Python2    |             | 3.83     | 5    | 0.21        | 6.4        |
| Python3    |             | 4.04     | 5    | 0.2         | 8.1        |
| Ruby3      | JIT         | 4.27     | 5    | 0.47        | 23.7       |
| Ruby3      |             | 4.3      | 5    | 0.24        | 23.0       |
| Ruby2      |             | 4.34     | 5    | 0.25        | 20.9       |
| Ruby2      | JIT         | 4.37     | 5    | 0.24        | 20.8       |
| Python2    | Jython      | 4.96     | 5    | 1.26        | 388.4      |
| Ruby2      | Rbx         | > 60     | 0    | 0.34        | 512.9      |


## fasta
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 0.57     | 5    | 0.32        | 0.9        |
| Crystal    |             | 1.1      | 5    | 10.92       | 3.4        |
| Lua        | JIT         | 1.71     | 5    | 0.16        | 2.9        |
| PHP        | JIT         | 2.46     | 5    | 0.18        | 15.8       |
| Python2    | PYPY        | 2.89     | 5    | 0.21        | 63.9       |
| Python3    | PYPY        | 3.19     | 5    | 0.2         | 62.4       |
| Ruby2      | GraalVM_JVM | 3.28     | 5    | 1.92        | 1289.1     |
| Python3    | GraalVM_JVM | 3.53     | 5    | 2.98        | 1139.4     |
| Javascript | Node        | 3.66     | 5    | 0.29        | 49.4       |
| Lua        |             | 3.69     | 5    | 0.2         | 2.4        |
| Ruby2      | GraalVM     | 3.78     | 5    | 0.21        | 617.1      |
| PHP        |             | 4.64     | 5    | 0.19        | 11.8       |
| Ruby2      | Topaz       | 5.29     | 5    | 0.23        | 41.1       |
| Python3    | GraalVM     | 5.36     | 5    | 0.34        | 781.2      |
| Python3    | MYPYC       | 6.44     | 5    | 2.89        | 7.5        |
| Python3    | Cython      | 6.81     | 5    | 2.54        | 8.4        |
| Javascript | GraalVM_JVM | 8.13     | 5    | 2.14        | 1327.8     |
| Python3    |             | 8.65     | 5    | 0.21        | 8.0        |
| Javascript | GraalVM     | 10.43    | 5    | 0.51        | 792.0      |
| Python3    | Nuitka      | 10.97    | 5    | 3.87        | 10.5       |
| Python2    |             | 11.52    | 5    | 0.26        | 19.4       |
| Ruby3      | JIT         | 14.59    | 5    | 0.98        | 55.4       |
| Ruby3      |             | 16.21    | 4    | 0.28        | 53.1       |
| Ruby2      | JIT         | 17.74    | 4    | 0.77        | 59.7       |
| Ruby2      |             | 18.19    | 4    | 0.22        | 59.3       |
| Ruby2      | JRuby       | 25.15    | 3    | 1.68        | 777.2      |
| Ruby2      | JRuby_InDy  | 26.86    | 2    | 2.23        | 783.0      |
| Python2    | Jython      | 30.6     | 2    | 1.41        | 420.3      |
| Ruby2      | Rbx         | > 80     | 0    | 0.34        | 540.1      |


## knucleotide
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Lua        | JIT         | 0.77     | 1    | 0.29        | 27.1       |
| PHP        | JIT         | 1.96     | 1    | 0.2         | 40.7       |
| Python2    | PYPY        | 2.08     | 1    | 0.25        | 132.0      |
| C++        |             | 2.09     | 1    | 1.05        | 30.9       |
| Crystal    |             | 2.35     | 1    | 11.87       | 45.8       |
| PHP        |             | 2.87     | 1    | 0.2         | 37.2       |
| Python3    | PYPY        | 3.7      | 1    | 0.27        | 142.1      |
| Lua        |             | 4.01     | 1    | 0.27        | 51.4       |
| Python3    | GraalVM_JVM | 5.04     | 1    | 4.39        | 1555.3     |
| Javascript | Node        | 5.21     | 1    | 0.32        | 140.9      |
| Ruby2      | Topaz       | 5.25     | 1    | 0.42        | 116.0      |
| Ruby2      | GraalVM_JVM | 5.3      | 1    | 2.54        | 1590.7     |
| Python3    | GraalVM     | 5.79     | 1    | 0.79        | 927.6      |
| Python2    |             | 6.58     | 1    | 0.3         | 262.9      |
| Ruby2      | GraalVM     | 8.11     | 1    | 0.81        | 469.2      |
| Python3    | Cython      | 8.33     | 1    | 2.6         | 49.7       |
| Python3    |             | 8.41     | 1    | 0.29        | 48.9       |
| Ruby2      | JRuby_InDy  | 8.58     | 1    | 1.81        | 1044.9     |
| Python3    | Nuitka      | 8.83     | 1    | 3.97        | 51.5       |
| Ruby2      | JRuby       | 9.51     | 1    | 1.79        | 859.8      |
| Ruby2      | JIT         | 9.66     | 1    | 0.33        | 56.3       |
| Javascript | GraalVM_JVM | 9.7      | 1    | 3.65        | 1584.4     |
| Python2    | Jython      | 9.75     | 1    | 1.47        | 797.9      |
| Ruby3      | JIT         | 9.98     | 1    | 0.6         | 82.2       |
| Ruby2      |             | 11.02    | 1    | 0.34        | 54.3       |
| Ruby3      |             | 11.6     | 1    | 0.36        | 82.8       |
| Javascript | GraalVM     | 13.67    | 1    | 1.65        | 608.5      |
| Python3    | MYPYC       | -        | 0    | 1.13        | -          |
| Ruby2      | Rbx         | > 60     | 0    | 0.0         | -          |


## mandelbrot
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | Cython      | 0.43     | 5    | 1.17        | 8.2        |
| C          |             | 0.45     | 5    | 0.29        | 1.0        |
| Crystal    |             | 0.45     | 5    | 9.59        | 2.9        |
| Javascript | Node        | 0.46     | 5    | 0.21        | 115.1      |
| Javascript | GraalVM_JVM | 0.48     | 5    | 2.15        | 1347.3     |
| Lua        | JIT         | 0.5      | 5    | 0.24        | 2.4        |
| Javascript | GraalVM     | 0.51     | 5    | 0.55        | 686.2      |
| Python3    | PYPY        | 0.54     | 5    | 0.22        | 75.6       |
| Python2    | PYPY        | 0.56     | 5    | 0.22        | 73.7       |
| PHP        | JIT         | 0.58     | 5    | 0.22        | 16.2       |
| Python3    | GraalVM_JVM | 0.84     | 5    | 3.45        | 1099.8     |
| Python3    | GraalVM     | 1.19     | 4    | 0.31        | 687.9      |
| Ruby2      | GraalVM_JVM | 1.34     | 5    | 1.85        | 1137.6     |
| Ruby2      | GraalVM     | 1.36     | 5    | 0.23        | 385.7      |
| Ruby2      | Topaz       | 1.47     | 5    | 0.26        | 26.7       |
| Lua        |             | 5.39     | 5    | 0.14        | 2.4        |
| PHP        |             | 5.51     | 5    | 0.19        | 12.4       |
| Ruby2      | JRuby_InDy  | 7.12     | 5    | 1.81        | 939.9      |
| Python2    | Jython      | 12.79    | 4    | 1.38        | 588.9      |
| Ruby2      | JRuby       | 14.94    | 5    | 1.61        | 1653.1     |
| Ruby2      | JIT         | 16.72    | 5    | 0.23        | 21.0       |
| Ruby2      |             | 16.74    | 5    | 0.24        | 21.1       |
| Ruby3      |             | 20.86    | 5    | 0.24        | 23.0       |
| Ruby3      | JIT         | 21.56    | 5    | 0.49        | 24.0       |
| Python3    | MYPYC       | 23.26    | 5    | 2.46        | 16.7       |
| Python3    | Nuitka      | 33.25    | 3    | 3.87        | 19.3       |
| Python2    |             | 33.61    | 3    | 0.25        | 15.0       |
| Python3    |             | 37.52    | 3    | 0.23        | 16.8       |
| Ruby2      | Rbx         | > 120    | 0    | 0.38        | 797.9      |


## matmul
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 0.23     | 5    | 0.28        | 16.6       |
| Crystal    |             | 0.25     | 5    | 10.42       | 28.2       |
| Javascript | Node        | 0.26     | 5    | 0.2         | 98.4       |
| Lua        | JIT         | 0.27     | 5    | 0.18        | 56.9       |
| Javascript | GraalVM_JVM | 0.3      | 5    | 2.14        | 772.4      |
| Python2    | PYPY        | 0.35     | 5    | 0.26        | 79.9       |
| Python3    | PYPY        | 0.36     | 5    | 0.24        | 82.0       |
| Python3    | Cython      | 0.39     | 5    | 1.17        | 84.5       |
| Javascript | GraalVM     | 0.51     | 5    | 0.47        | 397.1      |
| Python3    | GraalVM_JVM | 1.4      | 5    | 3.43        | 1301.4     |
| Ruby2      | GraalVM_JVM | 1.47     | 5    | 1.84        | 3035.5     |
| Ruby2      | GraalVM     | 1.69     | 5    | 0.27        | 911.4      |
| Ruby2      | Topaz       | 1.83     | 5    | 0.21        | 89.2       |
| Python3    | GraalVM     | 2.26     | 5    | 0.4         | 1024.2     |
| Lua        |             | 6.18     | 5    | 0.16        | 86.7       |
| Ruby3      | JIT         | 11.84    | 5    | 1.0         | 70.7       |
| Ruby2      |             | 18.39    | 4    | 0.25        | 66.2       |
| Ruby2      | JRuby_InDy  | 18.9     | 3    | 2.1         | 1042.3     |
| Ruby2      | JIT         | 20.86    | 3    | 0.67        | 66.5       |
| Ruby3      |             | 20.88    | 3    | 0.28        | 68.2       |
| Python2    |             | 22.47    | 3    | 0.17        | 21.9       |
| Python3    |             | 22.73    | 3    | 0.28        | 25.1       |
| Python3    | Nuitka      | 23.8     | 3    | 3.81        | 26.8       |
| Python3    | MYPYC       | 24.95    | 3    | 2.55        | 25.3       |
| Ruby2      | JRuby       | 27.1     | 2    | 1.63        | 868.3      |
| Python2    | Jython      | 28.09    | 2    | 1.34        | 572.3      |
| Ruby2      | Rbx         | > 80     | 0    | 0.34        | 719.9      |


## nbody
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | MYPYC       | 0.0      | 1    | 3.15        | -          |
| Python3    | Cython      | 0.56     | 5    | 0.83        | 8.1        |
| C          |             | 0.56     | 5    | 0.25        | 1.2        |
| Crystal    |             | 0.77     | 5    | 10.56       | 2.7        |
| Javascript | Node        | 0.82     | 5    | 0.28        | 47.3       |
| Ruby2      | GraalVM_JVM | 0.85     | 5    | 1.79        | 886.7      |
| Ruby2      | GraalVM     | 0.87     | 5    | 0.18        | 425.0      |
| Lua        | JIT         | 1.44     | 5    | 0.23        | 2.4        |
| Python3    | GraalVM_JVM | 3.19     | 5    | 3.05        | 1112.5     |
| Python3    | GraalVM     | 3.85     | 5    | 0.32        | 594.2      |
| Python2    | PYPY        | 4.39     | 5    | 0.25        | 62.4       |
| Python3    | PYPY        | 4.44     | 1    | 0.26        | 59.4       |
| Javascript | GraalVM     | 4.82     | 5    | 0.53        | 464.4      |
| Ruby2      | Topaz       | 5.42     | 5    | 0.21        | 33.8       |
| Javascript | GraalVM_JVM | 5.59     | 5    | 2.18        | 1163.0     |
| PHP        | JIT         | 7.0      | 5    | 0.7         | 15.8       |
| Ruby2      | JRuby_InDy  | 14.85    | 5    | 2.21        | 783.7      |
| Lua        |             | 19.69    | 4    | 0.23        | 2.4        |
| PHP        |             | 21.77    | 3    | 0.2         | 11.9       |
| Ruby3      | JIT         | 33.29    | 2    | 0.96        | 26.4       |
| Ruby2      | JIT         | 36.77    | 2    | 0.76        | 21.1       |
| Ruby2      |             | 43.56    | 1    | 0.27        | 21.0       |
| Ruby3      |             | 49.92    | 1    | 0.26        | 22.8       |
| Ruby2      | JRuby       | 51.32    | 1    | 1.78        | 939.8      |
| Python3    |             | 53.72    | 1    | 0.2         | 8.6        |
| Python2    |             | 55.87    | 1    | 0.19        | 286.5      |
| Python2    | Jython      | 64.24    | 1    | 1.34        | 801.3      |
| Python3    | Nuitka      | 66.26    | 1    | 3.94        | 10.9       |
| Ruby2      | Rbx         | > 80     | 0    | 0.36        | 615.0      |


## pidigits
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| PHP        | JIT         | 1.57     | 5    | 0.2         | 17.7       |
| C          |             | 1.61     | 5    | 0.32        | 5.6        |
| PHP        |             | 1.71     | 5    | 0.22        | 13.7       |
| Python3    | Cython      | 1.73     | 5    | 0.96        | 11.7       |
| Javascript | Node        | 2.07     | 5    | 0.22        | 52.0       |
| Javascript | GraalVM     | 3.07     | 5    | 0.55        | 336.5      |
| Javascript | GraalVM_JVM | 3.74     | 5    | 2.21        | 806.7      |
| Crystal    |             | 5.22     | 5    | 10.59       | 7.3        |
| Python3    |             | 6.17     | 5    | 0.21        | 9.8        |
| Python3    | MYPYC       | 6.2      | 5    | 2.36        | 9.4        |
| Python2    |             | 6.51     | 5    | 0.21        | 7.6        |
| Python3    | Nuitka      | 6.77     | 5    | 3.78        | 12.2       |
| Ruby2      | GraalVM_JVM | 7.77     | 5    | 1.97        | 1647.3     |
| Ruby2      | Topaz       | 7.78     | 5    | 0.21        | 35.0       |
| Ruby2      | JRuby       | 7.94     | 5    | 1.56        | 1845.2     |
| Ruby2      | JRuby_InDy  | 7.95     | 5    | 1.65        | 1285.1     |
| Python2    | PYPY        | 8.11     | 5    | 0.26        | 65.8       |
| Python3    | PYPY        | 8.22     | 5    | 0.23        | 63.2       |
| Python2    | Jython      | 8.93     | 5    | 1.29        | 638.3      |
| Python3    | GraalVM_JVM | 9.78     | 5    | 3.37        | 1628.6     |
| Ruby3      | JIT         | 10.53    | 5    | 0.45        | 124.7      |
| Ruby3      |             | 10.64    | 5    | 0.23        | 119.6      |
| Ruby2      | GraalVM     | 10.76    | 5    | 0.21        | 445.2      |
| Ruby2      | JIT         | 11.3     | 5    | 0.22        | 171.6      |
| Ruby2      |             | 11.42    | 5    | 0.29        | 168.6      |
| Python3    | GraalVM     | 15.05    | 4    | 0.32        | 694.0      |
| Ruby2      | Rbx         | 22.81    | 3    | 0.34        | 88.8       |


## regexdna
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Crystal    |             | 0.34     | 1    | 10.42       | 142.6      |
| Javascript | Node        | 1.06     | 1    | 0.64        | 622.4      |
| PHP        | JIT         | 1.39     | 1    | 0.19        | 84.0       |
| PHP        |             | 1.4      | 1    | 0.19        | 78.8       |
| Python2    | PYPY        | 2.31     | 1    | 0.33        | 324.2      |
| Python3    | PYPY        | 2.38     | 1    | 0.4         | 267.4      |
| Ruby2      | Topaz       | 3.1      | 1    | 0.68        | 298.9      |
| Python3    |             | 5.2      | 1    | 1.07        | 160.9      |
| Python3    | MYPYC       | 5.2      | 1    | 3.23        | 151.5      |
| Ruby2      | GraalVM_JVM | 5.31     | 1    | 2.82        | 2513.4     |
| Python2    |             | 5.44     | 1    | 1.05        | 135.3      |
| C          |             | 5.6      | 1    | 0.4         | 86.7       |
| Python3    | Cython      | 6.1      | 1    | 1.73        | 168.2      |
| Python3    | Nuitka      | 6.2      | 1    | 4.66        | 150.6      |
| Ruby2      |             | 6.25     | 1    | 0.37        | 112.5      |
| Ruby2      | JIT         | 6.26     | 1    | 0.39        | 113.8      |
| Javascript | GraalVM_JVM | 6.68     | 1    | 4.8         | 2159.6     |
| Ruby3      |             | 7.46     | 1    | 0.45        | 113.8      |
| Ruby3      | JIT         | 7.5      | 1    | 0.62        | 115.2      |
| Python2    | Jython      | 8.48     | 1    | 2.35        | 772.2      |
| Lua        |             | 8.94     | 1    | 0.71        | 247.3      |
| Python3    | GraalVM_JVM | 9.04     | 1    | 6.55        | 2456.8     |
| Ruby2      | JRuby_InDy  | 9.49     | 1    | 1.85        | 488.3      |
| Ruby2      | JRuby       | 9.6      | 1    | 1.75        | 459.6      |
| Ruby2      | GraalVM     | 9.99     | 1    | 1.48        | 2641.9     |
| Lua        | JIT         | 9.99     | 1    | 0.87        | 192.6      |
| Javascript | GraalVM     | 10.0     | 1    | 3.27        | 711.6      |
| Ruby2      | Rbx         | 11.69    | 1    | 1.87        | 396.0      |
| Python3    | GraalVM     | 12.84    | 1    | 4.27        | 988.1      |


## revcomp
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| C          |             | 0.54     | 1    | 0.28        | 123.2      |
| PHP        | JIT         | 2.06     | 1    | 0.21        | 444.2      |
| PHP        |             | 2.27     | 1    | 0.2         | 317.0      |
| Python3    |             | 2.45     | 1    | 0.23        | 951.5      |
| Python2    |             | 2.47     | 1    | 0.22        | 797.9      |
| Python3    | Nuitka      | 2.6      | 1    | 3.73        | 794.3      |
| Python2    | PYPY        | 2.89     | 1    | 0.28        | 1298.3     |
| Javascript | Node        | 3.15     | 1    | 0.26        | 625.1      |
| Lua        | JIT         | 3.33     | 1    | 0.22        | 309.6      |
| Ruby3      | JIT         | 3.64     | 1    | 0.5         | 168.9      |
| Ruby3      |             | 3.67     | 1    | 0.22        | 167.6      |
| Ruby2      | JIT         | 4.09     | 1    | 0.24        | 164.7      |
| Python3    | PYPY        | 4.14     | 1    | 0.19        | 1424.9     |
| Ruby2      |             | 4.2      | 1    | 0.19        | 164.4      |
| Python3    | GraalVM_JVM | 4.36     | 1    | 2.85        | 3180.4     |
| Crystal    |             | 5.49     | 1    | 10.43       | 916.4      |
| Javascript | GraalVM     | 7.28     | 1    | 0.56        | 1222.1     |
| Ruby2      | Topaz       | 7.3      | 1    | 0.22        | 787.5      |
| Javascript | GraalVM_JVM | 8.31     | 1    | 2.06        | 1984.3     |
| Lua        |             | 8.52     | 1    | 0.22        | 747.3      |
| Ruby2      | JRuby_InDy  | 8.78     | 1    | 1.52        | 842.1      |
| Ruby2      | JRuby       | 9.36     | 1    | 1.61        | 1008.8     |
| Python3    | GraalVM     | 10.98    | 1    | 0.32        | 3192.0     |
| Ruby2      | GraalVM_JVM | 14.15    | 1    | 1.77        | 2836.8     |
| Ruby2      | GraalVM     | 17.49    | 1    | 0.21        | 1431.4     |
| Python3    | MYPYC       | -        | 0    | 2.39        | -          |
| Python2    | Jython      | > 60     | 0    | 1.27        | 818.0      |
| Ruby2      | Rbx         | > 60     | 0    | 0.32        | 504.7      |


## spectralnorm
| Language   | Interpreter | Best T,s | Runs | Compile T,s | MaxMem, Mb |
|------------|-------------|----------|------|-------------|------------|
| Python3    | Cython      | 0.11     | 5    | 1.02        | 10.3       |
| Javascript | Node        | 0.11     | 5    | 0.22        | 47.0       |
| C          |             | 0.11     | 5    | 0.34        | 1.1        |
| Crystal    |             | 0.12     | 5    | 10.3        | 3.4        |
| Lua        | JIT         | 0.12     | 5    | 0.2         | 2.8        |
| Javascript | GraalVM_JVM | 0.13     | 5    | 2.13        | 1268.2     |
| Javascript | GraalVM     | 0.13     | 5    | 0.48        | 338.9      |
| Ruby2      | GraalVM_JVM | 0.21     | 5    | 1.75        | 704.6      |
| Ruby2      | GraalVM     | 0.23     | 5    | 0.22        | 362.2      |
| Python2    | PYPY        | 0.61     | 5    | 0.17        | 62.9       |
| Python3    | GraalVM_JVM | 0.62     | 5    | 2.89        | 1475.4     |
| Python3    | PYPY        | 0.71     | 5    | 0.21        | 60.8       |
| Python3    | GraalVM     | 0.73     | 5    | 0.27        | 842.6      |
| Ruby2      | Topaz       | 1.44     | 5    | 0.22        | 31.9       |
| PHP        | JIT         | 2.51     | 5    | 0.2         | 16.0       |
| Lua        |             | 3.86     | 5    | 0.23        | 2.6        |
| Ruby2      | JRuby_InDy  | 4.09     | 5    | 1.6         | 1429.3     |
| PHP        |             | 6.48     | 5    | 0.18        | 12.5       |
| Ruby3      | JIT         | 10.13    | 5    | 0.45        | 25.1       |
| Ruby2      | JRuby       | 10.56    | 5    | 1.56        | 1741.4     |
| Ruby2      | JIT         | 12.95    | 5    | 0.75        | 21.3       |
| Python3    | MYPYC       | 13.1     | 5    | 2.49        | 8.4        |
| Python2    |             | 14.28    | 5    | 0.15        | 6.9        |
| Ruby3      |             | 15.25    | 5    | 0.2         | 23.1       |
| Ruby2      |             | 17.18    | 4    | 0.25        | 21.2       |
| Python3    | Nuitka      | 19.39    | 4    | 3.73        | 11.1       |
| Python3    |             | 20.69    | 3    | 0.27        | 8.8        |
| Python2    | Jython      | 40.98    | 1    | 1.26        | 372.8      |
| Ruby2      | Rbx         | > 80     | 0    | 0.36        | 624.6      |


## Versions
| Language    | Version                              |
|-------------|--------------------------------------|
| c           | 12.2.0                               |
| crystal     | 1.7.2                                |
| cython      | 0.29.30                              |
| graalnode   | 22.3.1 (node: 16.18.1)               |
| graalpython | 22.3.1 (python: 3.8.5)               |
| java        | openjdk 19.0.1                       |
| jruby       | 9.4.1.0                              |
| jython      | 2.7.3                                |
| lua         | 5.4.4                                |
| luajit      | 2.1.0-beta3                          |
| mypyc       | 1.0.1                                |
| nodejs      | 19.7.0                               |
| nuitka      | 1.4.8 (python: 3.10.7, gcc: 12.2.0)  |
| php         | 8.2.3                                |
| pypy2       | 7.3.11 (python: 2.7.18, gcc: 10.2.1) |
| pypy3       | 7.3.11 (python: 3.9.16, gcc: 10.2.1) |
| python2     | 2.7.18                               |
| python3     | 3.10.7                               |
| rbx         | 5.0                                  |
| ruby2       | 2.7.7p221                            |
| ruby3       | 3.2.1p31                             |
| topaz       | https://github.com/kostya/topaz      |
| truffleruby | 22.3.1 (ruby: 3.0.3)                 |

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

## Add new language XXX
Create file `docker/XXX` and add it to docker-compose.yml. Check that its intalled ok `./dc init XXX`.
Add language XXX into `tools/languages.rb`.

Create benchmark file: `BENCH/test.EXT` (BENCH is specific benchmark name, EXT language extension)

To work in benchmark suite, required some special marks in the benchmark file:
* at the start of benchmark write to stderr: "started\t#{PID}\n" (PID current process pid)
* at the end of benchmark write to stderr: "time(#{TIME})\n" (TIME time spended by benchmark in seconds, measure in language itself).

Check that it worked.
```
./dc up XXX
./dc versions XXX
./dc build BENCH XXX
./dc check BENCH XXX
./dc run BENCH XXX
```
