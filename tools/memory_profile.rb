class MemoryProfile
  attr_accessor :pid
  attr_reader :max, :last

  def initialize(pid, container, interval = 0.25)
    @interval = interval
    @pid = pid
    @container = container
    @stopped = false
    @last = 0
    @max = 0
    start
  end

  def stop!
    @stopped = true
  end

  # memory in megabytes
  def check
    v = `docker compose exec #{@container} ps p #{@pid} -o rss 2>/dev/null` # this command usually spend something like 0.12s
    r = v.split.last.to_i / 1024.0
    @max = r if r > @max
    @last = r
    r
  rescue
    nil
  end

  def current_or_last
    check || last
  end

  def start
    Thread.new do
      while true
        break if @stopped
        check
        break if @stopped
        sleep @interval
      end
    end
  end
end
