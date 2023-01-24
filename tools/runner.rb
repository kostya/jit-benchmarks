require File.join(File.dirname(__FILE__), "memory_profile")
require "fileutils"

class Runner
  TS = Struct.new(:ram, :timestamp, :external_duration)

  attr_reader :timeouted, :start_ts, :started, :finished, :exitstatus, :cmd, :results_ts

  def initialize(container:, cmd:, local_chdir: nil, remote_chdir: nil, stdout: :out, stderr: :out, timeout: nil, stdin: nil)
    @container = container
    @cmd = cmd
    @stdout = stdout # :skip, :out, :text
    @stderr = stderr # :measure, :out, :text, :skip
    @timeout = timeout
    @local_chdir = local_chdir
    @remote_chdir = remote_chdir
    @stdin = stdin

    @timeouted = false
    @started = false
    @finished = false
    @crashed = false
    @exitstatus = -1

    @pid = nil
    @monitor_pid = nil

    @out_read_io, @out_write_io = nil, nil
    @err_read_io, @err_write_io = nil, nil

    @stdout_content = ""
    @stderr_content = ""

    # timestamps in order
    @run_timestamp = nil
    @finish_timestamp = nil
    @start_ts = nil
    @results_ts = []

    @threads = []
  end

  def run
    start
    wait

    @threads.each { |t| t.join(10) }

    if @exitstatus != 0 && ENV['DC_DEBUG'] != '1'
      puts stdout_content if @stdout == :text
      puts stderr_content if @stderr == :text || @stderr == :measure
    end

    if ENV['DC_DEBUG'] == '1'
      STDERR.puts "--------- exit status #{@exitstatus}"
      STDERR.puts "--------- stdout"
      STDERR.puts stdout_content if stdout_content != ""
      STDERR.puts "--------- stderr"
      STDERR.puts stderr_content if stderr_content != ""
      STDERR.puts "------------"
    end    

    self
  rescue => ex
    crashed = true
    raise ex
  ensure
    # @out_read_io.close if @out_read_io    
    # @err_read_io.close if @err_read_io    

    @finish_timestamp = timestamp
    @finished = true    
  end

  def stdout_content
    @stdout_content
  end

  def stderr_content
    @stderr_content
  end

  def status
    if @finished && !@crashed && @started && !@timeouted && @exitstatus == 0
      "ok"
    elsif @timeouted
      "timeout"
    elsif @exitstatus != 0
      "fail(status=#{@exitstatus})"
    else
      "fail"
    end    
  end

  def full_time
    @finish_timestamp - @run_timestamp
  rescue 
  end

  def start_time
    @start_ts.timestamp - @run_timestamp
  rescue 
  end

  def execute_time
    if @start_ts
      @finish_timestamp - @start_ts.timestamp
    else
      full_time
    end
  end

  def start_ram
    @start_ts ? @start_ts.ram : nil
  end

  def max_run_ram_change
    max = nil
    prev = @start_ts || results_ts.shift
    results_ts.each do |r|
      mem = r.ram - prev.ram
      max = mem if !max || mem > max
      prev = r
    end
    max
  end

  def max_ram
    @memory_profile ? @memory_profile.max : nil
  end

  def short_stats
    {"time" => execute_time, "ram" => max_ram}
  end

  def stats
    durations = results_ts.map(&:external_duration)
    {
      "status" => status,
      "full_time" => full_time,
      "start_time" => start_time,
      "runs" => results_ts.size,
      "min_run_time" => durations.min,
      "max_run_time" => durations.max,
      "start_ram" => start_ram,
      "max_ram" => max_ram,
      "max_run_ram_diff" => max_run_ram_change
    }
  end

private

  def timestamp
    Process.clock_gettime(Process::CLOCK_MONOTONIC)
  end

  def start
    @started = true
    @run_timestamp = timestamp

    cmd = ["docker", "compose", "exec", "-T"]

    if @remote_chdir
      unless @remote_chdir.start_with?('/')
        FileUtils.mkdir_p(@remote_chdir)
        @remote_chdir = "/src/#{@remote_chdir}"
      end
      cmd += ["-w", @remote_chdir]
    end

    cmd += [@container, "bash", "-c"]

    bash_cmd = Array(@cmd).join(' ')
    bash_cmd = "cat #{@stdin} | #{bash_cmd}" if @stdin

    out = case @stdout
    when :skip
      "/dev/null"
    when :out
      STDOUT
    when :text
      @out_read_io, @out_write_io = IO.pipe
      @threads << capture_io!(@out_read_io) do |msg|
        @stdout_content += msg
      end
      @out_write_io
    end

    err = case @stderr
    when :skip
      "/dev/null"
    when :out
      STDOUT
    when :text
      @err_read_io, @err_write_io = IO.pipe
      @threads << capture_io!(@err_read_io) do |msg|
        @stderr_content += msg
      end
      @err_write_io      
    when :measure
      @err_read_io, @err_write_io = IO.pipe
      @err_write_io
    end    

    h = {:out => out, :err => err}

    if ENV['DC_DEBUG'] == '1'
      puts
      puts "`#{cmd.join ' '} '#{bash_cmd}'`"
    end

    @pid = Process.spawn(*cmd, bash_cmd, h)
    @err_write_io.close if @err_write_io
    @out_write_io.close if @out_write_io
  end

  def wait    
    monitor_timeout! if @timeout
    record_timings! if @stderr == :measure
    Process.wait(@pid)
    @exitstatus = $?.exitstatus
    @memory_profile.stop! if @memory_profile
  end

  def monitor_timeout!
    Thread.new do
      sleep @timeout
      if !@finished
        @timeouted = true
        system("docker compose restart -t0 #{@container} 2>/dev/null")
      end
    end
  end

  def capture_io!(io)
    thread = Thread.new do
      while true
        begin
          if IO.select([io])
            v = io.read_nonblock(1024)
            yield v
          end
        rescue EOFError
          io.close
          break
        end
      end
    end

    thread
  end

  def record_timings!
    @threads << capture_io!(@err_read_io) do |msg|
      @stderr_content += msg
      if msg =~ /started\t([\d]+)/
        v = $1
        @monitor_pid = v.to_i
        @memory_profile = MemoryProfile.new(@monitor_pid, @container)
        puts "started, update pid from #{@pid} to #{@monitor_pid}" if ENV['DC_DEBUG'] == '1'
        @start_ts = TS.new(@memory_profile.current_or_last, timestamp, 0.0)
      elsif msg =~ %r{time\((.*?)\)}i
        unless @memory_profile
          puts "Warning, there was no started command".colorize(:yellow)
        else
          ts = TS.new(@memory_profile.current_or_last, timestamp, $1.to_f)
          @results_ts << ts
        end
      end      
    end
  end  
end
