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
| C++        | g++         | 1.08    | 1.09           | 34.9       |
| Crystal    |             | 1.32    | 1.33           | 64.5       |
| Python3    | Cython      | 2.09    | 2.11           | 39.8       |
| C          | gcc         | 2.24    | 2.24           | 33.4       |
| Javascript | Node        | 3.15    | 3.22           | 282.7      |
| Ruby       | Topaz       | 4.76    | 4.78           | 102.3      |
| Javascript | GraalVM_JVM | 6.66    | 8.40           | 1087.7     |
| Ruby       | GraalVM     | 7.43    | 7.45           | 506.3      |
| Ruby       | JRuby       | 8.01    | 9.27           | 628.3      |
| Ruby       | GraalVM_JVM | 8.20    | 10.06          | 790.7      |
| Javascript | GraalVM     | 8.31    | 8.44           | 608.1      |
| Python3    | Pypy        | 9.39    | 9.41           | 210.9      |
| Ruby3      | JIT         | 10.40   | 10.44          | 80.5       |
| Python2    | Pypy        | 11.13   | 11.15          | 218.6      |
| Ruby3      |             | 13.89   | 13.94          | 80.4       |
| Ruby       | JIT         | 13.92   | 13.97          | 55.1       |
| Ruby       |             | 15.26   | 15.31          | 82.8       |
| Lua        | JIT         | 18.11   | 18.18          | 499.4      |
| Python3    | GraalVM_JVM | 22.43   | 26.02          | 1278.1     |
| Python3    | GraalVM     | 30.82   | 30.88          | 1087.4     |
| Ruby       | rbx         | 37.09   | 37.25          | 299.2      |
| Lua        |             | 56.47   | 56.62          | 369.2      |
| Python2    | Jython      | 57.81   | 59.02          | 1706.6     |
| Python3    | Nuitka      | > 60    | > 60           | 204.8      |
| Python2    |             | > 60    | > 60           | 405.3      |
| Python3    |             | > 60    | > 60           | 202.4      |


## Fannkuchredux
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 2.37    | 2.42           | 36.3       |
| Python3    | Cython      | 2.50    | 2.51           | 7.6        |
| Crystal    |             | 2.63    | 2.63           | 3.1        |
| C          | gcc         | 2.69    | 2.69           | 0.5        |
| Lua        | JIT         | 3.41    | 3.41           | 2.3        |
| Javascript | GraalVM_JVM | 4.21    | 5.88           | 475.1      |
| Javascript | GraalVM     | 4.24    | 4.35           | 185.7      |
| Ruby       | GraalVM     | 5.39    | 5.41           | 362.3      |
| Ruby       | GraalVM_JVM | 5.46    | 7.25           | 513.9      |
| Ruby       | Topaz       | 5.74    | 5.75           | 30.0       |
| Python3    | GraalVM_JVM | 8.82    | 12.52          | 932.2      |
| Python2    | Pypy        | 9.13    | 9.15           | 64.2       |
| Python3    | Pypy        | 9.16    | 9.18           | 60.6       |
| Python3    | GraalVM     | 14.92   | 14.98          | 473.7      |
| Lua        |             | 24.14   | 24.15          | 0.8        |
| Ruby       | JRuby       | 34.83   | 35.91          | 171.7      |
| Python2    |             | 49.21   | 49.21          | 6.1        |
| Python3    | Nuitka      | 49.83   | 49.85          | 9.4        |
| Python3    |             | 49.86   | 49.87          | 7.2        |
| Python2    | Jython      | 61.84   | 63.07          | 422.1      |
| Ruby       |             | 62.18   | 62.22          | 13.4       |
| Ruby       | JIT         | 62.39   | 62.43          | 13.5       |
| Ruby3      |             | 62.40   | 62.44          | 13.2       |
| Ruby3      | JIT         | 62.44   | 62.48          | 13.3       |
| Ruby       | rbx         | > 70    | > 70           | 543.2      |


