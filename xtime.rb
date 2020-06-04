#!/usr/bin/env ruby
def mem(pid); `ps p #{pid} -o rss`.split.last.to_i; end
name = "#{ARGV[0]}"
name += " #{ARGV[1]}" if ARGV[1].start_with?("--")

STDERR.puts("start(#{name})")
t0 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
pid = Process.spawn(*ARGV.to_a)
mm = 0

Thread.new do
  mm = mem(pid)
  while true
    sleep 0.3
    m = mem(pid)
    mm = m if m > mm
  end
end

Process.waitall
t1 = Process.clock_gettime(Process::CLOCK_MONOTONIC)
STDERR.puts "end(#{name}) ftime(%.6fs) mem(%.1fMb)" % [t1 - t0, mm / 1024.0]
