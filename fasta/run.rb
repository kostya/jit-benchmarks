require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 10000 : 15000000)).to_s

CMDS = {
	"" => BINS,
	"fasta.rb" => RUBIES,
	"fasta.py" => PYTHONS - %w{python2.7 pypy2 jython},
	"fasta2.py" => %w{python2.7 pypy2 jython},
	"fasta.lua" => LUAS,
	"fasta.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