## Fasta
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.85    | 1.85           | 0.5        |
| Crystal    |             | 2.60    | 2.60           | 4.3        |
| Lua        | JIT         | 4.70    | 4.70           | 2.2        |
| Python2    | Pypy        | 9.00    | 9.02           | 65.9       |
| Python3    | Pypy        | 10.46   | 10.48          | 63.1       |
| Javascript | Node        | 10.71   | 10.84          | 41.1       |
| Ruby       | GraalVM_JVM | 11.68   | 13.51          | 733.9      |
| Lua        |             | 12.44   | 12.44          | 0.8        |
| Ruby       | Topaz       | 12.88   | 12.90          | 52.4       |
| Ruby       | GraalVM     | 13.89   | 13.91          | 466.0      |
| Python3    | Cython      | 21.34   | 21.35          | 8.3        |
| Python3    | GraalVM_JVM | 25.03   | 28.63          | 892.1      |
| Python3    |             | 27.80   | 27.81          | 7.0        |
| Python3    | Nuitka      | 34.75   | 34.77          | 9.4        |
| Python2    |             | 39.81   | 39.83          | 45.4       |
| Python3    | GraalVM     | 41.74   | 41.81          | 529.9      |
| Ruby       | JIT         | 47.46   | 47.49          | 42.7       |
| Javascript | GraalVM_JVM | 48.64   | 52.12          | 762.5      |
| Ruby       |             | 49.00   | 49.04          | 42.2       |
| Ruby3      | JIT         | 51.91   | 51.95          | 42.0       |
| Ruby3      |             | 55.38   | 55.41          | 41.7       |
| Ruby       | JRuby       | 64.38   | 65.49          | 314.8      |
| Javascript | GraalVM     | 68.27   | 69.41          | 527.7      |
| Ruby       | rbx         | > 100   | > 100          | 597.2      |
| Python2    | Jython      | > 100   | > 100          | 493.2      |


## Knucleotide
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Lua        | JIT         | 1.91    | 1.94           | 50.1       |
| Python2    | Pypy        | 4.50    | 4.52           | 188.7      |
| C++        | g++         | 4.68    | 4.68           | 31.5       |
| Crystal    |             | 5.41    | 5.41           | 58.8       |
| Python3    | Pypy        | 8.14    | 8.16           | 190.1      |
| Lua        |             | 9.43    | 9.47           | 92.4       |
| Ruby       | Topaz       | 11.32   | 11.34          | 132.1      |
| Javascript | Node        | 12.85   | 12.93          | 163.3      |
| Python2    |             | 15.51   | 15.63          | 534.8      |
| Python3    |             | 19.62   | 19.64          | 71.4       |
| Python3    | Cython      | 19.70   | 19.72          | 72.5       |
| Ruby       | JIT         | 19.95   | 20.00          | 68.1       |
| Javascript | GraalVM_JVM | 20.18   | 22.63          | 877.5      |
| Ruby       | JRuby       | 20.92   | 22.00          | 319.0      |
| Python3    | Nuitka      | 22.21   | 22.24          | 73.5       |
| Ruby3      | JIT         | 23.58   | 23.63          | 73.1       |
| Ruby       |             | 23.82   | 23.86          | 67.5       |
| Python2    | Jython      | 24.07   | 25.69          | 1806.7     |
| Ruby3      |             | 27.79   | 27.83          | 74.2       |
| Python3    | GraalVM_JVM | 30.77   | 35.59          | 1326.6     |
| Javascript | GraalVM     | 30.86   | 31.03          | 581.2      |
| Ruby       | GraalVM_JVM | 34.58   | 36.44          | 800.8      |
| Python3    | GraalVM     | 60.34   | 60.41          | 1496.8     |
| Ruby       | GraalVM     | 65.39   | 65.41          | 485.8      |
| Ruby       | rbx         | > 300   | > 300          | 1012.9     |


