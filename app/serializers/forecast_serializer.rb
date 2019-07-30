class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :city, :state, :country, :date, :time, :currently_brief, :currently_detail, :hourly, :daily
end
