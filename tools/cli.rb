require "yaml"
require "date"
require File.join(File.dirname(__FILE__), "benchmarks")
require File.join(File.dirname(__FILE__), "languages")
require File.join(File.dirname(__FILE__), "runner")

begin
  require "colorize"
rescue LoadError
  puts "Please install colorize: gem install colorize"
  exit 1
end

begin
  require "terminal-table"
rescue LoadError
  puts "Please install terminal-table: gem install terminal-table"
  exit 1
end

class CLI
  ARCHS = %w{amd64 aarch64}
  COMPOSE_CONFIG_PATH = "./docker-compose.yml"
  COMPOSE_CONFIG = YAML.load_file(COMPOSE_CONFIG_PATH)

  def initialize
    @arch = ENV['DC_ARCH'] || if RUBY_PLATFORM.include?("x86_64")
      "amd64"
    elsif RUBY_PLATFORM.include?("arm64") || RUBY_PLATFORM.include?("aarch64")
      "aarch64"      
    end

    unless ARCHS.include?(@arch)
      raise "Unknown arch: #{@arch}, #{RUBY_PLATFORM}"
    end

    @round = COMPOSE_CONFIG["x-round"]
    @results = load_results(results_filename)
    @results_changed = false
    
    at_exit { save_results }
  end

  def new_round
    @round += 1
    @results = load_results(results_filename)
    @results_changed = false
    `sed -i -E "s/x-round: ([0-9]+)/x-round: #{@round}/" #{COMPOSE_CONFIG_PATH}`
  end

  def init(langs_str, force_rebuild = false)
    cmd = "docker compose build #{build_containers(langs_str).join(' ')} --build-arg arch=#{@arch} #{force_rebuild ? "--no-cache" : ""}"   
    if ENV['DC_DEBUG'] == '1'
      puts cmd
    end
    system("docker compose build #{build_containers(langs_str).join(' ')} --build-arg arch=#{@arch} #{force_rebuild ? "--no-cache" : ""}")
  end

  def up(langs_str)
    `docker compose up -d #{containers(langs_str).join(' ')}`
  end

  def versions(langs_str)
    langs = langs_from_str(langs_str)
    puts "## Versions: "
    langs.each do |lang_name|
      l = LANGUAGES[lang_name]
      if version_cmd = l.version_cmd
        r = Runner.new(container: l.container, cmd: version_cmd.call, stdout: :text, remote_chdir: "/tmp")
        r.run
        version = r.stdout_content.strip
        if l.parse_version
          version = l.parse_version.call(version)
        end
        set_result("versions", lang_name, version)
        puts "#{lang_name}: #{version}"
      end
    end
    puts
  end

  def down
    `docker compose down -t0`
  end

  def clean(benchmarks_str)
    benchmarks = benchmarks_from_str(benchmarks_str)
    benchmarks.each do |benchmark_name|
      puts "clean #{benchmark_name}"
      FileUtils.rm_rf("#{benchmark_name}/target")
    end
  end

  def build(benchmarks_str, langs_str)
    benchmarks = benchmarks_from_str(benchmarks_str)
    langs = langs_from_str(langs_str)

    benchmarks.each do |b|
      puts "Build [#{b}] ======================================================================".colorize(:green)
      build_benchmark_helpers(b)
      langs.each do |l|
        build_exact(b, l)
      end
    end
  end

  def run(benchmarks_str, langs_str)
    benchmarks = benchmarks_from_str(benchmarks_str)
    langs = langs_from_str(langs_str)

    benchmarks.each do |b|
      puts "Run [#{b}] ======================================================================".colorize(:green)
      langs.each do |l|
        run_exact(b, l)
      end
      save_results
    end  
  end

  def check(benchmarks_str, langs_str)
    benchmarks = benchmarks_from_str(benchmarks_str)
    langs = langs_from_str(langs_str)

    benchmarks.each do |b|
      puts "Check [#{b}] ======================================================================".colorize(:green)
      langs.each do |l|
        check_exact(b, l)
      end
    end  
  end

  def readme(benchmarks_str, langs_str)
    benchmarks = benchmarks_from_str(benchmarks_str)

    puts "## Update: #{@results["date"]} (round #{@round})"
    puts

    benchmarks.each do |benchmark_name|      
      style = { :border_top => false, :border_bottom => false, :border_i => "|" }
      table = Terminal::Table.new :headings => ['Language', 'Interpreter', 'Best T,s', 'Runs', 'Compile T,s', 'MaxMem, Mb'], :rows => get_readme_rows(benchmark_name, langs_str), :style => style
      puts "## #{benchmark_name}"
      puts table
      puts
      puts
    end

    style = { :border_top => false, :border_bottom => false, :border_i => "|" }
    langs = langs_from_str(langs_str)
    vers = (@results['versions'] || {}).select { |k, v| langs.include?(k) }
    table = Terminal::Table.new :headings => ['Language', 'Version'], :rows => vers, :style => style
    puts "## Versions"
    puts table
    puts
    puts
  end

  def round(benchmarks_str, langs_str)
    new_round
    init(langs_str)
    up(langs_str)
    versions(langs_str)    
    build(benchmarks_str, langs_str)
    check(benchmarks_str, langs_str)
    run(benchmarks_str, langs_str)
    down
    readme(benchmarks_str, langs_str)
  end

  def shell(langs_str)
    lang = langs_from_str(langs_str)[0]
    container = LANGUAGES[lang][:container]

    system("docker compose run #{container}")
  end

