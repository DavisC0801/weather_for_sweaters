class RoadTrip
  attr_reader :id, :location, :currently_brief, :currently_detail

  def initialize(forecast, destination)
    @id = "#{destination[:destination_coordinates][:lat]}_#{destination[:destination_coordinates][:lng]}_#{Time.now.to_i}"
    @location = format_location(destination)
    @currently_brief = format_currently_brief(forecast[:currently])
    @currently_detail = format_currently_detail(forecast[:currently])
  end

  private
  def format_location(destination)
    split_address = destination[:destination_address].split(", ")
    {
      trip_duration: destination[:duration],
      arrival_time: Time.at(destination[:arrival_time]).strftime("%l:%M %p"),
      destination_city: split_address.first,
      destination_state: split_address.second,
      destination_country: split_address.third
    }
  end

  def format_currently_brief(forecast)
    {
      current_brief_summary: forecast[:summary],
      current_brief_temp: forecast[:temperature],
      current_brief_feels_like: forecast[:apparentTemperature],
      current_brief_percipitaion_chance: forecast[:precipProbability]
    }
  end

  def format_currently_detail(forecast)
    {
      current_detail_summary: forecast[:summary],
      current_detail_icon: forecast[:icon],
      current_detail_humidity: forecast[:humidity],
      current_detail_wind_speed: forecast[:windSpeed],
      current_detail_wind_gust: forecast[:windGust],
      current_detail_uv_index: forecast[:uvIndex],
      current_detail_cloud_cover: forecast[:cloudCover],
      current_detail_visibility: forecast[:visibility],
      current_detail_temp: forecast[:temperature],
      current_detail_feels_like: forecast[:apparentTemperature],
      current_detail_percipitaion_chance: forecast[:precipProbability]
    }
  end
end
