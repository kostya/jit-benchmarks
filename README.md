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
| C++        | g++         | 1.04    | 1.05           | 34.9       |
| Crystal    |             | 1.24    | 1.24           | 64.6       |
| Python3    | Cython      | 1.99    | 2.01           | 40.0       |
| C          | gcc         | 2.12    | 2.12           | 33.5       |
| Javascript | Node        | 3.19    | 3.25           | 280.3      |
| Ruby       | Topaz       | 4.41    | 4.42           | 102.4      |
| Javascript | GraalVM_JVM | 6.24    | 7.91           | 1227.4     |
| Ruby       | GraalVM     | 6.78    | 6.80           | 479.9      |
| Ruby       | GraalVM_JVM | 7.56    | 9.35           | 817.9      |
| Ruby       | JRuby       | 7.99    | 9.08           | 418.6      |
| Javascript | GraalVM     | 8.06    | 8.19           | 594.7      |
| Ruby3      | JIT         | 10.39   | 10.44          | 80.4       |
| Python3    | Pypy        | 10.63   | 10.65          | 195.9      |
| Python2    | Pypy        | 11.30   | 11.33          | 218.5      |
| Ruby3      |             | 13.33   | 13.38          | 106.4      |
| Ruby       | JIT         | 13.52   | 13.56          | 54.8       |
| Ruby       |             | 14.52   | 14.56          | 82.7       |
| Lua        | JIT         | 17.68   | 17.75          | 500.8      |
| Python3    | GraalVM_JVM | 24.12   | 27.69          | 1421.8     |
| Python3    | GraalVM     | 29.30   | 29.36          | 1003.1     |
| Ruby       | rbx         | 35.95   | 36.11          | 299.2      |
| Lua        |             | 52.46   | 52.60          | 369.3      |
| Python2    | Jython      | 56.60   | 57.80          | 1712.5     |
| Python3    |             | 204.92  | 204.96         | 202.7      |
| Python3    | Nuitka      | 220.86  | 220.92         | 204.8      |
| Python2    |             | 245.62  | 245.69         | 405.5      |


## Fannkuchredux
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 2.34    | 2.39           | 36.4       |
| Python3    | Cython      | 2.47    | 2.48           | 7.6        |
| Crystal    |             | 2.61    | 2.61           | 3.2        |
| C          | gcc         | 2.65    | 2.65           | 0.5        |
| Lua        | JIT         | 3.44    | 3.45           | 2.3        |
| Javascript | GraalVM_JVM | 4.18    | 5.87           | 478.7      |
| Javascript | GraalVM     | 4.18    | 4.32           | 184.0      |
| Ruby       | GraalVM     | 5.28    | 5.30           | 363.2      |
| Ruby       | GraalVM_JVM | 5.38    | 7.18           | 547.7      |
| Ruby       | Topaz       | 5.74    | 5.75           | 30.4       |
| Python3    | GraalVM_JVM | 8.78    | 12.49          | 787.1      |
| Python3    | Pypy        | 9.05    | 9.07           | 61.3       |
| Python2    | Pypy        | 9.12    | 9.14           | 65.2       |
| Python3    | GraalVM     | 14.72   | 14.78          | 473.9      |
| Lua        |             | 23.90   | 23.90          | 0.9        |
| Ruby       | JRuby       | 28.26   | 29.48          | 177.0      |
| Python3    | Nuitka      | 48.80   | 48.82          | 9.6        |
| Python3    |             | 49.13   | 49.14          | 7.2        |
| Python2    |             | 49.49   | 49.50          | 6.3        |
| Python2    | Jython      | 58.77   | 59.98          | 399.1      |
| Ruby3      |             | 62.16   | 62.20          | 13.3       |
| Ruby       | JIT         | 63.04   | 63.07          | 13.4       |
| Ruby       |             | 63.05   | 63.09          | 13.3       |
| Ruby3      | JIT         | 64.62   | 64.66          | 13.4       |
| Ruby       | rbx         | -       | -              | 1092.9     |


