require 'minitest/autorun'
require_relative './second'

class TestSecondLargest < Minitest::Test
  def test_standard_case
    assert_equal 8, second_largest([1, 8, 3, 10, 7])
  end

  def test_array_with_two_elements
    assert_equal 3, second_largest([3, 1])
  end

  def test_array_with_negative_numbers
    assert_equal -1, second_largest([-10, -1, -5])
  end

  def test_array_with_duplicates
    assert_equal 5, second_largest([5, 5, 5, 5, 3])
  end

  def test_array_with_identical_numbers
    assert_nil second_largest([4, 4, 4])
  end

  def test_small_array
    assert_raises(ArgumentError) { second_largest([1]) }
  end

  def test_nil_array
    assert_raises(ArgumentError) { second_largest(nil) }
  end

  def test_array_with_strings
    assert_raises(ArgumentError) { second_largest(["a", "b", "c"]) }
  end
end