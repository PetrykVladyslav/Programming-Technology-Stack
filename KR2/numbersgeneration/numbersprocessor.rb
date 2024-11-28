require 'thread'

class NumberProcessor
  def initialize
    @queue = Queue.new
    @stop = false
  end

  def start_generator
    puts "Стартує потік генерації чисел."
    @generator_thread = Thread.new do
      loop do
        break if @stop
        number = rand(1..100)
        puts "Генератор: число згенеровано."
        @queue << number
        sleep(1)
      end
    end
  end

  def start_consumer
    puts "Стартує потік обробки чисел."
    @consumer_thread = Thread.new do
      loop do
        break if @stop && @queue.empty?
        if !@queue.empty?
          number = @queue.pop
          if number.odd?
            puts "Обробник: непарне число #{number}."
          else
            puts "Обробник: число парне, нічого не робимо."
          end
        end
        sleep(1)
      end
    end
  end

  def stop
    @stop = true
    @generator_thread.join
    @consumer_thread.join
    puts "Потоки завершили роботу."
  end
end

if __FILE__ == $PROGRAM_NAME
  processor = NumberProcessor.new
  processor.start_generator
  processor.start_consumer

  sleep(10)
  processor.stop
end
