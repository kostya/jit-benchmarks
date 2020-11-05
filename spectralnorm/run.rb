require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 100 : 4000)).to_s

CMDS = {
	"" => BINS,
	"spectralnorm.rb" => RUBIES,
	"spectralnorm.py" => PYTHONS,
	"spectralnorm.lua" => LUAS,
	"spectralnorm.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
