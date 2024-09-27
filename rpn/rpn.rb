def priority(op)
  if op == '+' || op == '-'
    1
  elsif op == '*' || op == '/'
    2
  elsif op == '^'
    3
  elsif op == '!'
    4
  else
    0
  end
end

def convert_rpn(expression)
  result = []
  stack = []
  expect_operand = true

  expression_space = expression.gsub(/([\+\-\*\/\^\(\)])/,' \1 ')
  elements = expression_space.split

  elements.each_with_index do |element, idx|
    next if element.nil? || element.strip.empty?

    if expect_operand && element == '-'
      if elements[idx + 1] =~ /\w/
        result.push("#{element}#{elements[idx + 1]}")
        elements[idx + 1] = nil
      elsif elements[idx + 1] == '('
        result.push("-")
        stack.push("*")
      end

    elsif element == '!'
      result.push(stack.pop)
      result.push('!')

    elsif element =~ /\w+/
      result.push(element)
      expect_operand = false
    elsif element == '('
      stack.push(element)
      expect_operand = true
    elsif element == ')'
      while stack.last != '('
        result.push(stack.pop)
      end
      stack.pop
      expect_operand = false
    else
      if idx + 1 >= elements.size || elements[idx + 1] =~ /[\+\-\*\/\^\)]/ || elements[idx + 1].nil? || elements[idx + 1].strip.empty?
        next
      end

      while !stack.empty? && priority(stack.last) >= priority(element)
        result.push(stack.pop)
      end
      stack.push(element)
      expect_operand = true
    end
  end

  while !stack.empty?
    result.push(stack.pop)
  end

  result.join(' ')
end

def expression_valid?(expression)
  expression_space = expression.gsub(/([\+\-\*\/\^\(\)])/,' \1 ')
  elements = expression_space.split

  elements.each_with_index do |element, idx|
    if element == '/' && elements[idx + 1] == '0'
      return true
    end
  end
  false
end

puts "Введіть математичний вираз:"
input = gets.chomp

if expression_valid?(input)
  puts "Помилка: Ділення на 0 заборонене!"
else
  rpn = convert_rpn(input)
  puts "Вираз у RPN: #{rpn}"
end
