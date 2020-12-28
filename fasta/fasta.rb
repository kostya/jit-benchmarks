# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org/
# Contributed by Sokolov Yura
# Modified by Joseph LaFata

$last = 42.0
IM=139968
IA=3877
IC=29573
def gen_random (max)
  $last = (($last * IA + IC) % IM).to_i
  (max * $last) / IM
end

ALU =
   "GGCCGGGCGCGGTGGCTCACGCCTGTAATCCCAGCACTTTGG"+
   "GAGGCCGAGGCGGGCGGATCACCTGAGGTCAGGAGTTCGAGA"+
   "CCAGCCTGGCCAACATGGTGAAACCCCGTCTCTACTAAAAAT"+
   "ACAAAAATTAGCCGGGCGTGGTGGCGCGCGCCTGTAATCCCA"+
   "GCTACTCGGGAGGCTGAGGCAGGAGAATCGCTTGAACCCGGG"+
   "AGGCGGAGGTTGCAGTGAGCCGAGATCGCGCCACTGCACTCC"+
   "AGCCTGGGCGACAGAGCGAGACTCCGTCTCAAAAA"

IUB = [
  ["a", 0.27],
  ["c", 0.12],
  ["g", 0.12],
  ["t", 0.27],

  ["B", 0.02],
  ["D", 0.02],
  ["H", 0.02],
  ["K", 0.02],
  ["M", 0.02],
  ["N", 0.02],
  ["R", 0.02],
  ["S", 0.02],
  ["V", 0.02],
  ["W", 0.02],
  ["Y", 0.02],
]
HOMO = [
  ["a", 0.3029549426680],
  ["c", 0.1979883004921],
  ["g", 0.1975473066391],
  ["t", 0.3015094502008],
]

def make_repeat_fasta(id, desc, src, n)
  puts ">#{id} #{desc}"
  l = src.length
  s = src * ((n / l) + 1)
  s.slice!(n, l)
  0.step(s.length-1,60) {|x| print s[x,60] , "\n"}
end

def puts_line(table, len)
  output = ""
  len.times do
    rand = gen_random(1.0)
    table.each do |v|
      if v[1] > rand then
        output << v[0]
        break
      end
    end
  end
  puts output
end

def make_random_fasta(id, desc, table, n)
  width = 60
  puts ">#{id} #{desc}"
  rand, v = nil,nil
  (n / width).times { puts_line(table, width) }
  if n % width > 0
    puts_line(table, n % width)
  end
end

def run(n)
  t = Time.now

  make_repeat_fasta('ONE', 'Homo sapiens alu', ALU, n*2)
  make_random_fasta('TWO', 'IUB ambiguity codes', IUB, n*3)
  make_random_fasta('THREE', 'Homo sapiens frequency', HOMO, n*5)

  STDERR.puts("time(#{Time.now - t})")
end

prob = 0.0
IUB.each { |v| v[1] = (prob += v[1]) }
prob = 0.0
HOMO.each { |v| v[1] = (prob += v[1]) }

n = (ARGV[0] || 10).to_i
times = (ARGV[1] || 1).to_i
STDERR.puts("started")
times.times { run(n) }
