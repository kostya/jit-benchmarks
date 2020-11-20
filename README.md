# Benchmark for interpreted languages implementations.

Most programs from [benchmarks game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/index.html). All programs are chosen to be simplest, single-thread and without any low-level hacks. Also, the code for all languages trying to be implemented with one algorithm, use the same language constructs and containers, and be semantically similar to each other. The goal of the benchmark is to find the most successful JIT solutions. My other benchmarks: [Benchmarks](https://github.com/kostya/benchmarks), [Crystal Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game).

Compare:
		
		* Ruby (MRI, MRI --jit, Graal, [Topaz](https://github.com/kostya/topaz), JRuby, Rbx, Ruby3, Ruby3 --jit)
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

## Binarytrees
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C++        | g++         | 1.09    | 1.10           | 34.9       |
| Crystal    |             | 1.36    | 1.37           | 64.6       |
| Python3    | Cython      | 2.19    | 2.21           | 40.2       |
| C          | gcc         | 2.37    | 2.38           | 33.4       |
| Javascript | Node        | 3.38    | 3.44           | 279.4      |
| Ruby       | Topaz       | 4.13    | 4.15           | 112.1      |
| Ruby       | GraalVM     | 4.20    | 4.23           | 822.9      |
| Ruby       | GraalVM_JVM | 5.78    | 7.55           | 980.6      |
| Javascript | GraalVM_JVM | 5.96    | 7.85           | 1031.1     |
| Javascript | GraalVM     | 6.83    | 6.97           | 903.7      |
| Ruby       | JRuby       | 7.62    | 8.86           | 697.6      |
| Ruby3      | JIT         | 10.08   | 10.14          | 80.9       |
| Python3    | Pypy        | 11.31   | 11.34          | 196.1      |
| Python2    | Pypy        | 11.78   | 11.80          | 219.3      |
| Ruby       | JIT         | 14.04   | 14.08          | 54.9       |
| Ruby3      |             | 14.15   | 14.20          | 80.3       |
| Ruby       |             | 15.09   | 15.13          | 54.5       |
| Python3    | GraalVM     | 17.97   | 18.06          | 1228.5     |
| Lua        | JIT         | 19.10   | 19.17          | 500.8      |
| Python3    | GraalVM_JVM | 28.71   | 33.35          | 1527.0     |
| Ruby       | rbx         | 37.05   | 37.21          | 299.1      |
| Lua        |             | 52.55   | 52.71          | 344.7      |
| Python2    | Jython      | 57.34   | 59.10          | 1488.4     |
| Python3    | Nuitka      | > 60    | > 60           | 205.3      |
| Python2    |             | > 60    | > 60           | 405.1      |
| Python3    |             | > 60    | > 60           | 202.6      |


## Fannkuchredux
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 2.42    | 2.48           | 36.3       |
| Python3    | Cython      | 2.60    | 2.60           | 7.9        |
| Crystal    |             | 2.72    | 2.73           | 3.1        |
| C          | gcc         | 2.77    | 2.77           | 0.6        |
| Lua        | JIT         | 3.50    | 3.50           | 2.2        |
| Javascript | GraalVM_JVM | 4.03    | 5.88           | 488.0      |
| Javascript | GraalVM     | 4.16    | 4.31           | 283.3      |
| Ruby       | GraalVM_JVM | 5.30    | 7.14           | 494.6      |
| Ruby       | GraalVM     | 5.45    | 5.47           | 497.6      |
| Ruby       | Topaz       | 5.65    | 5.66           | 30.1       |
| Python3    | GraalVM_JVM | 7.87    | 12.62          | 802.3      |
| Python2    | Pypy        | 9.12    | 9.14           | 65.2       |
| Python3    | Pypy        | 9.36    | 9.38           | 60.9       |
| Python3    | GraalVM     | 10.81   | 10.91          | 721.6      |
| Lua        |             | 23.27   | 23.27          | 0.8        |
| Ruby       | JRuby       | 32.29   | 33.46          | 171.5      |
| Python3    |             | 52.33   | 52.34          | 7.0        |
| Python2    |             | 52.35   | 52.36          | 6.1        |
| Python3    | Nuitka      | 53.90   | 53.93          | 10.2       |
| Ruby3      |             | 54.66   | 54.70          | 13.3       |
| Ruby3      | JIT         | 55.64   | 55.68          | 13.5       |
| Python2    | Jython      | 57.68   | 59.45          | 411.2      |
| Ruby       |             | 63.82   | 63.85          | 13.4       |
| Ruby       | JIT         | 64.43   | 64.46          | 13.5       |
| Ruby       | rbx         | > 70    | > 70           | 533.6      |


## Fasta
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.88    | 1.88           | 0.5        |
| Crystal    |             | 2.84    | 2.85           | 4.3        |
| Lua        | JIT         | 4.92    | 4.93           | 2.3        |
| Python2    | Pypy        | 10.23   | 10.27          | 66.8       |
| Ruby       | GraalVM     | 10.58   | 10.62          | 727.2      |
| Python3    | Pypy        | 10.94   | 10.97          | 63.7       |
| Ruby       | GraalVM_JVM | 11.64   | 13.97          | 790.8      |
| Lua        |             | 12.49   | 12.50          | 0.9        |
| Javascript | Node        | 12.57   | 12.73          | 41.5       |
| Ruby       | Topaz       | 13.16   | 13.19          | 50.8       |
| Python3    | Cython      | 17.19   | 17.20          | 8.5        |
| Python3    |             | 27.55   | 27.56          | 7.4        |
| Python3    | GraalVM_JVM | 28.17   | 34.40          | 1050.5     |
| Python3    | GraalVM     | 34.53   | 34.64          | 1034.2     |
| Python2    |             | 35.38   | 35.40          | 45.6       |
| Python3    | Nuitka      | 37.86   | 37.89          | 10.2       |
| Ruby3      | JIT         | 49.17   | 49.22          | 42.8       |
| Ruby       | JIT         | 49.92   | 49.96          | 42.7       |
| Ruby       |             | 52.38   | 52.42          | 57.2       |
| Ruby3      |             | 55.23   | 55.28          | 42.5       |
| Javascript | GraalVM_JVM | 56.86   | 61.41          | 686.3      |
| Ruby       | JRuby       | 65.92   | 67.58          | 538.7      |
| Javascript | GraalVM     | 73.57   | 75.92          | 820.9      |
| Ruby       | rbx         | > 100   | > 100          | 586.7      |
| Python2    | Jython      | > 100   | > 100          | 555.1      |


## Knucleotide
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Lua        | JIT         | 1.99    | 2.01           | 52.9       |
| Python2    | Pypy        | 5.46    | 5.49           | 190.3      |
| C++        | g++         | 5.77    | 5.78           | 31.5       |
| Crystal    |             | 6.05    | 6.06           | 58.7       |
| Python3    | Pypy        | 8.78    | 8.81           | 192.2      |
| Lua        |             | 9.24    | 9.27           | 92.5       |
| Ruby       | Topaz       | 13.32   | 13.34          | 133.3      |
| Javascript | Node        | 13.77   | 13.83          | 164.8      |
| Python2    |             | 16.78   | 16.90          | 534.7      |
| Python3    |             | 20.44   | 20.46          | 71.8       |
| Ruby       | JRuby       | 20.54   | 21.83          | 340.8      |
| Python3    | Cython      | 20.64   | 20.66          | 72.5       |
| Ruby       | JIT         | 21.02   | 21.06          | 66.7       |
| Ruby3      | JIT         | 22.26   | 22.31          | 76.2       |
| Python2    | Jython      | 23.32   | 25.14          | 1765.1     |
| Python3    | Nuitka      | 24.77   | 24.80          | 74.3       |
| Ruby       |             | 25.14   | 25.18          | 66.6       |
| Javascript | GraalVM_JVM | 25.98   | 27.83          | 805.0      |
| Ruby3      |             | 26.25   | 26.29          | 78.4       |
| Python3    | GraalVM_JVM | 29.05   | 33.70          | 1398.8     |
| Javascript | GraalVM     | 32.03   | 32.18          | 885.2      |
| Python3    | GraalVM     | 54.12   | 54.22          | 2047.5     |
| Ruby       | GraalVM     | > 70    | > 70           | 766.6      |
| Ruby       | GraalVM_JVM | > 70    | > 70           | 675.4      |
| Ruby       | rbx         | > 70    | > 70           | 523.6      |


## Mandelbrot
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 0.96    | 1.02           | 72.0       |
| C          | gcc         | 0.97    | 0.97           | 0.5        |
| Crystal    |             | 0.99    | 1.00           | 3.1        |
| Python3    | Cython      | 0.99    | 1.00           | 8.1        |
| Lua        | JIT         | 1.06    | 1.06           | 1.0        |
| Ruby       | Topaz       | 2.02    | 2.03           | 26.8       |
| Javascript | GraalVM     | 2.71    | 2.86           | 518.7      |
| Python3    | GraalVM     | 2.77    | 2.83           | 445.7      |
| Javascript | GraalVM_JVM | 2.89    | 4.55           | 563.2      |
| Python3    | GraalVM_JVM | 3.34    | 7.60           | 699.9      |
| Python3    | Pypy        | 3.54    | 3.56           | 87.2       |
| Python2    | Pypy        | 3.60    | 3.62           | 91.8       |
| Ruby       | GraalVM     | 3.86    | 3.89           | 636.5      |
| Ruby       | GraalVM_JVM | 5.24    | 6.87           | 587.7      |
| Lua        |             | 11.12   | 11.12          | 0.8        |
| Ruby3      |             | 40.14   | 40.18          | 13.6       |
| Ruby       | JRuby       | 40.20   | 41.26          | 354.3      |
| Ruby3      | JIT         | 40.22   | 40.26          | 13.8       |
| Ruby       |             | 41.14   | 41.18          | 13.7       |
| Ruby       | JIT         | 41.24   | 41.27          | 13.6       |
| Python2    | Jython      | 60.35   | 61.94          | 418.1      |
| Python2    |             | 63.06   | 63.07          | 23.0       |
| Python3    | Nuitka      | 66.91   | 66.94          | 25.8       |
| Python3    |             | 67.52   | 67.53          | 24.5       |
| Ruby       | rbx         | > 70    | > 70           | 612.6      |


## Nbody
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Python3    | Cython      | 0.83    | 0.86           | 8.0        |
| C          | gcc         | 0.85    | 0.85           | 0.7        |
| Javascript | Node        | 0.91    | 0.97           | 38.7       |
| Crystal    |             | 1.09    | 1.10           | 3.1        |
| Lua        | JIT         | 1.36    | 1.36           | 0.9        |
| Ruby       | GraalVM     | 1.74    | 2.02           | 598.5      |
| Ruby       | GraalVM_JVM | 2.42    | 5.23           | 515.1      |
| Ruby       | Topaz       | 4.58    | 4.65           | 31.8       |
| Javascript | GraalVM     | 4.69    | 4.86           | 644.1      |
| Python3    | GraalVM_JVM | 5.32    | 11.51          | 688.3      |
| Python3    | GraalVM     | 5.50    | 5.71           | 353.8      |
| Python3    | Pypy        | 7.31    | 7.38           | 62.4       |
| Python2    | Pypy        | 7.35    | 7.37           | 65.4       |
| Javascript | GraalVM_JVM | 7.36    | 9.95           | 743.6      |
| Lua        |             | 19.77   | 19.78          | 0.8        |
| Ruby3      | JIT         | 39.62   | 39.67          | 13.6       |
| Ruby       | JIT         | 41.67   | 41.71          | 13.5       |
| Ruby       | JRuby       | 49.69   | 51.52          | 656.0      |
| Ruby       |             | 52.11   | 52.15          | 13.3       |
| Python3    |             | 57.66   | 57.69          | 7.6        |
| Ruby3      |             | 58.20   | 58.26          | 13.3       |
| Python2    | Jython      | 62.74   | 64.98          | 1132.1     |
| Python2    |             | 64.06   | 64.14          | 317.6      |
| Python3    | Nuitka      | > 80    | > 80           | 10.2       |
| Ruby       | rbx         | > 80    | > 80           | 594.8      |


## Regexdna
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 1.35    | 1.53           | 525.3      |
| Python2    | Pypy        | 2.14    | 2.16           | 214.2      |
| Python3    | Pypy        | 2.21    | 2.29           | 248.9      |
| Ruby       | Topaz       | 3.11    | 3.13           | 308.4      |
| Crystal    |             | 5.12    | 5.13           | 181.7      |
| Python3    |             | 5.16    | 5.17           | 121.8      |
| C          | gcc         | 5.18    | 5.19           | 74.3       |
| Ruby3      |             | 5.40    | 5.45           | 94.3       |
| Ruby       | JIT         | 5.44    | 5.48           | 119.2      |
| Ruby3      | JIT         | 5.49    | 5.54           | 107.2      |
| Ruby       |             | 5.51    | 5.55           | 94.5       |
| Python3    | Cython      | 5.61    | 5.63           | 151.9      |
| Python2    |             | 5.85    | 5.87           | 124.9      |
| Python3    | Nuitka      | 6.09    | 6.13           | 99.7       |
| Python2    | Jython      | 7.53    | 9.72           | 1162.0     |
| Ruby       | JRuby       | 7.71    | 8.87           | 287.1      |
| Lua        |             | 8.69    | 8.70           | 160.2      |
| Lua        | JIT         | 9.66    | 9.67           | 161.6      |
| Ruby       | rbx         | 11.46   | 11.62          | 387.2      |
| Javascript | GraalVM_JVM | 21.50   | 23.62          | 1204.1     |
| Javascript | GraalVM     | 30.70   | 31.10          | 1545.2     |
| Ruby       | GraalVM     | > 60    | > 60           | 810.0      |
| Ruby       | GraalVM_JVM | > 60    | > 60           | 820.5      |
| Python3    | GraalVM     | crashed | crashed        | 4694.7     |
| Python3    | GraalVM_JVM | crashed | crashed        | 1345.6     |


## Revcomp
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.43    | 0.44           | 147.4      |
| Python2    |             | 2.19    | 2.23           | 822.0      |
| Python3    |             | 2.26    | 2.27           | 1183.2     |
| Python3    | Cython      | 2.43    | 2.45           | 1183.6     |
| Python3    | Nuitka      | 2.46    | 2.49           | 1185.8     |
| Python2    | Pypy        | 2.67    | 2.80           | 1376.0     |
| Lua        | JIT         | 2.80    | 2.82           | 407.2      |
| Crystal    |             | 3.81    | 3.83           | 916.5      |
| Ruby       | JIT         | 3.83    | 3.88           | 157.4      |
| Javascript | Node        | 3.84    | 4.01           | 229.4      |
| Ruby       |             | 3.89    | 3.92           | 157.1      |
| Ruby3      | JIT         | 4.43    | 4.49           | 157.3      |
| Ruby3      |             | 4.47    | 4.52           | 157.1      |
| Ruby       | Topaz       | 4.56    | 4.60           | 798.1      |
| Python3    | Pypy        | 5.29    | 5.35           | 1424.2     |
| Ruby       | JRuby       | 5.98    | 7.18           | 875.6      |
| Lua        |             | 9.03    | 9.18           | 649.1      |
| Javascript | GraalVM     | 10.75   | 11.16          | 1362.8     |
| Ruby       | GraalVM_JVM | 11.35   | 13.20          | 1757.0     |
| Ruby       | GraalVM     | 12.23   | 12.26          | 1726.1     |
| Javascript | GraalVM_JVM | 16.56   | 19.62          | 1111.5     |
| Python3    | GraalVM_JVM | 19.06   | 27.00          | 2095.1     |
| Python3    | GraalVM     | 42.35   | 42.61          | 3454.1     |
| Ruby       | rbx         | > 60    | > 60           | 483.8      |
| Python2    | Jython      | crashed | crashed        | 1603.4     |


## Pidigits
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 2.39    | 2.39           | 3.2        |
| Python3    | Cython      | 2.53    | 2.54           | 9.8        |
| Javascript | Node        | 3.21    | 3.28           | 39.9       |
| Javascript | GraalVM     | 5.16    | 5.34           | 554.0      |
| Javascript | GraalVM_JVM | 7.11    | 9.25           | 583.0      |
| Python2    |             | 9.39    | 9.40           | 8.1        |
| Crystal    |             | 9.40    | 9.41           | 7.6        |
| Python3    |             | 9.59    | 9.60           | 9.2        |
| Python3    | Nuitka      | 9.89    | 9.91           | 11.9       |
| Ruby       | Topaz       | 12.70   | 12.72          | 35.3       |
| Python2    | Pypy        | 13.27   | 13.29          | 69.9       |
| Python3    | Pypy        | 13.29   | 13.31          | 66.5       |
| Ruby       | JRuby       | 13.53   | 14.73          | 459.9      |
| Ruby       | GraalVM_JVM | 14.69   | 16.65          | 779.1      |
| Python2    | Jython      | 15.03   | 16.75          | 516.5      |
| Ruby3      | JIT         | 16.98   | 17.03          | 164.2      |
| Ruby       | JIT         | 17.09   | 17.13          | 163.6      |
| Ruby       |             | 17.13   | 17.17          | 163.6      |
| Ruby       | GraalVM     | 17.31   | 17.34          | 634.7      |
| Ruby3      |             | 17.48   | 17.53          | 164.9      |
| Ruby       | rbx         | 35.99   | 36.15          | 89.4       |


## Spectralnorm
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.43    | 0.43           | 0.7        |
| Python3    | Cython      | 0.43    | 0.44           | 8.9        |
| Crystal    |             | 0.47    | 0.47           | 4.3        |
| Javascript | Node        | 0.53    | 0.58           | 36.6       |
| Lua        | JIT         | 0.54    | 0.55           | 2.3        |
| Ruby       | GraalVM     | 1.09    | 1.28           | 421.0      |
| Ruby       | GraalVM_JVM | 1.70    | 3.77           | 515.0      |
| Javascript | GraalVM     | 1.87    | 2.23           | 500.8      |
| Javascript | GraalVM_JVM | 2.04    | 4.21           | 807.7      |
| Python2    | Pypy        | 2.99    | 3.07           | 66.1       |
| Python3    | Pypy        | 3.44    | 3.47           | 61.9       |
| Ruby       | Topaz       | 6.26    | 6.28           | 32.0       |
| Lua        |             | 18.70   | 18.70          | 2.1        |
| Ruby3      | JIT         | 42.54   | 42.58          | 14.6       |
| Ruby       | JRuby       | 44.93   | 46.34          | 482.2      |
| Python3    | GraalVM_JVM | 48.99   | 54.70          | 764.6      |
| Ruby       | JIT         | 49.01   | 49.04          | 14.5       |
| Ruby       |             | 58.61   | 58.65          | 14.2       |
| Python2    |             | 61.77   | 61.77          | 7.3        |
| Ruby3      |             | 65.37   | 65.41          | 14.3       |
| Python3    |             | 75.54   | 75.55          | 8.5        |
| Python3    | GraalVM     | 79.96   | 80.08          | 974.0      |
| Python3    | Nuitka      | 95.24   | 95.26          | 11.3       |
| Ruby       | rbx         | > 120   | > 120          | 716.3      |
| Python2    | Jython      | > 120   | > 120          | 407.8      |


## Brainfuck
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C++        | g++         | 2.40    | 2.40           | 1.5        |
| Crystal    |             | 4.87    | 4.88           | 3.0        |
| Javascript | Node        | 5.37    | 5.42           | 36.7       |
| Python2    | Pypy        | 7.92    | 8.10           | 61.8       |
| Python3    | Pypy        | 10.44   | 10.67          | 64.5       |
| Ruby       | Topaz       | 18.40   | 18.46          | 28.8       |
| Ruby       | GraalVM_JVM | 20.68   | 22.73          | 518.5      |
| Ruby       | GraalVM     | 21.15   | 21.41          | 622.6      |
| Javascript | GraalVM_JVM | 41.43   | 43.16          | 629.6      |
| Python3    | GraalVM     | 51.23   | 52.06          | 985.8      |
| Javascript | GraalVM     | 52.71   | 52.84          | 668.6      |
| Python3    | GraalVM_JVM | 64.86   | 70.23          | 928.9      |
| Ruby       | JIT         | 105.76  | 105.81         | 13.5       |
| Ruby3      | JIT         | 108.66  | 108.72         | 13.5       |
| Ruby       |             | 118.61  | 118.65         | 13.5       |
| Ruby       | JRuby       | 120.52  | 121.87         | 270.6      |
| Ruby3      |             | 125.29  | 125.42         | 13.3       |
| Python3    | Nuitka      | 193.07  | 193.10         | 10.8       |
| Python3    | Cython      | > 200   | > 200          | 9.5        |
| Ruby       | rbx         | > 200   | > 200          | 991.0      |
| Python2    |             | > 200   | > 200          | 6.1        |
| Python3    |             | > 200   | > 200          | 8.9        |
| Python2    | Jython      | > 200   | > 200          | 588.0      |


## Brainfuck2
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.32    | 1.32           | 0.5        |
| Crystal    |             | 2.15    | 2.16           | 3.2        |
| Javascript | Node        | 3.85    | 3.90           | 36.7       |
| Lua        | JIT         | 6.55    | 6.55           | 2.2        |
| Python2    | Pypy        | 11.37   | 11.39          | 66.3       |
| Python3    | Pypy        | 11.56   | 11.61          | 63.5       |
| Ruby       | GraalVM     | 11.65   | 11.69          | 784.5      |
| Python3    | GraalVM     | 12.30   | 12.58          | 998.3      |
| Python3    | GraalVM_JVM | 12.42   | 17.72          | 795.6      |
| Javascript | GraalVM     | 14.18   | 14.31          | 690.1      |
| Ruby       | GraalVM_JVM | 14.84   | 17.29          | 806.4      |
| Javascript | GraalVM_JVM | 16.98   | 18.97          | 576.1      |
| Ruby       | Topaz       | 24.76   | 24.79          | 31.6       |
| Lua        |             | 55.07   | 55.08          | 0.9        |
| Ruby3      | JIT         | 58.72   | 58.76          | 13.6       |
| Ruby       | JIT         | 66.20   | 66.24          | 13.8       |
| Ruby       |             | 91.53   | 91.58          | 13.5       |
| Ruby       | JRuby       | 93.99   | 95.64          | 398.4      |
| Ruby3      |             | 116.15  | 116.20         | 13.3       |
| Python3    |             | 146.46  | 146.48         | 8.9        |
| Python2    |             | 159.11  | 159.12         | 6.2        |
| Python3    | Nuitka      | 166.40  | 166.43         | 10.8       |
| Python3    | Cython      | 197.92  | 197.95         | 9.5        |
| Ruby       | rbx         | > 200   | > 200          | 899.6      |
| Python2    | Jython      | > 200   | > 200          | 405.4      |


## Matmul
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.97    | 0.98           | 38.0       |
| Crystal    |             | 1.11    | 1.11           | 48.4       |
| Javascript | Node        | 1.34    | 1.42           | 75.4       |
| Python3    | Cython      | 1.40    | 1.43           | 46.5       |
| Lua        | JIT         | 1.51    | 1.52           | 73.4       |
| Python2    | Pypy        | 1.57    | 1.60           | 97.2       |
| Python3    | Pypy        | 1.59    | 1.65           | 96.4       |
| Ruby       | GraalVM     | 6.75    | 6.78           | 761.9      |
| Ruby       | Topaz       | 8.68    | 8.70           | 139.4      |
| Ruby       | GraalVM_JVM | 9.62    | 11.28          | 646.2      |
| Python3    | GraalVM     | 10.17   | 10.48          | 781.4      |
| Python3    | GraalVM_JVM | 11.49   | 17.53          | 787.8      |
| Javascript | GraalVM_JVM | 15.61   | 18.30          | 547.1      |
| Javascript | GraalVM     | 17.00   | 17.17          | 351.2      |
| Lua        |             | 25.20   | 25.21          | 139.8      |
| Ruby3      | JIT         | 61.74   | 61.79          | 51.6       |
| Ruby       |             | 71.22   | 71.26          | 50.8       |
| Ruby       | JIT         | 73.18   | 73.21          | 51.2       |
| Ruby3      |             | 75.98   | 76.02          | 51.0       |
| Python3    |             | 76.10   | 76.12          | 46.5       |
| Python2    |             | 80.50   | 80.52          | 44.0       |
| Python3    | Nuitka      | 127.48  | 127.51         | 48.3       |
| Ruby       | JRuby       | 155.08  | 156.18         | 689.8      |
| Ruby       | rbx         | > 200   | > 200          | 1210.1     |
| Python2    | Jython      | > 200   | > 200          | 524.1      |


## Versions:
* `Python 2.7.18`
* `Python 3.9.1`
* `Crystal 0.35.1 [5999ae29b] (2020-06-19)`
* `gcc (Debian 10.2.1-1) 10.2.1 20201207`
* `g++ (Debian 10.2.1-1) 10.2.1 20201207`
* `Lua 5.4.2  Copyright (C) 1994-2020 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/`
* `Nodejs v12.19.0`
* `ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev d9acd472) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.2.14.0 (2.5.7) 2020-12-08 ebe64bafb9 OpenJDK 64-Bit Server VM 14.0.2+12-Debian-1.1 on 14.0.2+12-Debian-1.1 +jit [linux-x86_64]`
* `Cython version 0.29.21`
* `truffleruby 20.3.0, like ruby 2.6.6, GraalVM CE Native [x86_64-linux]`
* `truffleruby 20.3.0, like ruby 2.6.6, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.18 (a29ef73f9b32, Nov 09 2020, 18:42:06) [PyPy 7.3.3 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.7.9 (7e6e2bb30ac5, Nov 18 2020, 10:55:52) [PyPy 7.3.3-beta0 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `openjdk version "14.0.2" 2020-07-14`
* `Python 3.8.5 (GraalVM CE Native 20.3.0)`
* `Python 3.8.5 (GraalVM CE JVM 20.3.0)`
* `GraalNode v12.18.4`
* `Jython 2.7.2`
* `Nuitka 0.6.10.1`
* `ruby 3.0.0preview2 (2020-12-08 master d7a16670c3) [x86_64-linux]`
* `rubinius 5.0 (10.0 a0a9ed90 2020-05-16 7.0.0) [x86_64-linux-gnu]`

