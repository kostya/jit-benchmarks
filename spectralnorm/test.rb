# Copied with little modifications from: https://github.com/wmoxam/Ruby-Benchmarks-Game/blob/master/benchmarks/spectral-norm.rb

def eval_A(i, j)
  1.0 / ((i + j) * (i + j + 1.0) / 2.0 + i + 1.0)
end

def eval_A_times_u(u)
  (0...u.size).map do |i|
    v = 0.0
    u.each_with_index do |uu, j|
      v += eval_A(i, j) * uu
    end
    v
  end
end

def eval_At_times_u(u)
  (0...u.size).map do |i|
    v = 0.0
    u.each_with_index do |uu, j|
      v += eval_A(j, i) * uu
    end
    v
  end
end

def eval_AtA_times_u(u)
  eval_At_times_u(eval_A_times_u(u))
end

def run(n)
  t = Time.now
  u = Array.new(n, 1.0)
  v = Array.new(n, 1.0)
  10.times do
    v = eval_AtA_times_u(u)
    u = eval_AtA_times_u(v)
  end
  vBv = vv = 0.0
  (0...n).each do |i|
    vBv += u[i] * v[i]
    vv += v[i] * v[i]
  end
  puts "#{"%.9f" % [(Math.sqrt(vBv / vv))]}"
  STDERR.puts "time(#{(Time.now - t).to_f})"
end

n = (ARGV[0] || 1000).to_i
times = (ARGV[1] || 1).to_i
STDERR.puts("started\t#{Process.pid}")
times.times { run(n) }