## Mandelbrot
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Crystal    |             | 0.94    | 0.94           | 3.1        |
| C          | gcc         | 0.94    | 0.94           | 0.5        |
| Python3    | Cython      | 0.95    | 0.96           | 7.6        |
| Javascript | Node        | 0.96    | 1.01           | 71.7       |
| Lua        | JIT         | 1.04    | 1.04           | 0.9        |
| Ruby       | Topaz       | 2.00    | 2.01           | 26.5       |
| Javascript | GraalVM     | 2.73    | 2.85           | 370.3      |
| Python3    | GraalVM     | 2.81    | 2.86           | 462.9      |
| Javascript | GraalVM_JVM | 2.84    | 4.45           | 575.1      |
| Python3    | GraalVM_JVM | 3.54    | 7.07           | 644.1      |
| Python3    | Pypy        | 3.59    | 3.62           | 86.1       |
| Python2    | Pypy        | 3.67    | 3.69           | 92.6       |
| Ruby       | GraalVM     | 4.44    | 4.46           | 421.9      |
| Ruby       | GraalVM_JVM | 6.52    | 8.25           | 653.4      |
| Lua        |             | 10.51   | 10.51          | 0.9        |
| Ruby       |             | 41.22   | 41.25          | 13.7       |
| Ruby       | JIT         | 41.51   | 41.55          | 13.6       |
| Ruby3      | JIT         | 43.94   | 43.98          | 13.3       |
| Ruby3      |             | 44.05   | 44.08          | 13.2       |
| Ruby       | JRuby       | 49.04   | 50.07          | 337.7      |
| Python3    | Nuitka      | 57.83   | 57.85          | 24.9       |
| Python2    | Jython      | 58.12   | 59.26          | 428.9      |
| Python2    |             | 62.15   | 62.16          | 21.8       |
| Python3    |             | 62.49   | 62.50          | 22.8       |
| Ruby       | rbx         | > 70    | > 70           | 614.7      |


## NBody
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Python3    | Cython      | 0.80    | 0.81           | 7.7        |
| C          | gcc         | 0.81    | 0.81           | 0.8        |
| Javascript | Node        | 0.84    | 0.90           | 38.9       |
| Crystal    |             | 1.02    | 1.03           | 3.2        |
| Lua        | JIT         | 1.30    | 1.30           | 0.9        |
| Ruby       | GraalVM     | 1.49    | 1.52           | 535.2      |
| Ruby       | GraalVM_JVM | 2.00    | 3.71           | 561.1      |
| Javascript | GraalVM     | 4.37    | 4.50           | 644.2      |
| Ruby       | Topaz       | 4.60    | 4.62           | 31.6       |
| Python3    | GraalVM_JVM | 4.72    | 9.04           | 637.0      |
| Python3    | GraalVM     | 5.19    | 5.26           | 359.7      |
| Python3    | Pypy        | 6.94    | 6.96           | 62.8       |
| Python2    | Pypy        | 7.02    | 7.04           | 66.0       |
| Javascript | GraalVM_JVM | 7.26    | 9.51           | 772.2      |
| Lua        |             | 20.11   | 20.11          | 0.9        |
| Ruby3      | JIT         | 39.37   | 39.41          | 13.5       |
| Ruby       | JIT         | 40.23   | 40.26          | 13.5       |
| Ruby       | JRuby       | 47.44   | 48.59          | 334.6      |
| Ruby       |             | 50.65   | 50.68          | 13.4       |
| Python3    |             | 54.56   | 54.57          | 7.0        |
| Ruby3      |             | 55.60   | 55.64          | 13.2       |
| Python2    | Jython      | 55.62   | 57.24          | 3.0        |
| Python2    |             | 60.80   | 60.88          | 317.5      |
| Python3    | Nuitka      | > 80    | > 80           | 9.6        |
| Ruby       | rbx         | > 80    | > 80           | 604.9      |


