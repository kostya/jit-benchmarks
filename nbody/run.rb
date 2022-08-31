require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 10000 : 9000000)).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]
ENV['JB_TIMEOUT'] = "80"

CMDS = {
	"" => BINS,
	"nbody.rb" => RUBIES,
	"nbody.py" => PYTHONS,
	"nbody.lua" => LUAS,
	"nbody.js" => JAVASCRIPTS,
  "nbody.php" => PHPS
}

run_cmds(CMDS, N)
