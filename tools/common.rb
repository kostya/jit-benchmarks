ENV['JB_STDOUT'] = nil if ENV['JB_DEBUG']

JB_OUTPUT = if ENV['JB_OUTPUT_FILE']
    File.open(ENV['JB_OUTPUT_FILE'], "a")
  else
    STDOUT
  end

def output(str)
  JB_OUTPUT.puts str
end

begin
  require "terminal-table"
rescue LoadError
  output "Require to install: gem install terminal-table"
  exit 1
end

def test_name
  Dir.pwd.split("/").last.capitalize
end

NAMES = {
  "./bin_cr" => %w{Crystal},
  "./bin_c" => %w{C gcc},
  "./bin_cpp" => %w{C++ g++},
  "./bin_nuitka" => %w{Python3 Nuitka}, 
  "ruby" => %w{Ruby},
  "ruby --jit" => %W{Ruby JIT},
  "topaz" => %w{Ruby Topaz},
  "opal" => "Opal",
  "rbx" => %w{Ruby rbx},
  "jruby" => %w{Ruby JRuby},
  "truffleruby" => %w{Ruby GraalVM},
  "truffleruby --jvm" => %w{Ruby GraalVM_JVM},
  "graalpython" => %w{Python3 GraalVM},
  "graalpython --jvm" => %w{Python3 GraalVM_JVM},
  "python2.7" => %w{Python2},
  "python3.9" => %w{Python3},
  "pypy2" => %w{Python2 Pypy},
  "pypy3" => %w{Python3 Pypy},
  "./bin_cython3" => %w{Python3 Cython},
  "lua" => %w{Lua},
  "luajit" => %w{Lua JIT},
  "node" => %w{Javascript Node},
  "graalnode" => %w{Javascript GraalVM},
  "graalnode --jvm" => %w{Javascript GraalVM_JVM},
  "java" => %w{Java OpenJDK},
  "jython" => %w{Python2 Jython},
  "ruby3" => %w{Ruby3},
  "ruby3 --jit" => %W{Ruby3 JIT},
}

BINS = %w{./bin_c ./bin_cr ./bin_cython3 ./bin_nuitka}
RUBIES = ["ruby", "topaz", "jruby", "truffleruby", ["ruby", "--jit"], ["truffleruby", "--jvm"], "rbx", "ruby3", ["ruby3", "--jit"]]
LUAS = ["lua", "luajit"]
PYTHONS = ["python2.7", "python3.9", "pypy2", "pypy3", "graalpython", ["graalpython", "--jvm"], "jython"]
JAVASCRIPTS = ["node", "graalnode", ["graalnode", "--jvm"]]

def name_to_path(name)
  name.gsub(%r{[\./ \-]}i, "")
end

def cute_name(name)
  Array(NAMES[name] || name)
end

def cute_name_s(name)
  cute_name(name).join(' ')
end

def timeout # in seconds
  (ENV["JB_TIMEOUT"] || 300).to_i
end

class MemoryProfile
  def initialize(pid)
    @pid = pid
    @stopped = false
    @m = 0
    start
  end

  def stop!
    @stopped = true
  end

  def mem
    @m
  end

  def check; `ps p #{@pid} -o rss`.split.last.to_i; end

  def start
    Thread.new do
      while true
        sleep 0.05
        m = check
        @m = m if m > @m
        break if @stopped
      end
    end
  end
end