## RegexDNA
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| Javascript | Node        | 1.28    | 1.44           | 514.1      |
| Python2    | Pypy        | 2.06    | 2.08           | 215.1      |
| Python3    | Pypy        | 2.15    | 2.18           | 240.3      |
| Ruby       | Topaz       | 2.97    | 2.99           | 339.8      |
| Crystal    |             | 4.73    | 4.74           | 117.6      |
| C          | gcc         | 4.86    | 4.86           | 76.2       |
| Python3    |             | 4.89    | 4.90           | 127.1      |
| Ruby       |             | 5.21    | 5.24           | 94.6       |
| Ruby       | JIT         | 5.23    | 5.27           | 94.9       |
| Ruby3      |             | 5.41    | 5.45           | 94.9       |
| Ruby3      | JIT         | 5.47    | 5.52           | 95.2       |
| Python3    | Cython      | 5.47    | 5.49           | 142.0      |
| Python2    |             | 5.60    | 5.60           | 104.5      |
| Python3    | Nuitka      | 6.01    | 6.02           | 133.1      |
| Python2    | Jython      | 7.50    | 8.94           | 2.9        |
| Ruby       | JRuby       | 7.68    | 8.71           | 292.9      |
| Lua        |             | 8.75    | 8.75           | 180.0      |
| Lua        | JIT         | 9.65    | 9.67           | 175.0      |
| Ruby       | rbx         | 11.27   | 11.42          | 383.3      |
| Javascript | GraalVM_JVM | 20.27   | 22.15          | 1038.9     |
| Javascript | GraalVM     | 27.20   | 27.59          | 2196.9     |
| Ruby       | GraalVM     | > 60    | > 60           | 810.7      |
| Ruby       | GraalVM_JVM | > 60    | > 60           | 789.3      |
| Python3    | GraalVM     | > 60    | > 60           | 4621.6     |
| Python3    | GraalVM_JVM | -       | -              | 1336.7     |


## Revcomp
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.42    | 0.43           | 147.4      |
| Python2    |             | 2.09    | 2.14           | 857.3      |
| Python3    |             | 2.16    | 2.18           | 1183.0     |
| Python3    | Nuitka      | 2.33    | 2.36           | 1185.1     |
| Python3    | Cython      | 2.34    | 2.36           | 1183.7     |
| Python2    | Pypy        | 2.51    | 2.71           | 1306.4     |
| Lua        | JIT         | 2.64    | 2.66           | 395.4      |
| Javascript | Node        | 3.67    | 3.83           | 229.9      |
| Crystal    |             | 3.72    | 3.74           | 916.5      |
| Ruby       | JIT         | 3.73    | 3.77           | 157.5      |
| Ruby       |             | 3.85    | 3.89           | 157.0      |
| Ruby       | Topaz       | 4.45    | 4.49           | 733.7      |
| Ruby3      | JIT         | 4.53    | 4.57           | 156.8      |
| Ruby3      |             | 4.60    | 4.64           | 156.6      |
| Python3    | Pypy        | 5.02    | 5.07           | 1291.2     |
| Ruby       | JRuby       | 5.93    | 7.11           | 902.8      |
| Lua        |             | 9.36    | 9.48           | 648.9      |
| Javascript | GraalVM     | 9.77    | 10.17          | 1305.7     |
| Ruby       | GraalVM_JVM | 11.20   | 12.99          | 1844.0     |
| Ruby       | GraalVM     | 12.11   | 12.14          | 1719.0     |
| Javascript | GraalVM_JVM | 14.41   | 16.49          | 1018.0     |
| Python3    | GraalVM_JVM | 16.16   | 21.42          | 2107.3     |
| Python3    | GraalVM     | 39.34   | 39.48          | 3553.0     |
| Ruby       | rbx         | > 60    | > 60           | 494.3      |
| Python2    | Jython      | -       | -              | 2.9        |


