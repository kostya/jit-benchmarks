# Benchmark for interpreted languages implementations.

Most programs from [benchmarks game](https://benchmarksgame-team.pages.debian.net/benchmarksgame/index.html). All programs are chosen to be simplest, single-thread and without any low-level hacks. Also, the code for all languages trying to be implemented with one algorithm, use the same language constructs and containers, and be semantically similar to each other. The goal of the benchmark is to find the most successful JIT solutions. My other benchmarks: [Benchmarks](https://github.com/kostya/benchmarks), [Crystal Benchmarks Game](https://github.com/kostya/crystal-benchmarks-game).

Compare:
		
		* Ruby (MRI, MRI --jit, Graal, Topaz, JRuby, Rbx)
		* Python (Cpython, Graal, Pypy, Cython, Jython)
		* Lua (JIT)
		* Javascript (Node, Graal)
		* C, Crystal as a basis

I temporarily delete rbx from the benchmark, because it too slow.

Running on AMD Ryzen 7 3800X, 16Gb DDR-4 3200 Mghz, host os Gentoo Linux x86_64, docker os Debian Testing.

Build Docker image (20min, 4.7Gb):

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
| C++        | g++         | 1.26    | 1.27           | 34.9       |
| Crystal    |             | 1.29    | 1.29           | 64.6       |
| C          | gcc         | 2.62    | 2.65           | 33.5       |
| Javascript | Node        | 4.07    | 4.41           | 202.5      |
| Ruby       | Topaz       | 5.02    | 5.05           | 102.6      |
| Javascript | GraalVM_JVM | 5.64    | 6.92           | 1163.2     |
| Ruby       | GraalVM_JVM | 6.69    | 8.25           | 861.3      |
| Ruby       | JRuby       | 7.37    | 8.33           | 514.8      |
| Lua        | JIT         | 7.41    | 7.48           | 190.0      |
| Javascript | GraalVM     | 9.31    | 9.42           | 561.1      |
| Python3    | GraalVM_JVM | 9.93    | 12.62          | 1737.1     |
| Ruby       | GraalVM     | 10.54   | 10.57          | 512.4      |
| Python2    | Pypy        | 12.17   | 12.21          | 204.1      |
| Python3    | Pypy        | 12.28   | 12.32          | 199.5      |
| Ruby       | JIT         | 13.33   | 13.37          | 54.8       |
| Ruby       |             | 14.15   | 14.19          | 54.7       |
| Python3    | Cython      | 22.52   | 22.54          | 113.1      |
| Python2    | Jython      | 24.84   | 25.96          | 1252.8     |
| Lua        |             | 35.40   | 35.48          | 334.3      |
| Python3    |             | 36.35   | 36.38          | 105.7      |
| Python2    |             | 43.00   | 43.02          | 113.0      |
| Python3    | GraalVM     | 78.12   | 78.22          | 1124.6     |

## Fannkuchredux

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 2.27    | 2.58           | 35.6       |
| Crystal    |             | 2.55    | 2.55           | 3.2        |
| C          | gcc         | 2.63    | 2.63           | 0.7        |
| Javascript | GraalVM_JVM | 4.04    | 5.22           | 470.1      |
| Lua        | JIT         | 4.14    | 4.15           | 2.2        |
| Javascript | GraalVM     | 4.38    | 4.47           | 171.4      |
| Ruby       | Topaz       | 5.54    | 5.57           | 30.5       |
| Ruby       | GraalVM_JVM | 5.64    | 7.07           | 616.9      |
| Ruby       | GraalVM     | 6.39    | 6.41           | 358.2      |
| Python3    | GraalVM_JVM | 9.25    | 11.78          | 788.3      |
| Python2    | Pypy        | 10.79   | 10.82          | 65.9       |
| Python3    | Pypy        | 10.99   | 11.03          | 61.2       |
| Ruby       | JRuby       | 32.72   | 33.68          | 254.4      |
| Python3    | GraalVM     | 35.24   | 35.33          | 510.3      |
| Lua        |             | 36.96   | 36.96          | 1.4        |
| Python3    | Cython      | 41.35   | 41.35          | 6.5        |
| Python2    | Jython      | 55.07   | 56.14          | 460.2      |
| Ruby       |             | 61.78   | 61.81          | 13.4       |
| Ruby       | JIT         | 61.81   | 61.85          | 13.6       |
| Python3    |             | 69.42   | 69.43          | 8.1        |
| Python2    |             | 73.78   | 73.79          | 6.3        |


## Fasta

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.81    | 1.81           | 0.7        |
| Crystal    |             | 2.69    | 2.69           | 4.2        |
| Lua        | JIT         | 4.97    | 4.97           | 2.2        |
| Python2    | Pypy        | 9.42    | 9.45           | 67.4       |
| Ruby       | GraalVM_JVM | 9.94    | 11.43          | 649.4      |
| Javascript | Node        | 11.09   | 11.55          | 438.7      |
| Python3    | Pypy        | 11.26   | 11.30          | 63.5       |
| Lua        |             | 14.39   | 14.39          | 2.5        |
| Ruby       | Topaz       | 14.76   | 14.79          | 50.9       |
| Python3    | GraalVM_JVM | 16.01   | 18.87          | 882.8      |
| Ruby       | GraalVM     | 17.97   | 18.01          | 376.2      |
| Python3    |             | 30.73   | 30.74          | 8.1        |
| Python2    | Cython      | 33.23   | 33.25          | 45.1       |
| Python2    |             | 38.13   | 38.15          | 45.5       |
| Ruby       | JIT         | 46.57   | 46.61          | 42.7       |
| Ruby       |             | 48.58   | 48.61          | 42.0       |
| Python3    | GraalVM     | 51.19   | 51.30          | 522.4      |
| Javascript | GraalVM_JVM | 53.12   | 57.93          | 1004.9     |
| Ruby       | JRuby       | 71.06   | 72.12          | 336.3      |
| Javascript | GraalVM     | 73.74   | 75.91          | 593.1      |
| Python2    | Jython      | 118.31  | 119.48         | 541.9      |

## Knucleotide

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Lua        | JIT         | 2.10    | 2.12           | 50.1       |
| C++        | g++         | 4.48    | 4.48           | 31.6       |
| Python2    | Pypy        | 4.70    | 4.73           | 190.8      |
| Crystal    |             | 5.18    | 5.18           | 58.9       |
| Python3    | Pypy        | 8.92    | 8.97           | 207.1      |
| Lua        |             | 9.04    | 9.05           | 82.2       |
| Python2    | Cython      | 10.87   | 10.94          | 534.6      |
| Ruby       | Topaz       | 11.40   | 11.43          | 133.3      |
| Javascript | Node        | 12.36   | 12.70          | 165.7      |
| Javascript | GraalVM_JVM | 13.49   | 14.82          | 930.9      |
| Python2    |             | 15.93   | 16.05          | 534.8      |
| Python3    | GraalVM_JVM | 17.28   | 19.92          | 1176.6     |
| Ruby       | JIT         | 18.20   | 18.23          | 66.8       |
| Ruby       | JRuby       | 22.18   | 23.21          | 364.2      |
| Python3    |             | 19.53   | 19.54          | 72.3       |
| Ruby       |             | 20.28   | 20.31          | 65.6       |
| Python2    | Jython      | 21.06   | 22.16          | 2608.4     |
| Javascript | GraalVM     | 23.16   | 23.27          | 524.0      |
| Ruby       | GraalVM_JVM | 31.74   | 33.12          | 826.9      |
| Python3    | GraalVM     | 43.47   | 43.57          | 600.8      |
| Ruby       | GraalVM     | 60.92   | 60.96          | 475.1      |

## Mandelbrot

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.41    | 1.41           | 0.7        |
| Crystal    |             | 1.42    | 1.42           | 3.1        |
| Lua        | JIT         | 1.58    | 1.58           | 1.0        |
| Javascript | Node        | 1.74    | 2.07           | 87.8       |
| Python3    | Pypy        | 1.78    | 1.81           | 102.2      |
| Python2    | Pypy        | 1.86    | 1.89           | 107.3      |
| Python3    | GraalVM_JVM | 3.58    | 6.36           | 801.2      |
| Ruby       | Topaz       | 3.61    | 3.64           | 27.0       |
| Javascript | GraalVM_JVM | 4.09    | 5.40           | 653.7      |
| Javascript | GraalVM     | 4.11    | 4.21           | 445.9      |
| Ruby       | GraalVM     | 5.72    | 5.75           | 381.5      |
| Ruby       | GraalVM_JVM | 6.18    | 7.60           | 629.5      |
| Python3    | GraalVM     | 11.09   | 11.19          | 545.6      |
| Lua        |             | 24.68   | 24.68          | 1.2        |
| Python2    | Jython      | 54.70   | 55.81          | 564.2      |
| Ruby       |             | 63.54   | 63.57          | 13.3       |
| Ruby       | JIT         | 64.31   | 64.34          | 13.2       |
| Python2    | Cython      | 68.63   | 68.64          | 30.6       |
| Ruby       | JRuby       | 82.69   | 83.75          | 326.6      |
| Python3    |             | 115.41  | 115.42         | 32.1       |
| Python2    |             | 133.11  | 133.13         | 31.3       |

## NBody

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.77    | 0.78           | 1.1        |
| Javascript | Node        | 0.82    | 1.14           | 38.0       |
| Crystal    |             | 1.00    | 1.00           | 3.2        |
| Lua        | JIT         | 1.25    | 1.25           | 1.1        |
| Ruby       | GraalVM     | 1.54    | 1.57           | 353.1      |
| Ruby       | GraalVM_JVM | 1.69    | 3.19           | 569.8      |
| Ruby       | Topaz       | 4.42    | 4.45           | 31.7       |
| Python3    | GraalVM_JVM | 4.68    | 7.31           | 699.2      |
| Javascript | GraalVM     | 5.26    | 5.36           | 371.8      |
| Javascript | GraalVM_JVM | 6.18    | 7.58           | 796.1      |
| Python3    | Pypy        | 7.04    | 7.08           | 62.5       |
| Python2    | Pypy        | 7.12    | 7.15           | 66.5       |
| Python3    | GraalVM     | 11.66   | 11.76          | 516.8      |
| Lua        |             | 27.04   | 27.04          | 1.2        |
| Python2    | Cython      | 31.06   | 31.10          | 317.6      |
| Ruby       | JIT         | 35.91   | 35.95          | 13.6       |
| Python2    | Jython      | 50.70   | 51.84          | 1396.3     |
| Ruby       |             | 51.45   | 51.48          | 13.3       |
| Ruby       | JRuby       | 59.31   | 60.38          | 371.3      |
| Python3    |             | 70.62   | 70.63          | 7.9        |
| Python2    |             | 82.74   | 82.81          | 317.8      |

## RegexDNA

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Python3    | GraalVM_JVM | 0.58    | 3.88           | 744.0      |
| Python3    | GraalVM     | 0.84    | 2.29           | 534.9      |
| Javascript | Node        | 1.25    | 1.59           | 449.6      |
| Python2    | Pypy        | 2.06    | 2.10           | 215.9      |
| Python3    | Pypy        | 2.25    | 2.30           | 254.9      |
| Ruby       | Topaz       | 2.98    | 3.02           | 339.6      |
| Python3    |             | 5.44    | 5.45           | 113.7      |
| Ruby       |             | 5.66    | 5.70           | 94.3       |
| Ruby       | JIT         | 5.76    | 5.80           | 94.9       |
| Crystal    |             | 5.92    | 5.93           | 181.8      |
| Python2    | Cython      | 5.96    | 5.97           | 114.5      |
| C          | gcc         | 6.15    | 6.15           | 76.2       |
| Python2    |             | 6.28    | 6.29           | 126.7      |
| Python2    | Jython      | 7.33    | 8.46           | 971.5      |
| Lua        |             | 8.77    | 8.78           | 303.9      |
| Lua        | JIT         | 9.49    | 9.50           | 168.1      |
| Ruby       | JRuby       | 9.96    | 10.92          | 343.0      |
| Ruby       | GraalVM_JVM | 10.43   | 11.80          | 1010.9     |
| Javascript | GraalVM_JVM | 15.86   | 17.22          | 1165.0     |
| Ruby       | GraalVM     | 18.73   | 18.77          | 648.7      |
| Javascript | GraalVM     | 25.36   | 25.50          | 1007.3     |

## Revcomp

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.40    | 0.41           | 147.5      |
| Python2    | Cython      | 1.86    | 1.89           | 861.6      |
| Python3    |             | 1.97    | 1.99           | 1183.5     |
| Python2    |             | 2.07    | 2.10           | 828.1      |
| Python2    | Pypy        | 2.48    | 2.55           | 1445.7     |
| Lua        | JIT         | 2.72    | 2.74           | 395.3      |
| Javascript | Node        | 3.07    | 3.40           | 247.1      |
| Ruby       |             | 3.73    | 3.77           | 156.6      |
| Ruby       | JIT         | 3.76    | 3.80           | 157.0      |
| Crystal    |             | 3.99    | 4.02           | 1136.1     |
| Ruby       | Topaz       | 4.86    | 4.91           | 803.5      |
| Python3    | Pypy        | 5.95    | 6.02           | 1310.6     |
| Ruby       | JRuby       | 6.30    | 7.26           | 953.0      |
| Lua        |             | 8.52    | 8.63           | 764.3      |
| Python2    | Jython      | 9.49    | 10.58          | 2262.3     |
| Ruby       | GraalVM_JVM | 9.88    | 11.25          | 1532.2     |
| Python3    | GraalVM_JVM | 10.14   | 12.85          | 4199.5     |
| Ruby       | GraalVM     | 19.27   | 19.32          | 996.9      |
| Javascript | GraalVM     | 20.38   | 20.50          | 1029.4     |
| Javascript | GraalVM_JVM | 27.00   | 28.41          | 1283.8     |
| Python3    | GraalVM     | 76.91   | 77.19          | 2991.3     |


## Pidigits

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 2.20    | 2.20           | 3.4        |
| Javascript | Node        | 2.87    | 3.19           | 36.5       |
| Javascript | GraalVM     | 4.80    | 4.91           | 427.3      |
| Javascript | GraalVM_JVM | 5.40    | 6.71           | 556.3      |
| Python2    |             | 8.69    | 8.69           | 8.2        |
| Python3    |             | 8.72    | 8.72           | 9.5        |
| Crystal    |             | 8.84    | 8.84           | 7.6        |
| Python2    | Cython      | 9.03    | 9.04           | 8.2        |
| Ruby       | Topaz       | 10.13   | 10.16          | 35.3       |
| Python2    | Pypy        | 10.88   | 10.91          | 70.0       |
| Python3    | Pypy        | 11.14   | 11.17          | 65.9       |
| Python2    | Jython      | 13.15   | 14.19          | 696.2      |
| Ruby       | JRuby       | 13.45   | 14.39          | 613.0      |
| Ruby       | GraalVM_JVM | 13.65   | 15.00          | 870.7      |
| Ruby       |             | 14.96   | 14.99          | 161.5      |
| Ruby       | JIT         | 14.99   | 15.03          | 163.5      |
| Ruby       | GraalVM     | 29.03   | 29.06          | 368.8      |

## Spectralnorm

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.16    | 1.16           | 1.0        |
| Crystal    |             | 1.28    | 1.28           | 4.2        |
| Lua        | JIT         | 1.37    | 1.37           | 2.4        |
| Javascript | Node        | 1.48    | 1.80           | 38.3       |
| Ruby     	 | GraalVM     | 2.94    | 2.98           | 356.1      |
| Ruby       | GraalVM_JVM | 3.05    | 4.47           | 619.8      |
| Javascript | GraalVM_JVM | 4.18    | 5.48           | 647.2      |
| Javascript | GraalVM     | 4.29    | 4.40           | 367.3      |
| Python2    | Pypy        | 8.35    | 8.38           | 66.7       |
| Python3    | Pypy        | 9.71    | 9.75           | 62.5       |
| Ruby       | Topaz       | 17.59   | 17.62          | 31.8       |
| Python3    | GraalVM_JVM | 32.71   | 35.50          | 1655.9     |
| Lua        |             | 65.00   | 65.00          | 2.7        |
| Python2    | Cython      | 90.21   | 90.22          | 7.8        |
| Ruby       | JIT         | 133.15  | 133.18         | 15.0       |
| Ruby       | JRuby       | 140.59  | 141.65         | 576.1      |
| Ruby       |             | 156.46  | 156.49         | 14.7       |
| Python3    | GraalVM     | 186.96  | 187.06         | 530.7      |
| Python2    |             | 218.21  | 218.22         | 7.6        |
| Python3    |             | 246.59  | 246.60         | 9.5        |
| Python2    | Jython      | 480.11  | 481.22         | 499.1      |

## Brainfuck

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C++        | g++         | 2.36    | 2.36           | 1.7        |
| Crystal    |             | 4.81    | 4.81           | 3.1        |
| Javascript | Node        | 5.09    | 5.41           | 36.3       |
| Python2    | Pypy        | 8.50    | 8.53           | 61.8       |
| Python3    | Pypy        | 10.86   | 10.92          | 60.4       |
| Ruby       | Topaz       | 18.21   | 18.24          | 29.1       |
| Ruby       | GraalVM_JVM | 21.99   | 23.45          | 638.3      |
| Ruby       | GraalVM     | 25.03   | 25.06          | 385.5      |
| Javascript | GraalVM_JVM | 41.23   | 42.53          | 1201.4     |
| Javascript | GraalVM     | 64.17   | 64.27          | 470.6      |
| Ruby       | JIT         | 97.28   | 97.32          | 13.7       |
| Python3    | GraalVM_JVM | 105.96  | 109.50         | 2014.0     |
| Ruby       |             | 108.19  | 108.22         | 13.4       |
| Ruby       | JRuby       | 124.66  | 125.66         | 276.7      |
| Python2    | Cython      | 172.36  | 172.37         | 6.9        |
| Python3    |             | 303.16  | 303.18         | 9.0        |
| Python2    |             | 321.35  | 321.36         | 6.4        |
| Python2    | Jython      | 328.55  | 329.73         | 503.8      |
| Python3    | GraalVM     | 860.77  | 862.31         | 593.3      |

## Brainfuck2

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.89    | 1.89           | 0.7        |
| Crystal    |             | 2.41    | 2.41           | 3.2        |
| Javascript | Node        | 3.83    | 4.16           | 35.5       |
| Lua        | JIT         | 6.72    | 6.72           | 2.3        |
| Python2    | Pypy        | 11.77   | 11.81          | 66.8       |
| Python3    | Pypy        | 12.19   | 12.25          | 63.3       |
| Python3    | GraalVM_JVM | 13.68   | 17.38          | 904.5      |
| Javascript | GraalVM     | 19.93   | 20.04          | 462.3      |
| Javascript | GraalVM_JVM | 20.46   | 21.74          | 719.5      |
| Ruby       | GraalVM     | 22.89   | 22.93          | 520.7      |
| Ruby       | GraalVM_JVM | 23.44   | 24.89          | 1805.9     |
| Ruby       | Topaz       | 24.15   | 24.18          | 31.7       |
| Python3    | GraalVM     | 29.55   | 31.05          | 610.6      |
| Ruby       | JIT         | 58.30   | 58.34          | 13.6       |
| Lua        |             | 73.89   | 73.90          | 1.4        |
| Ruby       |             | 84.86   | 84.89          | 13.3       |
| Ruby       | JRuby       | 103.82  | 104.80         | 276.7      |
| Python2    | Cython      | 151.32  | 151.33         | 6.7        |
| Python3    |             | 201.86  | 201.88         | 8.9        |
| Python2    | Jython      | 202.72  | 203.89         | 492.6      |
| Python2    |             | 224.49  | 224.50         | 6.3        |

## Matmul

| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 2.39    | 2.39           | 69.9       |
| Crystal    |             | 2.52    | 2.52           | 63.3       |
| Javascript | Node        | 2.66    | 2.99           | 106.2      |
| Lua        | JIT         | 2.78    | 2.79           | 99.3       |
| Python2    | Pypy        | 3.44    | 3.48           | 129.5      |
| Python3    | Pypy        | 3.47    | 3.53           | 127.4      |
| Python3    | GraalVM_JVM | 5.52    | 8.88           | 906.4      |
| Ruby       | GraalVM     | 17.37   | 17.41          | 566.0      |
| Python3    | GraalVM     | 17.43   | 18.84          | 619.4      |
| Ruby       | Topaz       | 21.56   | 21.60          | 241.1      |
| Ruby       | GraalVM_JVM | 23.46   | 24.97          | 862.7      |
| Javascript | GraalVM_JVM | 57.68   | 58.90          | 672.2      |
| Lua        |             | 87.34   | 87.35          | 190.3      |
| Python2    | Cython      | 95.04   | 95.05          | 75.9       |
| Javascript | GraalVM     | 121.76  | 121.86         | 460.3      |
| Ruby       |             | 167.84  | 167.87         | 82.5       |
| Ruby       | JIT         | 170.59  | 170.63         | 83.0       |
| Python3    |             | 221.64  | 221.66         | 77.9       |
| Python2    |             | 284.84  | 284.85         | 76.0       |
| Ruby       | JRuby       | 373.55  | 374.54         | 1041.4     |
| Python2    | Jython      | 856.02  | 857.14         | 554.5      |


## Versions: 
* `Python 2.7.18`
* `Python 3.8.3`
* `Crystal 0.34.0 [4401e90f0] (2020-04-06)`
* `gcc (Debian 9.3.0-13) 9.3.0`
* `g++ (Debian 9.3.0-13) 9.3.0`
* `Lua 5.3.3  Copyright (C) 1994-2016 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/`
* `Nodejs v10.20.1`
* `ruby 2.7.1p83 (2020-03-31 revision a0c7c23c9c) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev 52452d1d) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.2.11.1 (2.5.7) 2020-03-25 b1f55b1a40 OpenJDK 64-Bit Server VM 14.0.1+7-Debian-1 on 14.0.1+7-Debian-1 +jit [linux-x86_64]`
* `Cython version 0.29.14`
* `truffleruby 20.0.0, like ruby 2.6.5, GraalVM CE Native [x86_64-linux]`
* `truffleruby 20.0.0, like ruby 2.6.5, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.13 (d0d41085a83c, Apr 06 2020, 17:09:17) [PyPy 7.3.1 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.6.9 (2ad108f17bdb, Apr 07 2020, 02:59:05) [PyPy 7.3.1 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `openjdk version "14.0.1" 2020-04-14`
* `Python 3.7.4 (GraalVM CE Native 20.0.0)`
* `Python 3.7.4 (GraalVM CE JVM 20.0.0)`
* `GraalNode v12.15.0`
* `Jython 2.7.2`
