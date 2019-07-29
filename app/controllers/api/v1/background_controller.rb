class Api::V1::BackgroundController < ApplicationController
  def show
    background = BackgroundService.find_background(params[:location])
    render json: BackgroundSerializer.new(Background.new(background)).to_json
  end
end
