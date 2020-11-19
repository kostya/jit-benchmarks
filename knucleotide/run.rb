require File.join(File.dirname(__FILE__), "..", "tools", "common")

ENV['JB_STDIN'] = (ENV['JB_DEBUG'] ? "2.txt" : "1.txt")
ENV['JB_TIMEOUT'] = "70"

CMDS = {
	"" => BINS - %w{./bin_c} + %w{./bin_cpp},
	"knucleotide.rb" => RUBIES,
	"knucleotide.py" => PYTHONS,
	"knucleotide.lua" => LUAS,
	"knucleotide.js" => JAVASCRIPTS
}

run_cmds(CMDS, "")
