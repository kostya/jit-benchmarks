
class Op
  attr_accessor :op, :val
  def initialize(op, val)
    @op = op
    @val = val
  end
end

class Tape
  def initialize
    @tape = [0]
    @pos = 0
  end

  def get
    @tape[@pos]
  end

  def inc(x)
    @tape[@pos] += x
  end

  def move(x)
    @pos += x
    while (@pos >= @tape.size)
      @tape << 0
    end
  end
end

class Program
  def initialize(code)
    @ops = parse code.chars.each
  end

  def run
    _run @ops, Tape.new
  end

private

  def _run(program, tape)
    program.each do |op|
      case op.op
        when 0; tape.inc(op.val)
        when 1; tape.move(op.val)
        when 3; _run(op.val, tape) while tape.get != 0
        when 2; print(tape.get.chr)
      end
    end
  end

  def parse(iterator)
    res = []
    while c = iterator.next rescue nil
      op = case c
           when '+'; Op.new(0, 1)
           when '-'; Op.new(0, -1)
           when '>'; Op.new(1, 1)
           when '<'; Op.new(1, -1)
           when '.'; Op.new(2, 0)
           when '['; Op.new(3, parse(iterator))
           when ']'; break
           end
      res << op if op
    end
    res
  end
end

def run(text)
  t = Time.now
  Program.new(text).run
  STDERR.puts("time(#{Time.now - t})")
end

text = IO.read(ARGV[0])
times = (ARGV[1] || 1).to_i
STDERR.puts("started")
times.times { run(text) }