## Fasta
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Python3    | Cython      | -----   | 0.24           | 7.8        |
| C          | gcc         | 1.85    | 1.86           | 0.5        |
| Crystal    |             | 2.56    | 2.56           | 4.3        |
| Lua        | JIT         | 4.61    | 4.61           | 2.3        |
| Python2    | Pypy        | 9.15    | 9.17           | 67.0       |
| Python3    | Pypy        | 10.31   | 10.33          | 64.1       |
| Javascript | Node        | 10.63   | 10.76          | 41.1       |
| Ruby       | GraalVM_JVM | 11.33   | 13.15          | 715.9      |
| Lua        |             | 12.32   | 12.33          | 0.9        |
| Ruby       | Topaz       | 12.79   | 12.81          | 51.1       |
| Ruby       | GraalVM     | 13.70   | 13.73          | 448.6      |
| Python3    | Cython      | 20.83   | 20.85          | 8.4        |
| Python3    | GraalVM_JVM | 24.38   | 28.04          | 887.7      |
| Python3    |             | 27.11   | 27.12          | 7.2        |
| Python2    |             | 33.92   | 33.94          | 45.4       |
| Python3    | Nuitka      | 33.95   | 33.97          | 9.6        |
| Python3    | GraalVM     | 41.71   | 41.90          | 546.7      |
| Javascript | GraalVM_JVM | 46.94   | 50.97          | 703.5      |
| Ruby       | JIT         | 47.63   | 47.67          | 42.3       |
| Ruby       |             | 48.62   | 48.66          | 63.5       |
| Ruby3      | JIT         | 52.21   | 52.25          | 42.2       |
| Ruby       | JRuby       | 53.86   | 55.84          | 337.2      |
| Ruby3      |             | 55.74   | 55.79          | 42.0       |
| Javascript | GraalVM     | 67.95   | 68.74          | 456.5      |
| Python2    | Jython      | 109.97  | 111.24         | 590.1      |
| Ruby       | rbx         | -       | -              | 1013.9     |

## Knucleotide
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Lua        | JIT         | 1.90    | 1.92           | 50.1       |
| Python2    | Pypy        | 4.54    | 4.56           | 189.9      |
| C++        | g++         | 4.93    | 4.93           | 31.5       |
| Crystal    |             | 5.31    | 5.32           | 58.7       |
| Python3    | Pypy        | 8.18    | 8.21           | 191.8      |
| Lua        |             | 8.86    | 8.89           | 92.4       |
| Ruby       | Topaz       | 11.20   | 11.22          | 132.3      |
| Javascript | Node        | 12.69   | 12.75          | 164.3      |
| Python2    |             | 15.22   | 15.33          | 534.9      |
| Javascript | GraalVM_JVM | 18.03   | 19.75          | 788.9      |
| Python3    | Cython      | 19.32   | 19.34          | 72.6       |
| Python3    |             | 19.66   | 19.67          | 71.7       |
| Ruby       | JIT         | 19.99   | 20.03          | 66.1       |
| Ruby       | JRuby       | 21.58   | 22.67          | 495.1      |
| Ruby3      | JIT         | 22.01   | 22.06          | 73.7       |
| Python2    | Jython      | 22.06   | 23.25          | 1714.3     |
| Python3    | Nuitka      | 22.28   | 22.31          | 73.8       |
| Ruby       |             | 24.32   | 24.36          | 67.8       |
| Ruby3      |             | 27.26   | 27.30          | 73.5       |
| Javascript | GraalVM     | 28.02   | 28.15          | 607.8      |
| Python3    | GraalVM_JVM | 28.04   | 31.64          | 1338.6     |
| Ruby       | GraalVM_JVM | 35.49   | 37.27          | 915.1      |
| Python3    | GraalVM     | 62.07   | 62.14          | 1503.9     |
| Ruby       | GraalVM     | 64.63   | 64.65          | 490.2      |
| Ruby       | rbx         | -       | -              | 1011.3     |


