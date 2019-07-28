class ForecastController < ApplicationController
  def show
    locationdata = GeocodeService.find_coordinates(params[:location])
    forecast = ForecastService.find_forecast(locationdata[:coordinates])
    ForecastSerializer.new(locationdata, forecast).to_json
  end
end
