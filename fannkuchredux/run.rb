require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 5 : 11)).to_s
ENV['JB_STDOUT'] = "1" unless ENV['JB_DEBUG']

CMDS = {
	"" => BINS,
	"fannkuchredux.rb" => RUBIES,
	"fannkuchredux.py" => PYTHONS,
	"fannkuchredux.lua" => LUAS,
	"fannkuchredux.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
