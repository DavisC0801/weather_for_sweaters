class ForecastFacade
  def initialize(location)
    @location = location
  end

  def self.find_forecast(location)
    new(location).find_forecast
  end

  def find_forecast
    locationdata = GoogleService.find_coordinates(@location)
    forecast_info = ForecastService.find_forecast(locationdata)
    Forecast.new(forecast_info)
  end
end
