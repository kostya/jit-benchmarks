TEST_COUNT = (ENV['DC_COUNT'] || 5).to_i

class Benchmark < Struct.new(:name, :timeout, :args, :debug_args, :debug_output, :debug_output_md5, :build_flags, :build_helpers_cmd, :build_helpers_container, :stdin, :debug_stdin, :expected_check_failed, keyword_init: true)
  def get_timeout
    (ENV['DC_TIMEOUT'] || timeout || 1000).to_i
  end
end

BENCHMARKS_LIST = [
  Benchmark.new(
    name: "binarytrees",
    timeout: 110,
    args: [17, TEST_COUNT],
    debug_args: %w{9 1},
    debug_output: <<-Q
stretch tree of depth 10\t check: -1
1024\t trees of depth 4\t check: -1024
256\t trees of depth 6\t check: -256
64\t trees of depth 8\t check: -64
long lived tree of depth 9\t check: -1
Q
  ),

  Benchmark.new(
    name: "matmul",
    timeout: 80,
    args: [700, TEST_COUNT],
    debug_args: %w{100 1},
    debug_output: "-9.335833300"
  ),

  Benchmark.new(
    name: "nbody",
    timeout: 80,
    args: [9000000, TEST_COUNT],
    debug_args: %w{10000 1},
    debug_output: <<-O,
-0.169075164
-0.169016441
O
    build_flags: { "c" => "-lm", "cython" => "-lm" }
  ),

  Benchmark.new(
    name: "mandelbrot",
    timeout: 120,
    args: [2800, TEST_COUNT],
    debug_args: %w{100 1},
    debug_output_md5: "60a2fcddb6bf26740df1b1cdb268db1b",
    expected_check_failed: %w{nodejs graalnode graalnode_jvm}
  ),

  Benchmark.new(
    name: "brainfuck",
    timeout: 190,
    args: ["../bench.b", TEST_COUNT],
    debug_args: %w{../hello.b 1},
    debug_output: "Hello, World!"
  ),

  Benchmark.new(
    name: "brainfuck2",
    timeout: 215,
    args: ["../bench.b", TEST_COUNT],
    debug_args: %w{../hello.b 1},
    debug_output: "Hello, World!"
  ),

  Benchmark.new(
    name: "spectralnorm",
    timeout: 80,
    args: [1500, TEST_COUNT],
    debug_args: %w{100 1},
    debug_output: "1.274219991",
    build_flags: { "c" => "-lm", "cython" => "-lm" }
  ),

  Benchmark.new(
    name: "pidigits",
    timeout: 70,
    args: [17000, TEST_COUNT],
    debug_args: %w{1000 1},
    debug_output_md5: "d68ffe833fdc0ed6ed4b47b7090e6340",
    build_flags: { "c" => "-lgmp", "cython" => "-lgmp" }
  ),

  Benchmark.new(
    name: "fannkuchredux",
    timeout: 60,
    args: [10, TEST_COUNT],
    debug_args: %w{5 1},
    debug_output: <<-Q
11
Pfannkuchen(5) = 7
Q
  ),

  Benchmark.new(
    name: "fasta",
    timeout: 80,
    args: [5000000, TEST_COUNT],
    debug_args: %w{10000 1},
    debug_output_md5: "3550678d7ae37f4369a20f5e0e95ab04"
  ),

  Benchmark.new(
    name: "knucleotide",
    timeout: 60,
    stdin: "args.txt",
    args: [1],
    debug_stdin: "debug_args.txt",
    debug_args: %w{1},
    debug_output: <<-Q,
T 30.408
A 30.305
C 19.652
G 19.635

TT 9.247
AT 9.244
TA 9.230
AA 9.152
TC 6.013
GA 5.975
GT 5.972
AG 5.963
CA 5.948
AC 5.946
CT 5.945
TG 5.917
CG 3.880
CC 3.879
GG 3.875
GC 3.813

1190\tGGT
358\tGGTA
36\tGGTATT
0\tGGTATTTTAATT
0\tGGTATTTTAATTTATAGT
Q
    build_helpers_container: "base",
    build_helpers_cmd: -> { "gcc -O2 ../helper.c -o helper && ./helper 1400000 > args.txt && ./helper 20000 > debug_args.txt" },
    expected_check_failed: %w{php php_jit}
  ),

  Benchmark.new(
    name: "regexdna",
    timeout: 60,
    stdin: "args.txt",
    args: [1],
    debug_stdin: "debug_args.txt",
    debug_args: %w{1},
    debug_output_md5: "84cf61789b81633247512f697a349753",
    build_helpers_container: "base",
    build_helpers_cmd: -> { "gcc -O2 ../helper.c -o helper && ./helper 3500000 > args.txt && ./helper 5000 > debug_args.txt" },
    build_flags: { "c" => "-lpcre" }
  ),

  Benchmark.new(
    name: "revcomp",
    timeout: 60,
    stdin: "args.txt",
    args: [1],
    debug_stdin: "debug_args.txt",
    debug_args: %w{1},
    debug_output_md5: "47de276e2f72519b57b82da39f4c7592",
    build_helpers_container: "base",
    build_helpers_cmd: -> { "gcc -O2 ../helper.c -o helper && ./helper 30000000 > args.txt && ./helper 10000 > debug_args.txt" }
  ),

]

BENCHMARKS = {}
BENCHMARKS_LIST.each { |b| BENCHMARKS[b.name] = b }
