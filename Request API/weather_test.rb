require 'minitest/autorun'
require 'httparty'
require 'csv'
require_relative 'weather_request'

class WeatherTest < Minitest::Test
  API_KEY = '25f77fb40727116cd870637f208a008d'

  def setup
    @city = 'Kyiv'
    @invalid_city = 'Qwertyqqwq'
    @expected_fields = [:city, :country, :temperature, :temperature_fells, :humidity, :wind_speed,
                        :wind_direction, :pressure, :weather_description]
  end

  def test_http_request_success
    encoded_city = URI.encode_www_form_component(@city)
    url = "http://api.openweathermap.org/data/2.5/weather?q=#{encoded_city}&appid=#{API_KEY}&units=metric"
    response = HTTParty.get(url)

    assert_equal 200, response.code, "HTTP-запит до API не повернув успішну відповідь."
  end

  def test_data_extraction
    weather_data = fetch_weather_data(@city)

    refute_nil weather_data, "Дані про погоду не були отримані для міста #{@city}"
    @expected_fields.each do |field|
      assert weather_data.key?(field), "Отримані дані не містять очікуване поле: #{field}"
    end
  end

  def test_csv_file_creation
    begin
      weather_data = fetch_weather_data(@city)
      refute_nil weather_data, "Отримані дані не повинні бути nil"

      save_to_csv([weather_data])

      assert File.exist?('weather_data.csv'), "CSV файл не створився."

      csv_data = CSV.read('weather_data.csv', headers: true)
      assert_equal @city, csv_data[0]['City'], "Назва міста в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:country].to_s, csv_data[0]['Country'], "Країна в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:temperature].to_s, csv_data[0]['Temperature (C)'], "Температура в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:temperature_fells].to_s, csv_data[0]['Feels Like (C)'], "Feels like в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:humidity].to_s, csv_data[0]['Humidity (%)'], "Вологість в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:wind_speed].to_s, csv_data[0]['Wind Speed (m/s)'], "Швидкість вітру в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:wind_direction].to_s, csv_data[0]['Wind Direction (°)'], "Напрямок вітру в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:pressure].to_s, csv_data[0]['Pressure (hPa)'], "Атмосферний тиск в CSV не відповідає очікуваному значенню"
      assert_equal weather_data[:weather_description].to_s, csv_data[0]['Weather Description'], "Стан погоди в CSV не відповідає очікуваному значенню"
    rescue StandardError => e
      assert false, "Помилка при створенні CSV файлу: #{e.message}"
    end
  end
end