private
  def containers_from_str(str)
    res = []
    str = "all" unless str
    str.to_s.split(",").each do |name|
      name = name[0..-2] if name.end_with?('/')
      if name == "all" || name == "" || name == "-"
        containers = LANGUAGES.map { |_, l| l.container }
        containers.each do |c|
          if COMPOSE_CONFIG["services"][c]
            res << c
          end
        end
      else
        finded = false
        if COMPOSE_CONFIG["services"].has_key?(name)
          finded = true
          res << name 
        else
          COMPOSE_CONFIG["services"].each_key do |key|
            if key.start_with?(name)              
              finded = true
              res << key 
            end
          end
        end
        unless finded
          puts "Container: #{name.colorize(:red)} Not found! Available names: (#{COMPOSE_CONFIG['services'].keys.join(', ')})"
          exit 1
        end        
      end
    end
    res.reject! { |ln| l = LANGUAGES[ln]; l ? (l.skip_arch || []).include?(@arch) : nil }
    res.uniq.sort
  end

  def build_containers(langs_str)
    field = "depends_on"
    containers = containers_from_str(langs_str)
    deps = []
    q = []
    containers.each do |container|
      q << container
    end
    while x = q.shift
      deps << x
      if y = COMPOSE_CONFIG["services"][x][field]
        y.each do |c|        
          q << c
        end
      end
    end
    deps.uniq!
    sorted = COMPOSE_CONFIG["services"].sort { |(k1, v1), (k2, v2)| (v2[field] || []).include?(k1) ? -1 : ((v1[field] || []).include?(k2) ? 1 : 0) }.map(&:first)
    sorted.select { |s| deps.include?(s) }   
  end

  def benchmarks_from_str(str)
    res = []
    str = "all" unless str
    str.to_s.split(",").each do |name|
      name = name[0..-2] if name.end_with?('/')
      if name == "all" || name == "" || name == "-"
        res += BENCHMARKS.keys
      else
        finded = false
        if BENCHMARKS.has_key?(name)
          finded = true
          res << name 
        else
          BENCHMARKS.each_key do |key|
            if key.start_with?(name)
              finded = true
              res << key 
            end
          end
        end
        unless finded
          puts "Benchmark: #{name.colorize(:red)} Not found! Available names: (#{BENCHMARKS.keys.join(', ')})"
          exit 1
        end        
      end
    end
    res.uniq.sort
  end

  def langs_from_str(str)
    res = []
    str = "all" unless str
    str.to_s.split(",").each do |name|
      name = name[0..-2] if name.end_with?('/')
      if name == "all" || name == "" || name == "-"
        res += LANGUAGES.keys
      else
        finded = false
        if LANGUAGES.has_key?(name)
          finded = true
          res << name 
        else
          LANGUAGES.each_key do |key| 
            if key.start_with?(name)
              res << key 
              finded = true
            end
          end
        end
        # try find by extension
        LANGUAGES.each do |_, l| 
          if l.ext == name
            res << l.name
            finded = true
          end
        end
        unless finded
          puts "Language: #{name.colorize(:red)} Not found! Available names: (#{LANGUAGES.keys.join(', ')})"
          exit 1
        end
      end
    end
    res.reject! { |l| (LANGUAGES[l].skip_arch || []).include?(@arch) }
    res.uniq.sort
  end

  def containers(langs_str)
    langs = langs_from_str(langs_str)
    langs.map { |l| LANGUAGES[l].container }.uniq
  end

  def build_benchmark_helpers(benchmark_name)
    b = BENCHMARKS[benchmark_name]
    return unless b.build_helpers_cmd

    r = Runner.new(container: b.build_helpers_container, cmd: b.build_helpers_cmd.call, remote_chdir: "#{benchmark_name}/target")

    print "Build #{"helpers".colorize(:magenta)} #{benchmark_name}/ "
    r.run

    print(r.status.colorize(r.status == "ok" ? :green : :red))
    puts
  end

  def build_exact(benchmark_name, language_name)
    b = BENCHMARKS[benchmark_name]
    l = LANGUAGES[language_name]
    return unless l.build_cmd

    check_dir = File.join(File.dirname(__FILE__), '..', benchmark_name)
    l.each_source(check_dir) do |source| # usual use case, just one element, rare 2 elements
      cmd = l.build_cmd.call("../" + source, l.out(source), b.build_flags ? b.build_flags[source] : nil)
      cmd = "wrapper #{cmd}" # to catch time and memory
      r = Runner.new(container: l.container, cmd: cmd, remote_chdir: "#{benchmark_name}/target", stderr: :measure, stdout: :text)

      print "#{"Run"} [#{language_name.colorize(:yellow)}] #{benchmark_name}/#{source} "
      r.run

      ss = r.short_stats
      stat_name = language_name
      if source.include?('-')
        stat_name = stat_name + "-" + source.split('.')[0].split('-')[1]
      end
      set_result(benchmark_name, stat_name, "build_time", ss['time'])
      set_result(benchmark_name, stat_name, "build_ram", ss['ram'])

      print(r.status.colorize(r.status == "ok" ? :green : :red))
      puts " -> #{benchmark_name}/target/#{l.out(source)} (in #{r.full_time.round(2)}s)"
    end
  end

  def create_runners(benchmark_name, language_name, debug = false)
    l = LANGUAGES[language_name]
    b = BENCHMARKS[benchmark_name]

    res = []

    check_dir = File.join(File.dirname(__FILE__), '..', benchmark_name)
    l.each_source(check_dir) do |source| # usual use case, just one element, rare 2 elements
      cmd = Array(l.run_cmd.call("../" + source, l.out(source)))
      if debug
        cmd += Array(b.debug_args) if b.debug_args
      else
        cmd += Array(b.args) if b.args
      end

      res << Runner.new(container: l.container, cmd: cmd, remote_chdir: "#{benchmark_name}/target", stdout: debug ? :text : :skip, stderr: debug ? :text : :measure, timeout: b.get_timeout, stdin: debug ? b.debug_stdin : b.stdin, name: source)
    end

    res # usual use case, just one element, rare 2 elements
  end

  def run_exact(benchmark_name, language_name)
    create_runners(benchmark_name, language_name).each do |r| # usual use case, just one element, rare 2 elements
      print "#{"Run"} [#{language_name.colorize(:yellow)}] #{r.cmd} in #{"#{benchmark_name}/target"} "

      r.run

      print(r.status.colorize(r.status == 'ok' ? :green : (r.status == 'timeout' ? :yellow : :red)))

      s = r.stats
      s.each do |k, v|
        stat_name = language_name
        source = r.name
        if source.include?('-')
          stat_name = stat_name + "-" + source.split('.')[0].split('-')[1]
        end
        set_result(benchmark_name, stat_name, k, v)
      end

      puts " (in #{(s['full_time'].to_f.round(2).to_s + "s").colorize(r.status == 'timeout' ? :red : :cyan)}, runs: #{s['runs']}, best_run_time: #{(s['min_run_time'].to_f.round(2).to_s + "s").colorize(color: :black, background: :green)}, max_ram: #{s['max_ram'].to_f.round(1)}Mb)"
    end
  end

  def check_exact(benchmark_name, language_name)
    b = BENCHMARKS[benchmark_name]
    create_runners(benchmark_name, language_name, true).each do |r| # usual use case, just one element, rare 2 elements
      print "#{"Check"} [#{language_name.colorize(:yellow)}] #{r.cmd} in #{"#{benchmark_name}/target"} "
      r.run

      if r.status == "ok"
        s1 = r.stdout_content
        s2 = b.debug_output
        unless s2
          s2 = b.debug_output_md5
          require 'digest'
          s1 = Digest::MD5.hexdigest s1
        end
        if compare_strings(s1, s2)
          print("ok".colorize(:green))
        elsif b.expected_check_failed && b.expected_check_failed.include?(language_name)
          print("skip".colorize(:yellow))
        else
          print("Unexp".colorize(:red))
          puts
          puts("BadOutput".colorize(:red))
          puts "============ Expected =============="
          puts s2
          puts "============ Got ==================="
          puts s1
          puts "===================================="
        end
      else
        print(r.status.colorize(:red))
      end

      puts
    end
  end

  def compare_strings(s1, s2)
    s1 = s1.strip
    s2 = s2.strip
    s1 == s2
  end

  def set_result(*keys, value)    
    h = @results
    last_key = keys.pop
    while key = keys.shift
      h[key] ||= {}
      h = h[key]
    end
    @results_changed = true
    h[last_key] = value
  end

  def results_filename
    "results/#{@arch}/round_#{@round}.yml"
  end

  def save_results
    return unless @results_changed
    FileUtils.mkdir_p("results/#{@arch}")    
    r = @results
    r["date"] = Date.today.to_s
    File.open(results_filename, 'w') { |f| f.write(r.to_yaml) }
  end

  def load_results(filename)
    if File.exists?(filename)
      x = YAML.load_file(filename)
      x = {} unless x.is_a?(Hash)
      x
    else
      {}
    end
  end

  def get_readme_rows(benchmark_name, langs_str)
    b = BENCHMARKS[benchmark_name]
    rows = []
    r = @results[benchmark_name]
    return rows unless r

    langs = langs_from_str(langs_str)
    r = r.select { |k, v| langs.include?(k) }
    r = r.sort_by { |(k, v)| v['min_run_time'] || 1000000.0 }
    
    r.each do |(lang_name, stats)|
      l = LANGUAGES[lang_name]
      row = []
      row << l.print_name
      row << l.print_name2

      if stats['runs'].to_i > 0
        row << stats['min_run_time'].round(2)
      else
        if stats['status'] == 'timeout'
          row << "> #{b.get_timeout.round(1)}"
        else
          row << "-"
        end
      end

      row << stats['runs']
      row << (stats['start_time'].to_f + stats['build_time'].to_f).round(2)      
      row << (stats['max_ram'].to_f > 0 ? stats['max_ram'].round(1) : '-')
      rows << row
    end

    rows
  end
