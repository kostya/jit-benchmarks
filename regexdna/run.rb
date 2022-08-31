require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]
ENV['JB_STDIN'] = (ENV['JB_DEBUG'] ? "2.txt" : "1.txt")
ENV['JB_TIMEOUT'] = "60"

CMDS = {
	"" => BINS,
	"regexdna.rb" => RUBIES,
	"regexdna.py" => PYTHONS,
	"regexdna.lua" => LUAS,
	"regexdna.js" => JAVASCRIPTS,
  "regexdna.php" => PHPS
}

run_cmds(CMDS, N)
