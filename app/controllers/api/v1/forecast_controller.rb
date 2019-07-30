class Api::V1::ForecastController < ApplicationController
  def show
    forecast = ForecastFacade.find_forecast(params[:location])
    render json: ForecastSerializer.new(forecast)
  end
end
