class Api::V1::MunchiesController < ApplicationController
  def show
    time_arrived = DirectionsService.find_arrival_time(params[:start], params[:end])
    open_resturants = ResturantService.find_open_resturants(params[:end], time_arrived, params[:food])
    resturant_list = open_resturants.map { |attributes| Resturant.new(attributes) }
    render json: ResturautSerializer.new(resturant_list).to_json
  end
end
