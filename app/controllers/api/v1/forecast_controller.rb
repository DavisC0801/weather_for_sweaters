class Api::V1::ForecastController < ApplicationController
  def show
    locationdata = GeocodeService.find_coordinates(params[:location])
    forecast = ForecastService.find_forecast(locationdata[:coordinates])
    render json: ForecastSerializer.new(Forecast.new(forecast)).to_json
  end
end
