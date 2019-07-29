class Api::V1::MunchiesController < ApplicationController
  def show
    time_arrived = DirectionsService.find_arrival_time(params[:start], params[:end])
    open_resturants = ResturantService.find_open_resturants(params[:end], time_arrived, params[:food])
    destination = City.new(params[:end])
    destination.resturant_list = open_resturants.map { |attributes| Resturant.new(attributes) }
    render json: ResturantSerializer.new(destination).to_json
  end
end
