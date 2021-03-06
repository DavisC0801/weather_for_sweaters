class ForecastService
  def initialize(coordinates)
    @lat = coordinates[:lat]
    @lng = coordinates[:lng]
  end

  def self.find_forecast(location)
    Rails.cache.fetch("current-forecast-#{location}", expires_in: 10.minutes) do
      new(location).find_forecast
    end
  end

  def self.find_future_forecast(location, arrival_time)
    Rails.cache.fetch("future-forecast#{location}-#{arrival_time}", expires_in: 10.minutes) do
      new(location).find_future_forecast(arrival_time)
    end
  end

  def find_forecast
    raw_forecast = get_json("forecast/#{ENV["DARKSKY_API_KEY"]}/#{@lat},#{@lng}", {exclude: "minutely"})
    {
      currently: raw_forecast[:currently],
      hourly: raw_forecast[:hourly],
      daily: raw_forecast[:daily]
    }
  end

  def find_future_forecast(arrival_time)
    raw_forecast = get_json("forecast/#{ENV["DARKSKY_API_KEY"]}/#{@lat},#{@lng},#{arrival_time}", {exclude: "minutely"})
    {
      currently: raw_forecast[:currently],
      hourly: raw_forecast[:hourly],
      daily: raw_forecast[:daily]
    }
  end

  private

  def get_json(url, params)
    response = conn.get(url, params)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.darksky.net")
  end
end
