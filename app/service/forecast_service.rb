class ForecastService
  def initialize(coordinates)
    @lat = coordinates[:lat]
    @lng = coordinates[:lng]
  end

  def self.find_forecast(location)
    new(location).find_forecast
  end

  def find_forecast
    raw_forecast = get_json("forecast/#{ENV["DARKSKY_API_KEY"]}/#{@lat},#{@lng}", {exclude: "minutely"})
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
