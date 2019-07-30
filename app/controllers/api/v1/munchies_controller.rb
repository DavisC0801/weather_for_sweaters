class Api::V1::MunchiesController < ApplicationController
  def show
    resturants = MunchiesFacade.resturant_list(params[:start], params[:end], params[:food])
    render json: ResturantSerializer.new(resturants)
  end
end
