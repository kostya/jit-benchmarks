require File.join(File.dirname(__FILE__), "..", "tools", "common")

ENV['JB_STDIN'] = (ENV['JB_DEBUG'] ? "2.txt" : "1.txt")

CMDS = {
	"" => BINS,
	"revcomp.rb" => RUBIES,
	"revcomp.py" => PYTHONS - %w{python2.7 pypy jython},
	"revcomp2.py" => %w{python2.7 pypy jython},
	"revcomp.lua" => LUAS,
	"revcomp.js" => JAVASCRIPTS
}

run_cmds(CMDS, "")
