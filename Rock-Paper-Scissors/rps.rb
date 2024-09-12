choice = ["Rock", "Paper", "Scissors"]

puts "Оберіть свій варіант: Rock, Paper, Scissors"
user_pick = gets.chomp.capitalize.strip

while !choice.include?(user_pick) do
  puts "Невірний вибір. Спробуйте ще раз."
  puts "Оберіть свій варіант: Rock, Paper, Scissors"
  user_pick = gets.chomp.capitalize.strip
end

puts "Ви обрали: #{user_pick}"

computer_pick = choice.sample
puts "Комп'ютер обрав: #{computer_pick}"

if user_pick == computer_pick
  puts "Нічия!"
elsif (user_pick == "Rock" && computer_pick == "Scissors") ||
  (user_pick == "Scissors" && computer_pick == "Paper") ||
  (user_pick == "Paper" && computer_pick == "Rock")
  puts "Ви перемогли!"
else
  puts "Комп'ютер переміг!"
end
