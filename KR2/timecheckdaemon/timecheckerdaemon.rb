require 'thread'

class TimeCheckerDaemon
  attr_reader :running, :elapsed_minutes

  def initialize(duration_in_minutes)
    raise ArgumentError, "Duration must be greater than 0" if duration_in_minutes <= 0

    @duration_in_minutes = duration_in_minutes
    @running = false
    @elapsed_minutes = 0
    @thread = nil
  end

  def start
    return if @running

    @running = true
    @thread = Thread.new do
      while @running && @elapsed_minutes < @duration_in_minutes
        puts "Current system time: #{Time.now}"
        @elapsed_minutes += 1
        sleep(60)
      end
      @running = false
      puts "Daemon completed at: #{Time.now}"
    end
  end

  def stop
    @running = false
    @thread&.join
  end

  private

  def check_time
    puts "Current system time: #{Time.now}"
  end
end

duration = 2
daemon = TimeCheckerDaemon.new(duration)
daemon.start

sleep(70)
daemon.stop