end

# ext language class
class Language
  # find source files in dir by masks in order:
  # test-*.LANG.EXT
  # test.LANG.EXT
  # test-*.EXT  
  # test.EXT  

  # example:
  # test.pypy3.py # executed only when :name == "pypy3" and :ext == "py"
  # test.py # executed when :name != "pypy3" and :ext == "py"
  def each_source(dir)    
    if File.exists?(File.join(dir, "test.#{name}.#{ext}")) # look for "test.pypy3.py"
      yield "test.#{name}.#{ext}"
    else # look for "test.py"
      yield "test.#{ext}" if File.exists?(File.join(dir, "test.#{ext}"))
    end

    # look for additional sources test-*

    paths1, paths2 = {}, {}

    Dir.glob(File.join(dir, "test-*.#{ext}")).each do |path|
      n = File.basename(path, ".#{ext}")
      if n.include?('.')
        parts = n.split('.')
        raise "not allowed name #{path}" if parts.size > 2
        paths1[parts[0]] ||= {}
        paths1[parts[0]][parts[1]] = 1
      else
        paths2[n] = 1
      end
    end

    return if paths1.empty? && paths2.empty?

    paths1.each do |test_name, h|
      if h[name]
        yield "#{test_name}.#{name}.#{ext}"
      end
    end

    paths2.each_key do |test_name|
      finded = false
      if p1 = paths1[test_name]
        finded = true if p1[name]
      end

      unless finded
        yield "#{test_name}.#{ext}"
      end
    end
  end
end
