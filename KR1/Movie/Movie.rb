class Movie
  attr_accessor :title, :director

  def initialize(title, director)
    raise ArgumentError, 'Назва фільму повинна бути рядком' unless title.is_a?(String) && !title.empty?
    raise ArgumentError, 'Режисер фільму повинен бути рядком' unless director.is_a?(String) && !director.empty?

    @title = title
    @director = director
  end

  def display_info
    "Назва фільму: #{@title}, Режисер: #{@director}"
  end
end

movie = Movie.new("Star Wars", "George Lucas")
puts movie.display_info