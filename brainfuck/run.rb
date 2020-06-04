require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? "numbers.b" : "bench.b")).to_s
ENV['JB_STDOUT'] = "1" unless ENV['JB_DEBUG']

CMDS = {
	"" => BINS - %w{./bin_c} + %w{./bin_cpp},
	"brainfuck.rb" => RUBIES,
	"brainfuck.py" => PYTHONS,
	# "brainfuck.lua" => LUAS,
	"brainfuck.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
