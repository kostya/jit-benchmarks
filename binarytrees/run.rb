require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 10 : 18)).to_s

CMDS = {
	"" => BINS + ["./bin_cpp"],
	"binarytrees.rb" => RUBIES,
	"binarytrees.py" => PYTHONS,
	"binarytrees.lua" => LUAS,
	"binarytrees.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
