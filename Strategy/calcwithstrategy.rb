module OperationStrategy
  def calculate(num1, num2)
    raise NotImplementedError, 'Цей метод має бути замінений підкласами'
  end
end

class AdditionStrategy
  include OperationStrategy

  def calculate(num1, num2)
    num1 + num2
  end
end

class SubtractionStrategy
  include OperationStrategy

  def calculate(num1, num2)
    num1 - num2
  end
end

class MultiplicationStrategy
  include OperationStrategy

  def calculate(num1, num2)
    num1 * num2
  end
end

class DivisionStrategy
  include OperationStrategy

  def calculate(num1, num2)
    if num2 == 0
      nil
    else
      num1 / num2
    end
  end
end

class ModulusStrategy
  include OperationStrategy

  def calculate(num1, num2)
    if num2 == 0
      nil
    else
      num1 % num2
    end
  end
end

class Calculator
  attr_accessor :operation_strategy

  def initialize(operation_strategy = nil)
    @operation_strategy = operation_strategy
  end

  def perform_operation(num1, num2)
    @operation_strategy.calculate(num1, num2)
  end

  def change_strategy(new_strategy)
    @operation_strategy = new_strategy
  end
end

def operation_strategy(operation)
  case operation
  when '+'
    AdditionStrategy.new
  when '-'
    SubtractionStrategy.new
  when '*'
    MultiplicationStrategy.new
  when '/'
    DivisionStrategy.new
  when '%'
    ModulusStrategy.new
  else
    nil
  end
end

def valid_number?(input)
  true if Float(input) rescue false
end

puts "\nПрограма для арифметичних дій з двома числами (введіть 'Quit' для виходу)."

calculator = Calculator.new
result = nil

while 1
  if result.nil?
    puts "Введіть перше число:"
    num1_input = gets.chomp
    break if num1_input.downcase == 'quit'

    if valid_number?(num1_input)
      result = num1_input.to_f
    else
      puts "Помилка: введіть коректне число."
      next
    end
  end

  puts "Введіть операцію (+, -, *, /, %):"
  operation = gets.chomp
  break if operation.downcase == 'quit'

  strategy = operation_strategy(operation)
  if strategy.nil?
    puts "Помилка: невідома операція! Допустимі операції: +, -, *, /, %"
    next
  end

  calculator.operation_strategy = strategy

  puts "Введіть наступне число:"
  num2_input = gets.chomp
  break if num2_input.downcase == 'quit'

  if valid_number?(num2_input)
    num2 = num2_input.to_f
  else
    puts "Помилка: введіть коректне число."
    next
  end

  operation_result = calculator.perform_operation(result, num2)

  if operation_result.nil?
    puts "Помилка: Ділення на нуль! Повернення до вибору операції."
    next
  else
    result = operation_result
    puts "Результат: #{result}" if result.is_a?(Numeric)
  end
end

puts "Успішний вихід з програми!"