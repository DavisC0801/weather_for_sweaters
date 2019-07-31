class RoadTripFacade
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def self.find_destination_forecast(origin, destination)
    new(origin, destination).find_destination_forecast
  end

  def find_destination_forecast
    location_data = GoogleService.find_destination_information(@origin, @destination)
    forecast_info = ForecastService.find_future_forecast(location_data[:destination_coordinates], location_data[:arrival_time])
    Forecast.new(forecast_info, location_data)
  end
end