## Mandelbrot
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Crystal    |             | 1.45    | 1.45           | 3.2        |
| C          | gcc         | 1.45    | 1.45           | 0.5        |
| Python3    | Cython      | 1.46    | 1.47           | 7.9        |
| Javascript | Node        | 1.50    | 1.55           | 114.8      |
| Lua        | JIT         | 1.60    | 1.61           | 0.9        |
| Python3    | Pypy        | 1.77    | 1.79           | 102.1      |
| Python2    | Pypy        | 1.81    | 1.83           | 106.8      |
| Ruby       | Topaz       | 3.23    | 3.25           | 27.2       |
| Javascript | GraalVM     | 4.20    | 4.33           | 422.0      |
| Javascript | GraalVM_JVM | 4.20    | 5.84           | 610.4      |
| Python3    | GraalVM     | 4.23    | 4.29           | 460.6      |
| Python3    | GraalVM_JVM | 5.21    | 9.40           | 637.4      |
| Ruby       | GraalVM     | 6.29    | 6.31           | 439.6      |
| Ruby       | GraalVM_JVM | 8.29    | 10.12          | 668.8      |
| Lua        |             | 16.60   | 16.60          | 0.9        |
| Python2    | Jython      | 40.75   | 42.01          | 654.6      |
| Ruby       | JRuby       | 59.89   | 60.98          | 341.8      |
| Ruby       |             | 63.19   | 63.23          | 13.7       |
| Ruby       | JIT         | 65.56   | 65.59          | 13.7       |
| Ruby3      |             | 68.31   | 68.35          | 13.2       |
| Ruby3      | JIT         | 69.69   | 69.73          | 13.5       |
| Python3    | Nuitka      | 88.37   | 88.40          | 36.2       |
| Python2    |             | 98.95   | 98.96          | 30.9       |
| Python3    |             | 99.41   | 99.43          | 31.3       |
| Ruby       | rbx         | -       | -              | 1235.5     |

## NBody
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Python3    | Cython      | 0.80    | 0.81           | 7.8        |
| C          | gcc         | 0.80    | 0.80           | 0.8        |
| Javascript | Node        | 0.86    | 0.91           | 38.3       |
| Crystal    |             | 1.01    | 1.01           | 3.1        |
| Lua        | JIT         | 1.27    | 1.27           | 0.9        |
| Ruby       | GraalVM     | 1.42    | 1.44           | 286.6      |
| Ruby       | GraalVM_JVM | 2.37    | 4.33           | 546.9      |
| Ruby       | Topaz       | 4.28    | 4.29           | 31.7       |
| Javascript | GraalVM     | 4.49    | 4.62           | 356.0      |
| Python3    | GraalVM_JVM | 4.67    | 8.25           | 649.7      |
| Python3    | GraalVM     | 5.35    | 5.41           | 287.2      |
| Javascript | GraalVM_JVM | 6.48    | 8.14           | 568.3      |
| Python3    | Pypy        | 6.80    | 6.82           | 63.0       |
| Python2    | Pypy        | 6.89    | 6.91           | 65.9       |
| Lua        |             | 18.60   | 18.62          | 0.9        |
| Ruby3      | JIT         | 38.63   | 38.67          | 13.4       |
| Ruby       | JIT         | 40.50   | 40.53          | 13.5       |
| Ruby       |             | 50.55   | 50.58          | 13.5       |
| Python2    | Jython      | 51.52   | 52.77          | 961.6      |
| Python3    |             | 54.69   | 54.70          | 7.3        |
| Ruby3      |             | 55.64   | 55.68          | 13.3       |
| Ruby       | JRuby       | 57.15   | 58.29          | 315.4      |
| Python2    |             | 60.62   | 60.69          | 317.6      |
| Python3    | Nuitka      | 79.18   | 79.20          | 9.6        |
| Ruby       | rbx         | -       | -              | 1144.2     |

## RegexDNA
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 1.34    | 1.43           | 502.5      |
| Python3    | GraalVM     | 1.71    | 1.98           | 2495.8     |
| Python2    | Pypy        | 2.07    | 2.10           | 197.9      |
| Python3    | Pypy        | 2.15    | 2.19           | 241.0      |
| Ruby       | Topaz       | 2.97    | 3.00           | 342.1      |
| Crystal    |             | 4.82    | 4.82           | 122.9      |
| Python3    |             | 4.87    | 4.88           | 111.9      |
| C          | gcc         | 5.01    | 5.02           | 76.3       |
| Ruby       | JIT         | 5.22    | 5.26           | 94.1       |
| Ruby       |             | 5.23    | 5.26           | 94.2       |
| Ruby3      |             | 5.30    | 5.34           | 100.0      |
| Ruby3      | JIT         | 5.31    | 5.36           | 100.2      |
| Python3    | Cython      | 5.51    | 5.53           | 149.6      |
| Python2    |             | 5.58    | 5.59           | 108.5      |
| Python3    | Nuitka      | 6.12    | 6.14           | 120.9      |
| Python2    | Jython      | 7.22    | 8.39           | 1082.9     |
| Ruby       | JRuby       | 8.25    | 9.36           | 278.0      |
| Lua        |             | 8.91    | 8.92           | 154.3      |
| Lua        | JIT         | 9.39    | 9.40           | 166.1      |
| Ruby       | rbx         | 11.25   | 11.42          | 323.2      |
| Ruby       | GraalVM_JVM | 12.15   | 13.95          | 950.3      |
| Ruby       | GraalVM     | 17.48   | 17.51          | 637.6      |
| Javascript | GraalVM_JVM | 18.92   | 20.71          | 1060.7     |
| Javascript | GraalVM     | 29.87   | 30.04          | 1416.5     |
| Python3    | GraalVM_JVM | -       | -              | 1799.7     |

