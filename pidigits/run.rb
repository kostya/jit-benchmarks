require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 1000 : 20000)).to_s
ENV['JB_TIMEOUT'] = "60"

CMDS = {
	"" => BINS,
	"pidigits.rb" => RUBIES,
	"pidigits.py" => PYTHONS - ["graalpython", ["graalpython", "--jvm"]],
	# "pidigits.lua" => LUAS,
	"pidigits.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
