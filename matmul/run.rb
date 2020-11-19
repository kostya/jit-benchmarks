require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 100 : 1100)).to_s
ENV['JB_TIMEOUT'] = "200"

CMDS = {
	"" => BINS,
	"matmul.rb" => RUBIES,
	"matmul.py" => PYTHONS,
	"matmul.lua" => LUAS,
	"matmul.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