## Revcomp
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Python3    | GraalVM_JVM | 0.00    | 17.43          | 2063.1     |
| C          | gcc         | 0.43    | 0.43           | 135.2      |
| Python3    |             | 2.06    | 2.07           | 1182.9     |
| Python2    |             | 2.13    | 2.17           | 823.2      |
| Python3    | Cython      | 2.25    | 2.27           | 1183.3     |
| Python3    | Nuitka      | 2.34    | 2.37           | 1185.2     |
| Python2    | Pypy        | 2.59    | 2.74           | 1364.7     |
| Lua        | JIT         | 2.67    | 2.69           | 395.3      |
| Javascript | Node        | 3.55    | 3.64           | 231.0      |
| Ruby       | JIT         | 3.71    | 3.74           | 157.4      |
| Crystal    |             | 3.71    | 3.73           | 916.5      |
| Ruby       |             | 3.76    | 3.80           | 157.2      |
| Ruby3      | JIT         | 4.39    | 4.43           | 157.1      |
| Ruby       | Topaz       | 4.43    | 4.46           | 806.6      |
| Ruby3      |             | 4.64    | 4.69           | 156.7      |
| Python3    | Pypy        | 5.18    | 5.23           | 1339.9     |
| Ruby       | JRuby       | 5.56    | 6.69           | 874.0      |
| Python2    | Jython      | 8.34    | 9.61           | 1780.0     |
| Lua        |             | 9.35    | 9.49           | 648.9      |
| Ruby       | GraalVM_JVM | 14.20   | 16.03          | 1544.6     |
| Javascript | GraalVM     | 15.60   | 15.78          | 880.9      |
| Ruby       | GraalVM     | 17.07   | 17.10          | 989.7      |
| Javascript | GraalVM_JVM | 20.81   | 22.53          | 1089.4     |
| Python3    | GraalVM     | 56.70   | 56.79          | 3073.9     |
| Ruby       | rbx         | -       | -              | 1020.7     |


## Pidigits
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 2.35    | 2.35           | 3.4        |
| Python3    | Cython      | 2.46    | 2.47           | 9.6        |
| Javascript | Node        | 3.19    | 3.26           | 39.2       |
| Javascript | GraalVM     | 5.18    | 5.36           | 436.2      |
| Javascript | GraalVM_JVM | 6.63    | 8.57           | 565.8      |
| Crystal    |             | 8.18    | 8.18           | 7.8        |
| Python2    |             | 9.02    | 9.03           | 8.3        |
| Python3    |             | 9.09    | 9.10           | 9.1        |
| Python3    | Nuitka      | 9.79    | 9.81           | 11.1       |
| Ruby       | Topaz       | 11.86   | 11.87          | 35.7       |
| Python3    | Pypy        | 11.99   | 12.02          | 65.8       |
| Python2    | Pypy        | 12.45   | 12.48          | 70.0       |
| Ruby       | JRuby       | 13.52   | 14.65          | 408.9      |
| Ruby       | GraalVM_JVM | 15.02   | 16.92          | 733.6      |
| Python2    | Jython      | 15.08   | 16.26          | 636.9      |
| Ruby3      | JIT         | 16.16   | 16.20          | 161.7      |
| Ruby3      |             | 16.25   | 16.29          | 162.8      |
| Ruby       |             | 16.55   | 16.58          | 163.7      |
| Ruby       | JIT         | 16.64   | 16.68          | 163.5      |
| Ruby       | GraalVM     | 20.62   | 20.64          | 392.7      |
| Ruby       | rbx         | 34.28   | 34.44          | 89.4       |

