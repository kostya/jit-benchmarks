require "big"

def run(nn)
  start = Time.local

  i = 0
  k = 0
  ns = 0.to_big_i
  a = 0.to_big_i
  t = 0
  u = 0.to_big_i
  k1 = 1
  n = 1.to_big_i
  d = 1.to_big_i

  while true
    k += 1
    t = n << 1
    n *= k
    k1 += 2
    a = (a + t) * k1
    d *= k1
    if a >= n
      t, u = (n * 3 + a).divmod(d)
      u += n
      if d > u
        ns = ns * 10 + t
        i += 1
        if i % 10 == 0
          print "%010d\t:%d\n" % {ns.to_u64, i}
          ns = 0
        end
        break if i >= nn

        a = (a - (d * t)) * 10
        n *= 10
      end
    end
  end

  STDERR.puts("time(#{(Time.local - start).to_f})")
end

n = (ARGV[0]? || 100).to_i
t = (ARGV[1]? || 1).to_i
STDERR.puts "started\t#{Process.pid}"
t.times { run(n) }
