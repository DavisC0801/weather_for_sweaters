class ForecastFacade
  def initialize(location)
    @location = location
  end

  def self.find_forecast(location)
    new(location).find_forecast
  end

  def find_forecast
    location_data = GoogleService.find_coordinates(@location)
    forecast_info = ForecastService.find_forecast(location_data[:coordinates])
    Forecast.new(forecast_info, location_data)
  end
end
