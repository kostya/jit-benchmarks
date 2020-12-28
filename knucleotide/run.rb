require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = [(ARGV[1] || (ENV['JB_DEBUG'] ? 2 : 5)).to_s]
ENV['JB_STDIN'] = (ENV['JB_DEBUG'] ? "2.txt" : "1.txt")
ENV['JB_TIMEOUT'] = "60"

CMDS = {
	"" => BINS - %w{c} + %w{cpp},
	"knucleotide.rb" => RUBIES,
	"knucleotide.py" => PYTHONS,
	"knucleotide.lua" => LUAS,
	"knucleotide.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
