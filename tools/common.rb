ENV['JB_STDOUT'] = nil if ENV['JB_DEBUG']

JB_OUTPUT = if ENV['JB_OUTPUT_FILE']
    File.open(ENV['JB_OUTPUT_FILE'], "a")
  else
    STDOUT
  end

def output(str)
  JB_OUTPUT.puts str
  JB_OUTPUT.flush
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
  "crystal" => {name: "Crystal", name2: "", cmd: ["./bin_cr"], group: "crystal", native: true},

  "c" => {name: "C", name2: "gcc", cmd: ["./bin_c"], group: "c", native: true},
  "cpp" => {name: "C++", name2: "g++", cmd: ["./bin_cpp"], group: "c", native: true},  

  "ruby" => {name: "Ruby2.7", name2: "", cmd: ["ruby"], group: "ruby"},
  "ruby_jit" => {name: "Ruby2.7", name2: "JIT", cmd: ["ruby", "--jit"], group: "ruby"},
  "topaz" => {name: "Ruby", name2: "Topaz", cmd: ["topaz"], group: "ruby"},
  # "opal" => {name: "Ruby", name2: "Topaz", cmd: ["topaz"], group: "ruby"},
  "rbx" => {name: "Ruby", name2: "Rbx", cmd: ["rbx"], group: "ruby"},
  "jruby" => {name: "Ruby", name2: "JRuby", cmd: ["jruby"], group: "ruby"},
  "jruby_opt" => {name: "Ruby", name2: "JRuby_InDy", cmd: ["jruby", "-Xcompile.invokedynamic=true", "-S"], group: "ruby"},
  "truffleruby" => {name: "Ruby", name2: "GraalVM", cmd: ["truffleruby"], group: "ruby"},    
  "truffleruby_jvm" => {name: "Ruby", name2: "GraalVM_JVM", cmd: ["truffleruby", "--jvm"], group: "ruby"},
  "ruby3" => {name: "Ruby3", name2: "", cmd: ["ruby3"], group: "ruby"},
  "ruby3_jit" => {name: "Ruby3", name2: "JIT", cmd: ["ruby3", "--jit"], group: "ruby"},

  "nuitka" => {name: "Python3", name2: "Nuitka", cmd: ["./bin_nuitka"], group: "python", native: true},
  "graalpython" => {name: "Python3", name2: "GraalVM", cmd: ["graalpython"], group: "python"},
  "graalpython_jvm" => {name: "Python3", name2: "GraalVM_JVM", cmd: ["graalpython", "--jvm"], group: "python"},
  "python2" => {name: "Python2", name2: "", cmd: ["python2.7"], group: "python"},
  "python3" => {name: "Python3", name2: "", cmd: ["python3.9"], group: "python"},
  "pypy2" => {name: "Python2", name2: "Pypy", cmd: ["pypy2"], group: "python"},
  "pypy3" => {name: "Python3", name2: "Pypy", cmd: ["pypy3"], group: "python"},
  "cython" => {name: "Python3", name2: "Cython", cmd: ["./bin_cython3"], group: "python", native: true},
  "jython" => {name: "Python2", name2: "Jython", cmd: ["jython"], group: "python"},

  "lua" => {name: "Lua", name2: "", cmd: ["lua"], group: "lua"},
  "luajit" => {name: "Lua", name2: "JIT", cmd: ["luajit"], group: "lua"},

  "node" => {name: "Javascript", name2: "Node", cmd: ["node"], group: "js"},
  "graalnode" => {name: "Javascript", name2: "GraalVM", cmd: ["graalnode"], group: "js"},
  "graalnode_jvm" => {name: "Javascript", name2: "GraalVM_JVM", cmd: ["graalnode", "--jvm"], group: "js"},
}

BINS = %w{crystal c cython nuitka}
RUBIES = NAMES.select { |k, v| v[:group] == "ruby" && !v[:native] }.keys 
LUAS = %w{lua luajit}
PYTHONS = NAMES.select { |k, v| v[:group] == "python" && !v[:native] }.keys
JAVASCRIPTS = %w{node graalnode graalnode_jvm}

