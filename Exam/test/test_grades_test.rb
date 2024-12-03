require 'minitest/autorun'
require_relative '../staticticgrades'

class TestGradesTest < Minitest::Test
  def setup
    @grades = Grades.new
  end

  def test_empty_scores
    assert_equal 0, @grades.average, "Середній бал порожнього списку має бути 0"
  end

  def test_add_score
    @grades.add_score(85)
    assert_equal [85], @grades.scores, "Оцінка має бути додана до списку"
  end

  def test_add_invalid_score_non_numeric
    assert_raises(ArgumentError, "Оцінка має бути числом") do
      @grades.add_score("A")
    end
  end

  def test_average_single_score
    @grades.add_score(90)
    assert_equal 90, @grades.average, "Середній бал має дорівнювати єдиній оцінці"
  end

  def test_average_multiple_scores
    @grades.add_score(80)
    @grades.add_score(90)
    @grades.add_score(100)
    assert_equal 90.0, @grades.average, "Середній бал має обчислюватися коректно"
  end

  def test_average_with_non_numeric_scores_in_list
    @grades.scores = [85, "A", 90]
    assert_raises(ArgumentError, "Усі значення мають бути числовими") do
      @grades.average
    end
  end

  def test_display_average
    @grades.add_score(75)
    @grades.add_score(85)
    @grades.add_score(95)
    assert_equal "Середній бал: 85.0", @grades.display_average, "Середній бал має відображатися коректно"
  end

  def test_display_average_with_empty_scores
    assert_equal "Середній бал: 0", @grades.display_average, "Середній бал порожнього списку має бути 0"
  end

  def test_display_average_with_invalid_scores
    @grades.scores = [100, "invalid", 80]
    assert_match(/Помилка/, @grades.display_average, "Має повертатися повідомлення про помилку для некоректних даних")
  end
end
