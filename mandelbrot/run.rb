require File.join(File.dirname(__FILE__), "..", "tools", "common")

N = (ARGV[0] || (ENV['JB_DEBUG'] ? 100 : 4000)).to_s
ENV['JB_TIMEOUT'] = "70"

CMDS = {
	"" => BINS,
	"mandelbrot.rb" => RUBIES,
	"mandelbrot.py" => PYTHONS,
	"mandelbrot.lua" => LUAS,
	"mandelbrot.js" => JAVASCRIPTS
}

run_cmds(CMDS, N)
