require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? "numbers.b" : "bench.b")).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 2)).to_s]
ENV['JB_STDOUT'] = "1" unless ENV['JB_DEBUG']
ENV['JB_TIMEOUT'] = "250"

CMDS = {
	"" => BINS,
	"bf.rb" => RUBIES,
	"bf.py" => PYTHONS,
	"bf.lua" => LUAS,
	"bf.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
