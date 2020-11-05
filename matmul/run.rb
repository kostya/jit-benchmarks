require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 100 : 1200)).to_s

CMDS = {
	"" => BINS,
	"matmul.rb" => RUBIES,
	"matmul.py" => PYTHONS,
	"matmul.lua" => LUAS,
	"matmul.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