def name_to_path(name)
  name.gsub(%r{[\./ \-]}i, "")
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

  def current_or_max
    res = check
    if res == 0
      mem / 1024.0
    else
      res / 1024.0
    end
  end

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
  attr_reader :current_times, :h, :cmd_name, :current_mems, :current_times_orig

  def initialize(cmd_name, h, script_name, script_args)
    @cmd_name = cmd_name
    @script_name = script_name
    @script_args = script_args

    @h = h

    args = [h[:cmd], script_name, script_args]
    args.flatten!

    @exitstatus = 0

    @current_times = []
    @current_times_orig = []
    @current_mems = []

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
    @record_start_time = stamp
    @script_init_time = stamp
    @script_start_time = stamp
    @record_start_mem = 0

    @pid = Process.spawn(*@args, h)
    @mp = MemoryProfile.new(@pid)
    wait

    @verified = false
  end

  def tmp_path
    name_to_path(@cmd_name) + ".tmp"
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
    record_times!
    Process.wait(@pid)
    @exitstatus = $?.exitstatus
    @w.close
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

  def record_times!
    Thread.new do
      while true
        begin
          if IO.select([@r])
            msg = @r.read_nonblock(1024)
            if msg =~ /started/
              t = stamp
              @pre_start_time = (t - @record_start_time).to_f
              @record_start_time = t
              @script_start_time = t
              @record_start_mem = @mp.current_or_max
            end

            if msg =~ %r{time\((.*?)\)}i
              @current_times << $1.to_f

              t = stamp
              @current_times_orig << (t - @record_start_time).to_f
              @record_start_time = t
              @current_mems << @mp.current_or_max
            end
          end
        rescue EOFError
          break
        end
      end
    end
  end


  def name
    @cmd_name
  end

  def memory
    @mp.mem
  end

  def time
    @end - @start
  end

  def best_time
    if @current_times_orig.size > 0
      @current_times_orig.min
    else
      100000
    end
  end

  def bad_exit?
    @exitstatus != 0
  end

  def timeouted?
    @timeouted
  end

  def stat
    [memory, time, best_time, ]
  end

  def init_time
    (@script_start_time - @script_init_time).to_f
  end

  def inspect
    "#{@cmd_name} - #{stat.inspect}"
  end
end

def generate_output(results)

  rows = []

  h = results.sort_by { |k, v| v.best_time }
  runs_count = 0
  h.each do |(name, r)|
    row = []

    lang = r.h[:name]

    if debug? && !r.verified
      lang = "*" + lang
    end

    row << lang
    row << r.h[:name2]

    if r.current_times.size > 0
      row << "%.2f" % r.best_time

      if r.current_times_orig.size > runs_count
        runs_count = r.current_times_orig.size
      end

      row << "%.2f" % (r.current_times_orig.max)
      row << "%.1f" % (r.init_time)
    else
      if r.timeouted?
        row << "> #{timeout}"
        row << "> #{timeout}"
        row << "%.1f" % (r.init_time)
      elsif r.bad_exit?
        row << "crashed"
        row << "crashed"
        row << "crashed"
      end
    end

    row << "%.2f" % (r.memory / 1024.0)
    # row << r.current_mems.map { |ct| ct.to_i }.join(",")

    rows << row
  end

  style = { :border_top => false, :border_bottom => false, :border_i => "|" }
  table = Terminal::Table.new :headings => ['Language', 'Interpreter', 'Best T,s', 'Longest T,s', 'Start T,s', 'MaxMem, Mb'], :rows => rows, :style => style
  output "## #{test_name} (#{runs_count} runs)"
  output table
end

def run_cmds(cmds, args)
  full_test_start_at = Time.now
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

  exclude_groups = (ENV['JB_EXCLUDE_GROUP'] || "").split(",").map(&:strip)
  include_groups = (ENV['JB_INCLUDE_GROUP'] || "").split(",").map(&:strip)

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
      h = NAMES[cmd]
      unless h
        output "=" * 30
        output "Error: Unknown cmd_name: #{cmd.inspect}"
        output "=" * 30
        return
      end

      next if exclude_cmds.include?(cmd)
      next if exclude_groups.include?(h[:group])

      if !include_cmds.empty?
        next unless include_cmds.include?(cmd)
      end

      if !include_groups.empty?
        next unless include_groups.include?(h[:group])
      end

      results[cmd] = Run.new(cmd, h, k, args)
    end
  end

  if debug?
    verify(results)
  end

  output ""
  output ""
  generate_output(results)
  output("<-------------------------------------------------------------")
  output("%.4f" % [(Time.now - full_test_start_at).to_f])
  output ""
end

def verify(results)
  e = results["c"]
  e = results["cr"] unless e
  e = results["cpp"] unless e
  e = results.value.first unless e

  output "Etalon: #{e.cmd_name}"
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
