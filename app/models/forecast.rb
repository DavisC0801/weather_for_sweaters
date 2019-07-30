class Forecast
  attr_reader :id, :location, :currently_brief, :currently_detail, :hourly, :daily

  def initialize(forecast, location)
    @id = "#{location[:coordinates][:lat]}_#{location[:coordinates][:lng]}_#{Time.now.to_i}"
    @location = {
      city: location[:city],
      state: location[:state],
      country: location[:country],
      date: location[:datetime].strftime("%_m/%e"),
      time: location[:datetime].strftime("%l:%M %p")
    }
    @currently_brief = format_currently_brief(forecast[:currently], forecast[:daily])
    @currently_detail = format_currently_detail(forecast[:currently])
    @hourly = format_hourly(forecast[:hourly], 8)
    @daily = format_daily(forecast[:daily], 5)
  end

  private

  def format_currently_brief(current_forecast, daily_forecast)
    {
      current_brief_icon: current_forecast[:icon],
      current_brief_summary: current_forecast[:summary],
      current_temp: current_forecast[:temperature],
      current_high: daily_forecast[:data].first[:temperatureMax],
      current_low: daily_forecast[:data].first[:temperatureMin],
    }
  end

  def format_currently_detail(current_forecast)
    {
      current_detail_icon: current_forecast[:icon],
      current_detail_summary: current_forecast[:summary],
      current_detail_feels_like: current_forecast[:apparentTemperature],
      current_detail_humidity: current_forecast[:humidity],
      current_detail_visibility: current_forecast[:visibility],
      current_detail_uv_index: current_forecast[:uvIndex],
    }
  end

  def format_hourly(hourly_forecast, limit)
    hourly_data = hourly_forecast[:data].map do |forecast|
      {
        hourly_time: Time.at(forecast[:time]).strftime("%l %p"),
        hourly_icon: forecast[:icon],
        hourly_temp: forecast[:temperature]
      }
    end
    hourly_data.take(limit)
  end

  def format_daily(daily_forecast, limit)
    daily_data = daily_forecast[:data].map do |forecast|
      {
        daily_name: Time.at(forecast[:time]).strftime("%A"),
        daily_icon: forecast[:icon],
        daily_summary: forecast[:summary],
        daily_percipitation_chance: forecast[:precipProbability],
        daily_high: forecast[:temperatureMax],
        daily_low: forecast[:temperatureMin]
      }
    end
    daily_data.take(limit)
  end
end
