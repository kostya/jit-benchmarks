class Language < Struct.new(:name, :container, :print_name, :print_name2, :ext, :build_cmd, :run_cmd, :version_cmd, :skip_arch, :parse_version, keyword_init: true)
  def out(source)
    "#{source.split('.')[0]}_#{name}"
  end
end

GCC_FLAGS = "-O3 -march=native -fomit-frame-pointer -funroll-loops -Wno-unused-result"

LANGUAGES_LIST = [
  Language.new(
    name: "crystal",
    container: "crystal",
    print_name: "Crystal",
    print_name2: "",
    ext: "cr",
    build_cmd: ->(source, out, flags) { "crystal build #{source} --release -o #{out} #{flags}" },
    run_cmd: ->(source, out) { "./#{out}" },
    version_cmd: -> { "crystal --version" },
    skip_arch: %w{aarch64},
    parse_version: ->(v) { v =~ /Crystal ([^ ]+) /; $1 }
  ),

  Language.new(
    name: "c",
    container: "base",
    print_name: "C",
    print_name2: "",
    ext: "c",
    build_cmd: ->(source, out, flags) { "gcc #{GCC_FLAGS} -Wno-implicit-function-declaration -o #{out} #{source} #{flags}" },
    run_cmd: ->(source, out) { "./#{out}" },
    version_cmd: -> { "gcc -dumpfullversion" }
  ),

  Language.new(
    name: "cpp",
    container: "base",
    print_name: "C++",
    print_name2: "",
    ext: "cpp",
    build_cmd: ->(source, out, flags) { "g++ #{GCC_FLAGS} -std=c++11 -o #{out} #{source} #{flags}" },
    run_cmd: ->(source, out) { "./#{out}" }
  ),

  Language.new(
    name: "topaz",
    container: "topaz",
    print_name: "Ruby2",
    print_name2: "Topaz",
    ext: "rb",
    run_cmd: ->(source, out) { "topaz #{source}" },
    version_cmd: -> { "echo 'https://github.com/kostya/topaz'" }
  ),

  Language.new(
    name: "lua",
    container: "lua",
    print_name: "Lua",
    print_name2: "",
    ext: "lua",
    run_cmd: ->(source, out) { "lua #{source}" },
    version_cmd: -> { "lua -v" },
    parse_version: ->(v) { v.split[1] }
  ),

  Language.new(
    name: "luajit",
    container: "luajit",
    print_name: "Lua",
    print_name2: "JIT",
    ext: "lua",
    run_cmd: ->(source, out) { "luajit #{source}" },
    version_cmd: -> { "luajit -v" },
    parse_version: ->(v) { v.split[1] }
  ),

  Language.new(
    name: "nodejs",
    container: "nodejs",
    print_name: "Javascript",
    print_name2: "Node",
    ext: "js",
    run_cmd: ->(source, out) { "node #{source}" },
    version_cmd: -> { 'node -e "console.log(process.version)"' },
    parse_version: ->(v) { v[1..-1] }
  ),

  Language.new(
    name: "graalnode",
    container: "graalnode",
    print_name: "Javascript",
    print_name2: "GraalVM",
    ext: "js",
    run_cmd: ->(source, out) { "graalnode #{source}" },
    version_cmd: -> { "echo $GRAALVM; graalnode --version" },
    parse_version: ->(v) { "#{v.split("\n")[0]} (node: #{v.split("\n")[1][1..-1]})" }
  ),

  Language.new(
    name: "graalnode_jvm",
    container: "graalnode",
    print_name: "Javascript",
    print_name2: "GraalVM_JVM",
    ext: "js",
    run_cmd: ->(source, out) { "graalnode --jvm #{source}" },
  ),

  Language.new(
    name: "php",
    container: "php8",
    print_name: "PHP",
    print_name2: "",
    ext: "php",
    run_cmd: ->(source, out) { "php -dmemory_limit=512M #{source}" },
    version_cmd: -> { 'php -r "echo phpversion();"' },
    parse_version: ->(v) { v.split('-')[0] }
  ),

  Language.new(
    name: "php_jit",
    container: "php8",
    print_name: "PHP",
    print_name2: "JIT",
    ext: "php",
    # best options by: https://stitcher.io/blog/php-8-jit-setup
    run_cmd: ->(source, out) { "php -dmemory_limit=512M -dzend_extension=opcache.so -dopcache.enable_cli=1 -dopcache.enable=1 -dopcache.jit_buffer_size=500M -dopcache.jit=1255 #{source}" },    
  ),

  Language.new(
    name: "ruby2",
    container: "ruby2",
    print_name: "Ruby2",
    print_name2: "",
    ext: "rb",
    run_cmd: ->(source, out) { "ruby #{source}" },    
    version_cmd: -> { %q{ruby -e 'puts "#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"'} }
  ),

  Language.new(
    name: "ruby2_jit",
    container: "ruby2",
    print_name: "Ruby2",
    print_name2: "JIT",
    ext: "rb",
    run_cmd: ->(source, out) { "ruby --jit #{source}" },    
  ),

  Language.new(
    name: "ruby3",
    container: "ruby3",
    print_name: "Ruby3",
    print_name2: "",
    ext: "rb",
    run_cmd: ->(source, out) { "ruby3 #{source}" },
    version_cmd: -> { %q{ruby3 -e 'puts "#{RUBY_VERSION}p#{RUBY_PATCHLEVEL}"'} }
  ),

  Language.new(
    name: "ruby3_jit",
    container: "ruby3",
    print_name: "Ruby3",
    print_name2: "JIT",
    ext: "rb",
    run_cmd: ->(source, out) { "ruby3 --jit #{source}" },
  ),

  Language.new(
    name: "rbx",
    container: "rbx",
    print_name: "Ruby2",
    print_name2: "Rbx",
    ext: "rb",
    run_cmd: ->(source, out) { "rbx #{source}" },
    version_cmd: -> { %q{rbx -e 'puts "#{RUBY_ENGINE_VERSION}"'} },
    skip_arch: %w{aarch64}
  ),

  Language.new(
    name: "jruby",
    container: "jruby",
    print_name: "Ruby2",
    print_name2: "JRuby",
    ext: "rb",
    run_cmd: ->(source, out) { "jruby #{source}" },
    version_cmd: -> { %q{jruby -e 'puts JRUBY_VERSION'} }
  ),

  Language.new(
    name: "jruby_opt",
    container: "jruby",
    print_name: "Ruby2",
    print_name2: "JRuby_InDy",
    ext: "rb",
    run_cmd: ->(source, out) { "jruby -Xcompile.invokedynamic=true -S #{source}" },
  ),

  Language.new(
    name: "truffleruby",
    container: "truffleruby",
    print_name: "Ruby2",
    print_name2: "GraalVM",
    ext: "rb",
    run_cmd: ->(source, out) { "truffleruby #{source}" },
    version_cmd: -> { "truffleruby --version" },
    parse_version: ->(v) { v =~ /truffleruby ([\d\.]+)/ ; v1 = $1; v =~ /like ruby ([\d\.]+)/; v2 = $1; "#{v1} (ruby: #{v2})" }
  ),

  Language.new(
    name: "truffleruby_jvm",
    container: "truffleruby",
    print_name: "Ruby2",
    print_name2: "GraalVM_JVM",
    ext: "rb",
    run_cmd: ->(source, out) { "truffleruby --jvm #{source}" },
  ),

  Language.new(
    name: "python2",
    container: "python2",
    print_name: "Python2",
    print_name2: "",
    ext: "py",
    run_cmd: ->(source, out) { "python2.7 #{source}" },
    version_cmd: -> { "python2.7 --version 2>&1" },
    parse_version: ->(v) { v.sub("Python ", '') }
  ),

  Language.new(
    name: "python3",
    container: "python3",
    print_name: "Python3",
    print_name2: "",
    ext: "py",
    run_cmd: ->(source, out) { "python3 #{source}" },
    version_cmd: -> { "python3 --version" },
    parse_version: ->(v) { v.sub("Python ", '') }
  ),

  Language.new(
    name: "pypy2",
    container: "pypy2",
    print_name: "Python2",
    print_name2: "PYPY",
    ext: "py",
    run_cmd: ->(source, out) { "pypy2 #{source}" },
    version_cmd: -> { 'pypy2 --version 2>&1' },
    parse_version: ->(v) { v =~ /PyPy ([\d\.]+)/; v1 = $1; v =~ /Python ([\d\.]+)/; v2 = $1; v =~ /GCC ([\d\.]+)/; v3 = $1; "#{v1} (python: #{v2}, gcc: #{v3})" }
  ),

  Language.new(
    name: "pypy3",
    container: "pypy3",
    print_name: "Python3",
    print_name2: "PYPY",
    ext: "py",
    run_cmd: ->(source, out) { "pypy3 #{source}" },
    version_cmd: -> { 'pypy3 --version 2>&1' },
    parse_version: ->(v) { v =~ /PyPy ([\d\.]+)/; v1 = $1; v =~ /Python ([\d\.]+)/; v2 = $1; v =~ /GCC ([\d\.]+)/; v3 = $1; "#{v1} (python: #{v2}, gcc: #{v3})" }
  ),

  Language.new(
    name: "graalpython",
    container: "graalpython",
    print_name: "Python3",
    print_name2: "GraalVM",
    ext: "py",
    run_cmd: ->(source, out) { "graalpython #{source}" },
    version_cmd: -> { 'graalpython --version' },
    parse_version: ->(v) { v =~ /Python ([\d\.]+)/; v1 = $1; v2 = v.split.last[0..-2]; "#{v2} (python: #{v1})" }
  ),

  Language.new(
    name: "graalpython_jvm",
    container: "graalpython",
    print_name: "Python3",
    print_name2: "GraalVM_JVM",
    ext: "py",
    run_cmd: ->(source, out) { "graalpython --jvm #{source}" },
  ),

  Language.new(
    name: "jython",
    container: "jython",
    print_name: "Python2",
    print_name2: "Jython",
    ext: "py",
    run_cmd: ->(source, out) { "jython #{source}" },
    version_cmd: -> { 'jython --version 2>&1' },
    parse_version: ->(v) { v.split(' ')[1] }
  ),

  Language.new(
    name: "nuitka",
    container: "nuitka",
    print_name: "Python3",
    print_name2: "Nuitka",
    ext: "py",
    build_cmd: ->(source, out, flags) { "python3 -m nuitka #{source} -o #{out} #{flags}" },
    run_cmd: ->(source, out) { "./#{out}" },
    version_cmd: -> { 'python3 -m nuitka --version 2>/dev/null' },
    parse_version: ->(v) { v1 = v.split("\n")[0]; v =~ /Python: ([\d\.]+)/; v2 = $1; v =~ /GCC ([\d\.]+)/; v3 = $1; "#{v1} (python: #{v2}, gcc: #{v3})" }
  ),

  Language.new(
    name: "cython",
    container: "cython3",
    print_name: "Python3",
    print_name2: "Cython",
    ext: "pyx",
    build_cmd: ->(source, out, flags) { "cython3 --embed #{source} -o /tmp/cython3.c; gcc #{GCC_FLAGS} -g -o #{out} /tmp/cython3.c -I/usr/include/python3.10/ -lpython3.10 #{flags}" },
    run_cmd: ->(source, out) { "./#{out}" },
    version_cmd: -> { 'cython3 --version 2>&1' },
    parse_version: ->(v) { v.split.last }
  ),

  Language.new(
    name: "mypyc",
    container: "mypy",
    print_name: "Python3",
    print_name2: "MYPYC",
    ext: "py",
    build_cmd: ->(source, out, flags) { %Q|mypyc #{source}; echo '#!/usr/bin/env bash' > #{out}; echo 'python3 -c "import test" "$@"' >> #{out}; chmod +x #{out}| },
    run_cmd: ->(source, out) { "./#{out}" },
    version_cmd: -> { 'mypyc --version' },
    parse_version: ->(v) { v.split[1] }
  ),

  # not used, just for print version
  Language.new(
    name: "java",
    container: "java",
    print_name: "Java",
    print_name2: "",
    ext: "java",
    version_cmd: -> { 'java --version' },
    parse_version: ->(v) { v.split("\n")[0].split(' ')[0..-2].join(' ') }
  ),
  
  Language.new(
    name: "codon",
    container: "codon",
    print_name: "Python3",
    print_name2: "Codon",
    ext: "py",
    version_cmd: -> { 'codon --version' },
    build_cmd: ->(source, out, flags) { %Q|codon build --release -o #{out} #{source}| },
    run_cmd: ->(source, out) { "./#{out}" },
  ),

]

LANGUAGES = {}
LANGUAGES_LIST.each { |l| LANGUAGES[l.name] = l }
