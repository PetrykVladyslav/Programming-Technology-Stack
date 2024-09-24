def priority(op)
  if op == '+' || op == '-'
    1
  elsif op == '*' || op == '/'
    2
  elsif op == '^'
    3
  else
    0
  end
end

def convert_rpn(expression)
  result = []
  stack = []

  expression_space = expression.gsub(/([\+\-\*\/\^\(\)])/,' \1 ')
  elements = expression_space.split

  elements.each do |element|
    if element =~ /\w+/
      result.push(element)
    elsif element == '('
      stack.push(element)
    elsif element == ')'
      while stack.last != '('
        result.push(stack.pop)
      end
      stack.pop
    else
      while !stack.empty? && priority(stack.last) >= priority(element)
        result.push(stack.pop)
      end
      stack.push(element)
    end
  end

  while !stack.empty?
    result.push(stack.pop)
  end

  result.join(' ')
end

puts "Введіть математичний вираз:"
input = gets.chomp
rpn = convert_rpn(input)
puts "Вираз у RPN: #{rpn}"