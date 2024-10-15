require 'httparty'
require 'csv'

API_KEY = '25f77fb40727116cd870637f208a008d'

def valid_city_name?(city)
  city.match?(/\A[a-zA-Z\s\-]+\z/)
end

def fetch_weather_data(city)
  unless valid_city_name?(city)
    puts "Назва міста має містити лише латинські літери. Спробуйте ще раз."
    return nil
  end

  url = "http://api.openweathermap.org/data/2.5/weather?q=#{city}&appid=#{API_KEY}&units=metric"
  response = HTTParty.get(url)

  if response.code == 200
    weather_data = response.parsed_response
    {
      city: weather_data['name'],
      country: weather_data['sys']['country'],
      temperature: weather_data['main']['temp'],
      temperature_fells: weather_data['main']['feels_like'],
      humidity: weather_data['main']['humidity'],
      wind_speed: weather_data['wind']['speed'],
      wind_direction: weather_data['wind']['deg'],
      pressure: weather_data['main']['pressure'],
      weather_description: weather_data['weather'][0]['description']
    }
  else
    nil
  end
end

def save_to_csv(data)
  return if data.nil? || data.empty?

  CSV.open('weather_data.csv', 'w', headers: true) do |csv|
    csv << ['City','Country','Temperature (C)', 'Feels Like (C)', 'Humidity (%)',
            'Wind Speed (m/s)', 'Wind Direction (°)', 'Pressure (hPa)', 'Weather Description']
    data.each do |record|
      csv << [
        record[:city],
        record[:country],
        record[:temperature],
        record[:temperature_fells],
        record[:humidity],
        record[:wind_speed],
        record[:wind_direction],
        record[:pressure],
        record[:weather_description]
      ]
    end
  end
end

puts "Введіть місто, погоду якого ви хочете дізнатись: "
city = gets.chomp

weather_data = fetch_weather_data(city)

if weather_data
  puts "Дані про погоду для #{weather_data[:city]}:"
  puts "Країна: #{weather_data[:country]}"
  puts "Температура: #{weather_data[:temperature]} C"
  puts "Відчувається як: #{weather_data[:temperature_fells]} C"
  puts "Вологість: #{weather_data[:humidity]} %"
  puts "Швидкість вітру: #{weather_data[:wind_speed]} m/s"
  puts "Напрямок вітру: #{weather_data[:wind_direction]} (°)"
  puts "Атмосферний тиск: #{weather_data[:pressure]} hPa"
  puts "Стан погоди загалом: #{weather_data[:weather_description]}"


  save_to_csv([weather_data])
  puts "Дані про погоду збережено в weather_data.csv"
else
  puts "Не вдалося отримати дані про погоду для #{city}"
end