## Pidigits
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 2.32    | 2.33           | 3.4        |
| Python3    | Cython      | 2.50    | 2.51           | 10.0       |
| Javascript | Node        | 3.39    | 3.45           | 40.0       |
| Javascript | GraalVM     | 4.92    | 5.09           | 551.7      |
| Javascript | GraalVM_JVM | 6.90    | 8.95           | 578.0      |
| Crystal    |             | 8.40    | 8.40           | 7.6        |
| Python2    |             | 9.07    | 9.08           | 7.9        |
| Python3    |             | 9.16    | 9.16           | 8.8        |
| Python3    | Nuitka      | 9.88    | 9.90           | 11.1       |
| Ruby       | Topaz       | 11.54   | 11.56          | 35.4       |
| Python3    | Pypy        | 12.38   | 12.40          | 65.1       |
| Python2    | Pypy        | 12.47   | 12.49          | 70.4       |
| Ruby       | JRuby       | 13.26   | 14.45          | 469.4      |
| Ruby       | GraalVM_JVM | 14.38   | 16.25          | 761.2      |
| Python2    | Jython      | 15.57   | 16.92          | 2.8        |
| Ruby3      |             | 16.63   | 16.67          | 163.6      |
| Ruby3      | JIT         | 16.77   | 16.82          | 161.8      |
| Ruby       |             | 16.86   | 16.90          | 163.4      |
| Ruby       | GraalVM     | 17.27   | 17.30          | 637.1      |
| Ruby       | JIT         | 17.27   | 17.31          | 163.7      |
| Ruby       | rbx         | 35.11   | 35.26          | 89.3       |


## Spectralnorm
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.43    | 0.43           | 0.8        |
| Python3    | Cython      | 0.44    | 0.44           | 8.8        |
| Javascript | Node        | 0.48    | 0.53           | 37.1       |
| Crystal    |             | 0.48    | 0.48           | 4.3        |
| Lua        | JIT         | 0.51    | 0.52           | 2.3        |
| Ruby       | GraalVM     | 1.00    | 1.02           | 369.3      |
| Ruby       | GraalVM_JVM | 1.67    | 3.52           | 521.1      |
| Javascript | GraalVM     | 1.73    | 1.87           | 532.1      |
| Javascript | GraalVM_JVM | 1.97    | 3.79           | 549.6      |
| Python2    | Pypy        | 2.95    | 2.97           | 66.6       |
| Python3    | Pypy        | 3.29    | 3.31           | 61.0       |
| Ruby       | Topaz       | 6.31    | 6.32           | 32.2       |
| Lua        |             | 21.00   | 21.00          | 2.0        |
| Ruby       | JIT         | 49.03   | 49.06          | 14.4       |
| Ruby3      | JIT         | 49.21   | 49.25          | 14.6       |
| Ruby       | JRuby       | 50.64   | 51.84          | 441.7      |
| Python3    | GraalVM_JVM | 51.95   | 56.30          | 735.2      |
| Ruby       |             | 57.51   | 57.54          | 14.2       |
| Python2    |             | 62.59   | 62.60          | 7.4        |
| Ruby3      |             | 67.42   | 67.46          | 14.2       |
| Python3    |             | 71.27   | 71.28          | 8.3        |
| Python3    | GraalVM     | 76.79   | 76.88          | 967.6      |
| Python3    | Nuitka      | 92.29   | 92.31          | 10.4       |
| Ruby       | rbx         | > 120   | > 120          | 716.5      |
| Python2    | Jython      | > 120   | > 120          | 2.8        |


