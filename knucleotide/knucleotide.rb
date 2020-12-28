# The Computer Language Benchmarks Game
# http://benchmarksgame.alioth.debian.org
#
# contributed by jose fco. gonzalez
# modified by Sokolov Yura

seq = ""

def frecuency(seq, length)
    n = seq.length - length + 1
    table = Hash.new(0)

    (0...n).each do |f|
        s = seq[f, length]
        table[s] += 1
    end

    [n, table]
end

def sort_by_freq(seq, length)
    n, table = frecuency(seq, length)
    table.to_a.sort{|a, b| b[1] <=> a[1]}.each do |v|
        puts "%s %.3f" % [v[0].upcase, ((v[1]*100).to_f / n)]
    end
    puts
end

def find_seq(seq, s)
    n, table = frecuency(seq, s.length)
    puts "#{table[s].to_s}\t#{s.upcase}"
end

start = false
STDIN.each_line do |line|
  start = true if line.start_with?(">THREE")

  if start && !line.start_with?(">")
    seq << line.chomp
  end
end

def run(seq)
    t = Time.now
    (1..2).each { |i| sort_by_freq(seq, i) }
    %w(ggt ggta ggtatt ggtattttaatt ggtattttaatttatagt).each { |s| find_seq(seq, s) }
    STDERR.puts("time(#{Time.now - t})")
end

times = (ARGV[0] || 1).to_i
STDERR.puts("started")
times.times { run(seq) }