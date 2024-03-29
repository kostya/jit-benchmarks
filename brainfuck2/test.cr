module Op
  record Inc, val : Int32
  record Move, val : Int32
  record Print
  alias T = Inc | Move | Print | Array(Op::T)
end

class Tape
  def initialize
    @tape = [0_u8]
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
    while @pos >= @tape.size
      @tape << 0
    end
  end
end

class Program
  @ops : Array(Op::T)

  def initialize(code : String)
    @ops = parse(code.each_char)
  end

  def run
    _run @ops, Tape.new
  end

  private def _run(program, tape)
    program.each do |op|
      case op
      when Op::Inc
        tape.inc(op.val)
      when Op::Move
        tape.move(op.val)
      when Array(Op::T)
        while tape.get != 0
          _run(op, tape)
        end
      when Op::Print
        print(tape.get.chr)
      else
      end
    end
  end

  private def parse(iterator)
    res = [] of Op::T
    iterator.each do |c|
      op = case c
           when '+'; Op::Inc.new(1)
           when '-'; Op::Inc.new(-1)
           when '>'; Op::Move.new(1)
           when '<'; Op::Move.new(-1)
           when '.'; Op::Print.new
           when '['; parse(iterator)
           when ']'; break
           else
           end
      res << op if op
    end
    res
  end
end

def run(text)
  t = Time.local
  Program.new(text).run
  STDERR.puts "time(#{(Time.local - t).to_f})"
end

text = File.read(ARGV[0])
t = (ARGV[1]? || 1).to_i
STDERR.puts "started\t#{Process.pid}"
t.times { run(text) }
