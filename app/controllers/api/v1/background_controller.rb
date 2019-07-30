class Api::V1::BackgroundController < ApplicationController
  def show
    background = BackgroundService.find_background_url(params[:location], 1)
    render json: BackgroundSerializer.new(Background.new(background))
  end
end
