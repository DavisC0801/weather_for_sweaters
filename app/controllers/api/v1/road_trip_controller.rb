class Api::V1::RoadTripController < ApplicationController
  def show
    user = User.find_by(api_key: params[:api_key])
    if user
      road_trip = RoadTripFacade.find_destination_forecast(params[:origin], params[:destination])
      render json: RoadTripSerializer.new(road_trip)
    else
      render json: { "error" => "Invalid API Key" }, :status => 401
    end
  end
end
