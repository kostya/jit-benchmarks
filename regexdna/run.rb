require File.join(File.dirname(__FILE__), "..", "tools", "common")

ENV['JB_STDIN'] = (ENV['JB_DEBUG'] ? "2.txt" : "1.txt")
ENV['JB_TIMEOUT'] = "60"

CMDS = {
	"" => BINS,
	"regexdna.rb" => RUBIES,
	"regexdna.py" => PYTHONS,
	"regexdna.lua" => LUAS,
	"regexdna.js" => JAVASCRIPTS
}

run_cmds(CMDS, "")
