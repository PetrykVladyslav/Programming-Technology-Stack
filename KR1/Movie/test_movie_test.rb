require 'minitest/autorun'
require_relative './Movie'

class TestMovie < Minitest::Test
  def setup
    @movie = Movie.new("Lord of the Rings", "Peter Jackson")
  end

  def test_movie_title
    assert_equal "Lord of the Rings", @movie.title
  end

  def test_movie_director
    assert_equal "Peter Jackson", @movie.director
  end

  def test_display_info
    assert_equal "Назва фільму: Lord of the Rings, Режисер: Peter Jackson", @movie.display_info
  end
end