## Spectralnorm
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Python3    | Cython      | 1.19    | 1.20           | 9.5        |
| C          | gcc         | 1.20    | 1.20           | 0.9        |
| Javascript | Node        | 1.25    | 1.31           | 36.8       |
| Crystal    |             | 1.29    | 1.29           | 4.3        |
| Lua        | JIT         | 1.42    | 1.42           | 2.4        |
| Ruby       | GraalVM     | 2.54    | 2.56           | 301.5      |
| Ruby       | GraalVM_JVM | 3.11    | 4.98           | 527.9      |
| Javascript | GraalVM     | 3.74    | 3.86           | 350.8      |
| Javascript | GraalVM_JVM | 5.24    | 6.91           | 527.1      |
| Python2    | Pypy        | 8.68    | 8.71           | 66.8       |
| Python3    | Pypy        | 9.68    | 9.70           | 62.2       |
| Ruby       | Topaz       | 16.65   | 16.66          | 31.9       |
| Lua        |             | 58.89   | 58.89          | 2.5        |
| Ruby       | JRuby       | 111.33  | 112.48         | 503.0      |
| Ruby       | JIT         | 131.57  | 131.60         | 15.0       |
| Python3    | GraalVM_JVM | 137.56  | 142.15         | 756.9      |
| Ruby3      | JIT         | 152.77  | 152.82         | 15.5       |
| Ruby       |             | 159.77  | 159.81         | 14.7       |
| Python2    |             | 171.80  | 171.81         | 7.8        |
| Python3    |             | 201.91  | 201.92         | 8.8        |
| Ruby3      |             | 206.11  | 206.15         | 15.1       |
| Python3    | Nuitka      | 256.96  | 256.98         | 10.9       |
| Python3    | GraalVM     | 276.11  | 276.18         | 522.7      |
| Ruby       | rbx         | -       | -              | 1143.7     |
| Python2    | Jython      | -       | -              | 435.8      |


## Brainfuck
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C++        | g++         | 2.31    | 2.31           | 1.5        |
| Crystal    |             | 4.66    | 4.66           | 3.1        |
| Javascript | Node        | 5.38    | 5.44           | 37.2       |
| Python2    | Pypy        | 7.75    | 7.78           | 61.5       |
| Python3    | Pypy        | 10.15   | 10.21          | 61.1       |
| Ruby       | Topaz       | 17.99   | 18.01          | 29.0       |
| Ruby       | GraalVM_JVM | 22.30   | 24.35          | 587.1      |
| Ruby       | GraalVM     | 23.25   | 23.27          | 383.9      |
| Javascript | GraalVM_JVM | 43.44   | 45.33          | 602.0      |
| Javascript | GraalVM     | 60.80   | 60.94          | 425.1      |
| Ruby       | JIT         | 103.85  | 103.89         | 13.7       |
| Ruby3      | JIT         | 105.99  | 106.04         | 13.7       |
| Ruby       |             | 116.29  | 116.33         | 13.5       |
| Ruby       | JRuby       | 119.29  | 120.58         | 285.9      |
| Ruby3      |             | 120.86  | 120.91         | 13.3       |
| Python3    | GraalVM_JVM | 123.62  | 128.48         | 1159.3     |
| Python3    | Cython      | 187.90  | 187.91         | 8.8        |
| Python3    | Nuitka      | 216.72  | 216.74         | 9.4        |
| Python2    |             | 221.29  | 221.30         | 6.3        |
| Python3    |             | 241.26  | 241.28         | 7.9        |
| Ruby       | rbx         | -       | -              | 1235.3     |
| Python3    | GraalVM     | -       | -              | 556.2      |
| Python2    | Jython      | -       | -              | 405.1      |


## Brainfuck2
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.29    | 1.29           | 0.5        |
| Crystal    |             | 2.03    | 2.04           | 3.2        |
| Javascript | Node        | 3.91    | 3.96           | 36.5       |
| Lua        | JIT         | 6.44    | 6.45           | 2.2        |
| Python2    | Pypy        | 11.37   | 11.40          | 66.3       |
| Python3    | Pypy        | 11.60   | 11.66          | 63.4       |
| Ruby       | GraalVM     | 11.75   | 11.78          | 458.2      |
| Python3    | GraalVM_JVM | 12.20   | 16.85          | 808.4      |
| Python3    | GraalVM     | 13.14   | 13.40          | 556.2      |
| Ruby       | GraalVM_JVM | 14.51   | 17.38          | 926.0      |
| Javascript | GraalVM     | 15.69   | 15.81          | 401.2      |
| Javascript | GraalVM_JVM | 16.58   | 18.30          | 596.7      |
| Ruby       | Topaz       | 23.70   | 23.72          | 32.0       |
| Lua        |             | 52.17   | 52.17          | 0.8        |
| Ruby       | JIT         | 59.88   | 59.93          | 13.6       |
| Ruby3      | JIT         | 65.44   | 65.48          | 13.6       |
| Ruby       |             | 91.75   | 91.81          | 13.4       |
| Ruby       | JRuby       | 99.44   | 100.73         | 242.2      |
| Ruby3      |             | 113.52  | 113.56         | 13.4       |
| Python3    |             | 147.65  | 147.67         | 8.3        |
| Python2    |             | 158.83  | 158.84         | 6.2        |
| Python3    | Cython      | 168.00  | 168.02         | 8.7        |
| Python3    | Nuitka      | 172.65  | 172.68         | 9.8        |
| Python2    | Jython      | 198.38  | 199.72         | 438.6      |
| Ruby       | rbx         | -       | -              | 1113.0     |

