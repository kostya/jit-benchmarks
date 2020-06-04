require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 10000 : 10000000)).to_s

CMDS = {
	"" => BINS,
	"nbody.rb" => RUBIES,
	"nbody.py" => PYTHONS,
	"nbody.lua" => LUAS,
	"nbody.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
