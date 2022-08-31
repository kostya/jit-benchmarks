require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 10000 : 5000000)).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]
ENV['JB_TIMEOUT'] = "80"

CMDS = {
	"" => BINS,
	"fasta.rb" => RUBIES,
	"fasta.py" => PYTHONS - %w{python2 pypy2 jython},
	"fasta2.py" => %w{python2 pypy2 jython},
	"fasta.lua" => LUAS,
	"fasta.js" => JAVASCRIPTS,
  "fasta.php" => PHPS
}

run_cmds(CMDS, N)
