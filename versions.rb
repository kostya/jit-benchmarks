
VERSIONS = <<-V.split("\n")
python2.7 --version 2>&1 | head -n 1
python3.9 --version | head -n 1
crystal --version | head -n 1
gcc --version | head -n 1
g++ --version | head -n 1
lua -v
luajit -v
echo "Nodejs $(node --version)"
ruby -v
topaz -v
jruby -v
cython3 --version 2>&1
truffleruby --version
truffleruby --jvm --version
echo "$(pypy2 --version 2>&1 | head -n 1) $(pypy2 --version 2>&1 | tail -n 1)"
echo "$(pypy3 --version 2>&1 | head -n 1) $(pypy3 --version 2>&1 | tail -n 1)"
java -version 2>&1 | head -n 1
graalpython --version
graalpython --jvm --version
echo "GraalNode $(graalnode --version)"
jython --version 2>&1
echo "Nuitka $(nuitka --version | head -n 1)"
ruby3 -v
rbx -v
V

puts "## Versions: "
VERSIONS.each do |v|
    cmd = v.strip
    next if cmd.empty?
	r = `#{cmd}`.strip
	puts "* `#{r}`"
end