## Brainfuck
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C++        | g++         | 2.27    | 2.27           | 1.5        |
| Crystal    |             | 4.86    | 4.86           | 3.2        |
| Javascript | Node        | 5.35    | 5.41           | 37.0       |
| Python2    | Pypy        | 7.97    | 8.00           | 62.1       |
| Python3    | Pypy        | 10.29   | 10.35          | 60.6       |
| Ruby       | Topaz       | 17.62   | 17.64          | 28.9       |
| Ruby       | GraalVM_JVM | 19.61   | 21.41          | 574.4      |
| Ruby       | GraalVM     | 20.65   | 20.67          | 624.0      |
| Javascript | GraalVM_JVM | 44.97   | 47.58          | 918.5      |
| Python3    | GraalVM_JVM | 46.65   | 53.58          | 973.4      |
| Python3    | GraalVM     | 50.28   | 50.63          | 980.2      |
| Javascript | GraalVM     | 52.09   | 52.25          | 668.9      |
| Ruby       | JIT         | 103.46  | 103.49         | 13.7       |
| Ruby3      | JIT         | 109.87  | 109.92         | 13.5       |
| Ruby       |             | 117.71  | 117.74         | 13.5       |
| Ruby3      |             | 122.72  | 122.76         | 13.1       |
| Ruby       | JRuby       | 141.29  | 142.42         | 244.2      |
| Python3    | Cython      | 193.84  | 193.85         | 9.0        |
| Python3    | Nuitka      | > 200   | > 200          | 9.5        |
| Ruby       | rbx         | > 200   | > 200          | 1021.6     |
| Python2    |             | > 200   | > 200          | 6.0        |
| Python3    |             | > 200   | > 200          | 7.9        |
| Python2    | Jython      | > 200   | > 200          | 2.9        |


## Brainfuck2
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 1.26    | 1.27           | 0.6        |
| Crystal    |             | 2.03    | 2.04           | 3.1        |
| Javascript | Node        | 3.98    | 4.05           | 36.6       |
| Lua        | JIT         | 6.50    | 6.50           | 2.2        |
| Python2    | Pypy        | 11.86   | 11.89          | 66.1       |
| Python3    | GraalVM     | 12.91   | 13.27          | 999.4      |
| Python3    | Pypy        | 12.93   | 13.00          | 62.6       |
| Python3    | GraalVM_JVM | 13.25   | 19.42          | 794.4      |
| Javascript | GraalVM     | 14.30   | 14.45          | 689.9      |
| Javascript | GraalVM_JVM | 17.11   | 19.10          | 600.1      |
| Ruby       | GraalVM     | 17.63   | 17.66          | 763.8      |
| Ruby       | GraalVM_JVM | 18.16   | 20.33          | 1178.6     |
| Ruby       | Topaz       | 22.78   | 22.80          | 31.4       |
| Lua        |             | 52.80   | 52.81          | 0.9        |
| Ruby       | JIT         | 59.16   | 59.20          | 13.7       |
| Ruby3      | JIT         | 64.80   | 64.84          | 13.6       |
| Ruby       | JRuby       | 95.43   | 96.51          | 222.5      |
| Ruby       |             | 96.96   | 96.99          | 13.3       |
| Ruby3      |             | 111.35  | 111.39         | 13.3       |
| Python3    |             | 153.09  | 153.10         | 7.9        |
| Python2    |             | 160.84  | 160.85         | 6.1        |
| Python3    | Cython      | 166.13  | 166.15         | 8.9        |
| Python3    | Nuitka      | 174.21  | 174.23         | 9.8        |
| Ruby       | rbx         | > 200   | > 200          | 920.2      |
| Python2    | Jython      | > 200   | > 200          | 2.9        |


