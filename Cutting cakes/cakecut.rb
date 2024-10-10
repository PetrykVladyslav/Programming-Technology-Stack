def parse_cake(input)
  cake = input.strip.split("\n").map(&:chars)
  raisins = []
  cake.each_with_index do |row, y|
    row.each_with_index do |cell, x|
      raisins << [x, y] if cell == 'o' || cell == 'о' || cell == '0'
    end
  end
  [cake, raisins]
end

def generate_rectangles(cake, raisin, area_per_piece)
  height = cake.size
  width = cake[0].size
  possible_rects = []

  rect_sizes = []
  (1..area_per_piece).each do |h|
    next unless area_per_piece % h == 0
    w = area_per_piece / h
    rect_sizes << [w, h]
  end

  rect_sizes.each do |w, h|
    (0..(width - w)).each do |x1|
      (0..(height - h)).each do |y1|
        x2 = x1 + w - 1
        y2 = y1 + h - 1

        if raisin[0] >= x1 && raisin[0] <= x2 && raisin[1] >= y1 && raisin[1] <= y2
          contains_other_raisin = false
          (y1..y2).each do |y|
            (x1..x2).each do |x|
              next if [x, y] == raisin
              if cake[y][x] == 'o' || cake[y][x] == 'о' || cake[y][x] == '0'
                contains_other_raisin = true
                break
              end
            end
            break if contains_other_raisin
          end
          next if contains_other_raisin

          rect = {
            x1: x1, y1: y1, x2: x2, y2: y2,
            width: w, height: h,
            area: w * h,
            raisin: raisin,
            cells: Set.new((x1..x2).to_a.product((y1..y2).to_a))
          }
          possible_rects << rect
        end
      end
    end
  end

  possible_rects
end

def backtrack(raisins, rectangles, index, assigned_rects, covered_cells, best_solution)
  if index == raisins.size
    first_rect_width = assigned_rects.first[:width]
    if best_solution[:rects].empty? || first_rect_width > best_solution[:rects].first[:width]
      best_solution[:rects] = assigned_rects.map(&:dup)
    end
    return
  end

  raisin = raisins[index]
  rectangles[raisin].each do |rect|
    if rect[:cells].intersect?(covered_cells)
      next
    end

    assigned_rects << rect
    covered_cells.merge(rect[:cells])

    backtrack(raisins, rectangles, index + 1, assigned_rects, covered_cells, best_solution)

    assigned_rects.pop
    covered_cells.subtract(rect[:cells])
  end
end

def format_output(cake, rects)
  output = rects.map do |rect|
    lines = []
    (rect[:y1]..rect[:y2]).each do |y|
      line = ''
      (rect[:x1]..rect[:x2]).each do |x|
        line << cake[y][x]
      end
      lines << line
    end
    lines.join("\n")
  end
  output
end

def solve_cake_problem(input)
  cake, raisins = parse_cake(input)
  total_cells = cake.size * cake[0].size
  area_per_piece = total_cells / raisins.size

  if total_cells % raisins.size != 0
    return "Неможливо розділити торт на рівні частини."
  end

  rectangles = {}
  raisins.each do |raisin|
    rects = generate_rectangles(cake, raisin, area_per_piece)
    if rects.empty?
      return "Неможливо знайти прямокутник для родзинки на позиції #{raisin}."
    end
    rects.sort_by! { |rect| -rect[:width] }
    rectangles[raisin] = rects
  end

  best_solution = { rects: [] }
  backtrack(raisins, rectangles, 0, [], Set.new, best_solution)

  if best_solution[:rects].empty?
    return "Неможливо знайти рішення."
  end

  format_output(cake, best_solution[:rects])
end


cake_input = <<~END
  .o.o....
  ........
  ....o...
  ........
  .....o..
  ........
END

result = solve_cake_problem(cake_input)

if result.is_a?(Array)
  puts "Результат: \n["
  result.each_with_index do |piece, index|
    puts piece
    puts index == result.size - 1 ? "]" : ","
  end
else
  puts result
end
