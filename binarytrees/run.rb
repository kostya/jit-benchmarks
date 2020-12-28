require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 9 : 17)).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 3 : 5)).to_s]
ENV["JB_TIMEOUT"] = "100"

CMDS = {
	"" => BINS + %w{cpp},
	"binarytrees.rb" => RUBIES,
	"binarytrees.py" => PYTHONS,
	"binarytrees.lua" => LUAS,
	"binarytrees.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