class Run
  def initialize(args)
    args.flatten!   
    @name = args[0]
    @name += " #{args[1]}" if args[1].start_with?("--")
    @exitstatus = 0

    @current_time = 0
    @args = args.map(&:to_s).reject(&:empty?)
    @start = stamp    
    @r, @w = IO.pipe
    out = (debug? ? [tmp_path, "w"] : "/dev/null")
    out_name = " > #{Array(out).first}"
    if ENV['JB_STDOUT']
      out = STDOUT 
      out_name = nil
    end
    _in = ENV['JB_STDIN']
    output "#{_in ? "cat #{_in} | " : nil}#{@args.join(' ')}#{out_name}"
    h = {:out => out, :err => @w, :chdir => Dir.pwd}
    if _in = ENV['JB_STDIN']
      h[:in] = _in
    end
    @pid = Process.spawn(*@args, h)
    @mp = MemoryProfile.new(@pid)
    wait

    @verified = false
  end

  def tmp_path
    name_to_path(@name) + ".tmp"
  end

  def verified
    @verified
  end

  def verified!
    @verified = true
  end

  def stamp
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def wait
    monitor_timeout!
    Process.wait(@pid)
    @exitstatus = $?.exitstatus
    @w.close
    parse_time
    @mp.stop!
    @end = stamp
    output " - #{stat.inspect}"
  end

  def monitor_timeout!
    Thread.new do
      sleep timeout
      unless @end
        begin
          Process.kill("QUIT", @pid)
          sleep 0.5
          Process.kill("TERM", @pid)
          sleep 0.5
          Process.kill("KILL", @pid)
        rescue
        end

        @timeouted = true
      end
    end
  end

  def parse_time
    out = @r.read
    if out =~ %r{time\((.*?)\)}i
      @current_time = $1.to_f
    end
  end

  def name
    @name
  end

  def memory
    @mp.mem
  end

  def time
    @end - @start
  end

  def current_time
    if @timeouted || bad_exit?
      100000
    else
      @current_time
    end
  end

  def bad_exit?
    @exitstatus != 0
  end

  def timeouted?
    @timeouted
  end

  def stat
    [memory, time, current_time]
  end

  def inspect
    "#{@name} - #{stat.inspect}"
  end
end

def generate_output(results)

  rows = []

  h = results.sort_by { |k, v| v.current_time }
  h.each do |(name, r)|
    row = []

    n = cute_name(r.name)

    lang = n[0]

    if debug? && !r.verified
      lang = "*" + lang
    end

    row << lang
    row << n[1]

    if r.timeouted?
      row << "> #{timeout}"
      row << "> #{timeout}"
    elsif r.bad_exit?
      row << "crashed"
      row << "crashed"
    else
      row << "%.2f" % r.current_time
      row << "%.2f" % r.time
    end
    row << "%.1f" % (r.memory / 1024.0)

    rows << row
  end

  style = { :border_top => false, :border_bottom => false, :border_i => "|" }
  table = Terminal::Table.new :headings => ['Language', 'Interpreter', 'Time, s', 'Script Time, s', 'Memory, Mb'], :rows => rows, :style => style
  output "## #{test_name}"
  output table
end

def run_cmds(cmds, args)
  output(">======================== #{test_name} =========================")
  output "start debug:#{!!ENV['JB_DEBUG']}, args: #{args.inspect}"

  if debug?
    clean_tmp
  end

  results = {}

  exclude_cmds = (ENV['JB_EXCLUDE'] || "").split(",").map(&:strip)
  include_cmds = (ENV['JB_INCLUDE'] || "").split(",").map(&:strip)

  exclude_exts = (ENV['JB_EXCLUDE_EXT'] || "").split(",").map(&:strip)
  include_exts = (ENV['JB_INCLUDE_EXT'] || "").split(",").map(&:strip)

  cmds.each do |k, v|
    if !include_exts.empty?
      ext = k.split(".").last
      next unless include_exts.include?(ext)
    end

    if !exclude_exts.empty?
      ext = k.split(".").last
      next if exclude_exts.include?(ext)
    end

    v.each do |cmd|
      next if exclude_cmds.include?(Array(cmd).join)

      if !include_cmds.empty?
        if include_cmds.include?(cmd)
          results[cmd] = Run.new([cmd, k, args])
        end
      else
        results[cmd] = Run.new([cmd, k, args])
      end
    end
  end

  if debug?
    verify(results)
  end

  output ""
  output ""
  generate_output(results)
  output("<-------------------------------------------------------------")
end

def verify(results)
  e = results["./bin_c"]
  e = results["./bin_cr"] unless e
  e = results["./bin_cpp"] unless e

  etalon = File.read(e.tmp_path)
  e.verified!

  results.each do |k, v|
    f = File.read(v.tmp_path)
    if f == etalon
      v.verified!
    end
  end

  unless ENV['JB_SAVE_TMP']
    clean_tmp
  end
rescue => ex
  p ex
end

def clean_tmp
  Dir.glob("./*.tmp").each { |name| File.delete(name) rescue nil }
end

def debug?
  ENV['JB_DEBUG']
end
