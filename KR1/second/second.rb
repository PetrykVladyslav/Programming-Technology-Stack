def second_largest(arr)
  raise ArgumentError, 'Масив повинен містити хоча б два елементи' if arr.length < 2

  largest = nil
  second_largest = nil

  arr.each do |num|
    if largest.nil? || num > largest
      second_largest = largest
      largest = num
    elsif second_largest.nil? || (num > second_largest && num != largest)
      second_largest = num
    end
  end

  second_largest
end

random_array = Array.new(10) { rand(1..100) }
puts "Випадковий масив: #{random_array}"
result = second_largest(random_array)
puts "Друге за величиною число: #{result}"