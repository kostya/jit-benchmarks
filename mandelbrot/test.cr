ITER  =  50
LIMIT = 2.0

def run(n)
  t = Time.local

  w = h = n
  STDOUT.print("P4\n#{w} #{h}\n")

  bit_num = 0
  byte_acc = 0_u8

  h.times do |y|
    w.times do |x|
      zr = zi = tr = ti = 0.0
      cr = (2.0 * x / w - 1.5)
      ci = (2.0 * y / h - 1.0)

      i = 0
      while (i < ITER) && (tr + ti <= LIMIT * LIMIT)
        zi = 2.0 * zr * zi + ci
        zr = tr - ti + cr
        tr = zr * zr
        ti = zi * zi
        i += 1
      end

      byte_acc <<= 1
      byte_acc |= 0x01 if tr + ti <= LIMIT * LIMIT
      bit_num += 1

      if bit_num == 8
        STDOUT.write_byte byte_acc
        byte_acc = 0_u8
        bit_num = 0
      elsif x == w - 1
        byte_acc <<= 8 - w % 8
        STDOUT.write_byte byte_acc
        byte_acc = 0_u8
        bit_num = 0
      end
    end
  end

  STDERR.puts "time(#{(Time.local - t).to_f})"
end

n = (ARGV[0]? || 100).to_i
t = (ARGV[1]? || 1).to_i
STDERR.puts "started\t#{Process.pid}"
t.times { run(n) }