## Matmul
| Language   | Interpreter | Time, s | Script Time, s | Memory, Mb |
|------------|-------------|---------|----------------|------------|
| C          | gcc         | 0.95    | 0.96           | 38.0       |
| Crystal    |             | 1.11    | 1.11           | 48.4       |
| Javascript | Node        | 1.18    | 1.24           | 76.1       |
| Lua        | JIT         | 1.32    | 1.33           | 73.8       |
| Python3    | Cython      | 1.43    | 1.45           | 45.7       |
| Python2    | Pypy        | 1.48    | 1.51           | 97.6       |
| Python3    | Pypy        | 1.53    | 1.58           | 95.6       |
| Ruby       | GraalVM     | 7.10    | 7.14           | 762.0      |
| Python3    | GraalVM     | 10.06   | 10.36          | 782.5      |
| Ruby       | Topaz       | 10.13   | 10.15          | 139.3      |
| Python3    | GraalVM_JVM | 12.26   | 19.31          | 812.2      |
| Ruby       | GraalVM_JVM | 13.76   | 15.62          | 742.2      |
| Javascript | GraalVM_JVM | 14.82   | 17.33          | 554.3      |
| Javascript | GraalVM     | 16.40   | 16.55          | 326.7      |
| Lua        |             | 26.44   | 26.45          | 139.9      |
| Ruby3      | JIT         | 71.20   | 71.24          | 51.2       |
| Ruby       |             | 72.04   | 72.07          | 50.8       |
| Ruby       | JIT         | 74.15   | 74.18          | 51.1       |
| Python2    |             | 80.60   | 80.61          | 44.0       |
| Ruby3      |             | 81.95   | 82.00          | 50.9       |
| Python3    |             | 88.14   | 88.16          | 45.9       |
| Python3    | Nuitka      | 115.06  | 115.08         | 47.0       |
| Ruby       | JRuby       | 159.49  | 160.65         | 691.7      |
| Ruby       | rbx         | > 200   | > 200          | 1200.0     |
| Python2    | Jython      | > 200   | > 200          | 2.9        |


## Versions:
* `Python 2.7.18`
* `Python 3.8.6`
* `Crystal 0.35.1 [5999ae29b] (2020-06-19)`
* `gcc (Debian 10.2.0-16) 10.2.0`
* `g++ (Debian 10.2.0-16) 10.2.0`
* `Lua 5.4.0  Copyright (C) 1994-2020 Lua.org, PUC-Rio`
* `LuaJIT 2.1.0-beta3 -- Copyright (C) 2005-2017 Mike Pall. http://luajit.org/`
* `Nodejs v12.19.0`
* `ruby 2.7.2p137 (2020-10-01 revision 5445e04352) [x86_64-linux]`
* `topaz (ruby-2.4.0p0) (git rev a7e2694a) (kostya build: https://github.com/kostya/topaz) [x86_64-linux]`
* `jruby 9.2.13.0 (2.5.7) 2020-08-03 9a89c94bcc OpenJDK 64-Bit Server VM 14.0.2+12-Debian-1.1 on 14.0.2+12-Debian-1.1 +jit [linux-x86_64]`
* `Cython version 0.29.21`
* `truffleruby 20.3.0, like ruby 2.6.6, GraalVM CE Native [x86_64-linux]`
* `truffleruby 20.3.0, like ruby 2.6.6, GraalVM CE JVM [x86_64-linux]`
* `Python 2.7.13 (6abe2e00c51d, Sep 23 2020, 05:06:33) [PyPy 7.3.2 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `Python 3.7.4 (87875bf2dfd8, Sep 24 2020, 07:26:36) [PyPy 7.3.2-alpha0 with GCC 7.3.1 20180303 (Red Hat 7.3.1-5)]`
* `openjdk version "14.0.2" 2020-07-14`
* `Python 3.8.5 (GraalVM CE Native 20.3.0)`
* `Python 3.8.5 (GraalVM CE JVM 20.3.0)`
* `GraalNode v12.18.4`
* `Jython 2.7.2`
* `Nuitka 0.6.9.7`
* `ruby 3.0.0preview1 (2020-09-25 master 0096d2b895) [x86_64-linux]`
* `rubinius 5.0 (10.0 a0a9ed90 2020-05-16 7.0.0) [x86_64-linux-gnu]`

