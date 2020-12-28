require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 5 : 10)).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]

ENV['JB_STDOUT'] = "1" unless ENV['JB_DEBUG']
ENV['JB_TIMEOUT'] = "60"

CMDS = {
	"" => BINS,
	"fannkuchredux.rb" => RUBIES,
	"fannkuchredux.py" => PYTHONS,
	"fannkuchredux.lua" => LUAS,
	"fannkuchredux.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