## Matmul
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 2.60    | 2.61           | 69.9       |
| Crystal    |             | 2.81    | 2.82           | 63.3       |
| Javascript | Node        | 2.84    | 2.90           | 107.0      |
| Lua        | JIT         | 3.31    | 3.32           | 99.1       |
| Python3    | Cython      | 3.45    | 3.47           | 77.4       |
| Python3    | Pypy        | 3.58    | 3.63           | 128.3      |
| Python2    | Pypy        | 3.69    | 3.71           | 128.9      |
| Python3    | GraalVM_JVM | 25.15   | 29.44          | 724.5      |
| Python3    | GraalVM     | 27.78   | 28.01          | 590.8      |
| Ruby       | Topaz       | 43.11   | 43.13          | 241.2      |
| Ruby       | GraalVM_JVM | 43.66   | 45.51          | 771.0      |
| Ruby       | GraalVM     | 49.02   | 49.05          | 568.6      |
| Javascript | GraalVM_JVM | 58.54   | 60.25          | 609.5      |
| Lua        |             | 68.77   | 68.78          | 190.1      |
| Javascript | GraalVM     | 98.94   | 99.08          | 454.8      |
| Ruby3      | JIT         | 173.08  | 173.13         | 83.4       |
| Ruby       |             | 181.82  | 181.86         | 82.6       |
| Ruby       | JIT         | 183.96  | 184.00         | 83.1       |
| Python2    |             | 194.79  | 194.80         | 75.9       |
| Ruby3      |             | 206.33  | 206.37         | 82.6       |
| Python3    |             | 219.74  | 219.76         | 77.9       |
| Python3    | Nuitka      | 298.59  | 298.62         | 79.0       |
| Ruby       | JRuby       | -       | -              | 1074.0     |
| Ruby       | rbx         | -       | -              | 1669.5     |
| Python2    | Jython      | -       | -              | 571.6      |


## Versions: 
* `Python 2.7.18`
* `Python 3.8.6`
* `Crystal 0.35.1 [5999ae29b] (2020-06-19)`
* `gcc (Debian 10.2.0-15) 10.2.0`
* `g++ (Debian 10.2.0-15) 10.2.0`
* `Lua 5.4.0  Copyright (C) 1994-2020 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/`
* `Nodejs v12.19.0`
* `ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev 9cba3561) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.2.13.0 (2.5.7) 2020-08-03 9a89c94bcc OpenJDK 64-Bit Server VM 14.0.2+12-Debian-1.1 on 14.0.2+12-Debian-1.1 +jit [linux-x86_64]`
* `Cython version 0.29.21`
* `truffleruby 20.2.0, like ruby 2.6.6, GraalVM CE Native [x86_64-linux]`
* `truffleruby 20.2.0, like ruby 2.6.6, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.13 (6abe2e00c51d, Sep 23 2020, 05:06:33) [PyPy 7.3.2 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.7.4 (87875bf2dfd8, Sep 24 2020, 07:26:36) [PyPy 7.3.2-alpha0 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `openjdk version "14.0.2" 2020-07-14`
* `Python 3.8.2 (GraalVM CE Native 20.2.0)`
* `Python 3.8.2 (GraalVM CE JVM 20.2.0)`
* `GraalNode v12.18.0`
* `Jython 2.7.2`
* `Nuitka 0.6.9.4`
* `ruby 3.0.0preview1 (2020-09-25 master 0096d2b895) [x86_64-linux]`
* `rubinius 5.0 (10.0 a0a9ed90 2020-05-16 7.0.0) [x86_64-linux-gnu]`
