def get_cake_input
  puts "Введіть ваш пиріг (рядки через Enter, завершіть ввід порожнім рядком):"
  cake = []
  line = gets.strip
  while line != ''
    line = line.gsub('о', 'o')
    cake << line.strip
    line = gets.strip
  end
  cake
end

def count_raisins(cake)
  count = 0
  cake.each do |row|
    count += row.count('o')
  end
  count
end

def cut_cake(cake, n)
  rows = cake.size
  cols = cake[0].size
  total_area = rows * cols
  target_area = total_area / n

  max_width = 0
  (1..cols).each do |w|
    if target_area % w == 0 && w > max_width
      max_width = w
    end
  end

  slices = []
  current_slice = []
  raisins_in_slice = 0
  (0...rows).each do |i|
    current_slice << cake[i]
    raisins_in_slice += cake[i].count('o')

    if current_slice.size * max_width == target_area && raisins_in_slice == 1
      slices << current_slice.join("\n")
      current_slice = []
      raisins_in_slice = 0
    end
  end

  if slices.empty?
    (1..cols).each do |w|
      if target_area % w == 0
        slices = cut_cake_vertically(cake, n, w, target_area)
        break if !slices.empty?
      end
    end
  end

  if slices.empty?
    (1..rows).each do |h|
      (1..cols).each do |w|
        if target_area % (h * w) == 0
          slices = cut_cake_cross(cake, n, h, w, target_area)
          break if !slices.empty?
        end
      end
      break if !slices.empty?
    end
  end

  slices
end

def cut_cake_vertically(cake, n, w, target_area)
  slices = []
  (0...cake[0].size).each do |j|
    current_slice = []
    (0...cake.size).each do |i|
      current_slice << cake[i][j...j+w]
    end
    slices << current_slice.join("\n")
  end
  slices
end

def cut_cake_cross(cake, n, h, w, target_area)
  slices = []
  (0...cake[0].size).each do |j|
    current_slice = []
    (0...cake.size).each do |i|
      current_slice << cake[i][j...j+w]
    end
    slices << current_slice.join("\n")
  end
  slices
end

cake = get_cake_input
n = count_raisins(cake)

while n <= 1 || n >= 10
  puts "Кількість родзинок повинна бути більше 1 та менше 10. Спробуйте ще раз."
  cake = get_cake_input
  n = count_raisins(cake)
end

result = cut_cake(cake, n)

if result.empty?
  puts "Не вдалося знайти рішення."
else
  puts "Ось ваше рішення:"
  result.each_with_index do |slice, idx|
    puts "Шматок #{idx + 1}:"
    puts slice
    puts ""
  end
end