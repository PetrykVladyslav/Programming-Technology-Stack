module Statistics
  def average
    return 0 if scores.empty?
    sum = scores.inject(0) do |total, value|
      raise ArgumentError, "Усі значення мають бути числовими" unless value.is_a?(Numeric)
      total + value
    end
    (sum.to_f / scores.size).round(2)
  end
end

class Grades
  include Statistics

  attr_accessor :scores

  def initialize(scores = [])
    @scores = scores
  end

  def add_score(score)
    raise ArgumentError, "Оцінка має бути числом" unless score.is_a?(Numeric)
    scores << score
  end

  def display_average
    begin
      "Середній бал: #{average}"
    rescue ArgumentError => e
      "Помилка: #{e.message}"
    rescue => e
      "Непередбачена помилка: #{e.message}"
    end
  end
end

def main
  grades = Grades.new

  loop do
    puts "\nМеню:"
    puts "1. Додати оцінку"
    puts "2. Обчислити середній бал"
    puts "3. Вийти"
    print "Ваш вибір: \n"

    choice = gets.chomp.to_i
    case choice
    when 1
      print "Введіть оцінку (число від 0 до 100): "
      begin
        score = Float(gets.chomp)
        if score >= 0 && score <= 100
          grades.add_score(score)
          puts "Оцінка #{score} додана."
        else
          puts "Помилка: оцінка має бути в діапазоні від 0 до 100. Спробуйте ще раз."
        end
      rescue ArgumentError
        puts "Помилка: введіть дійсне число."
      end
    when 2
      puts grades.display_average
    when 3
      puts "Програма завершена."
      break
    else
      puts "Невірний вибір. Спробуйте ще раз."
    end
  end
end

main
