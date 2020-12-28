require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 1000 : 17000)).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]
ENV['JB_TIMEOUT'] = "70"

CMDS = {
	"" => BINS,
	"pidigits.rb" => RUBIES,
	"pidigits.py" => PYTHONS, # - ["graalpython", "graalpython_jvm"],
	# "pidigits.lua" => LUAS,
	"pidigits.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
