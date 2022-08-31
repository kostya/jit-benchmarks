require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[0] || (ENV['JB_DEBUG'] ? 100 : 1500)).to_s, (ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]
ENV['JB_TIMEOUT'] = "80"

CMDS = {
	"" => BINS,
	"spectralnorm.rb" => RUBIES,
	"spectralnorm.py" => PYTHONS,
	"spectralnorm.lua" => LUAS,
	"spectralnorm.js" => JAVASCRIPTS,
  "spectralnorm.php" => PHPS
}

run_cmds(CMDS, N)
