require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 100 : 700)).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]
ENV['JB_TIMEOUT'] = "80"

CMDS = {
	"" => BINS,
	"matmul.rb" => RUBIES,
	"matmul.py" => PYTHONS,
	"matmul.lua" => LUAS,
	"matmul.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
