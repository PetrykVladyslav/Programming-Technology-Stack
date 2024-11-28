require 'minitest/autorun'
require_relative '../numbersprocessor'

class TestNumberProcessor < Minitest::Test
  def setup
    @processor = NumberProcessor.new
  end

  def teardown
    @processor.stop rescue nil
  end

  def test_threads_start_correctly
    @processor.start_generator
    @processor.start_consumer
    sleep(2)
    assert @processor.instance_variable_get(:@generator_thread).alive?, "Потік генератора не запустився."
    assert @processor.instance_variable_get(:@consumer_thread).alive?, "Потік обробника не запустився."
  end

  def test_generator_produces_numbers
    @processor.start_generator
    sleep(3)
    queue_size = @processor.instance_variable_get(:@queue).size
    assert queue_size > 0, "Генератор не додав числа в чергу."
  end

  def test_consumer_handles_odd_numbers
    @processor.start_generator
    @processor.start_consumer
    sleep(3)
    queue = @processor.instance_variable_get(:@queue)
    odd_numbers = []
    until queue.empty?
      number = queue.pop
      odd_numbers << number if number.odd?
    end
    assert odd_numbers.all?(&:odd?), "Обробник не розпізнав непарні числа коректно."
  end

  def test_threads_stop_correctly
    @processor.start_generator
    @processor.start_consumer
    sleep(2)
    @processor.stop
    refute @processor.instance_variable_get(:@generator_thread).alive?, "Потік генератора не завершився."
    refute @processor.instance_variable_get(:@consumer_thread).alive?, "Потік обробника не завершився."
  end

  def test_queue_empty_after_stop
    @processor.start_generator
    @processor.start_consumer
    sleep(3)
    @processor.stop
    queue = @processor.instance_variable_get(:@queue)
    assert queue.empty?, "Черга не порожня після завершення роботи."
  end
end