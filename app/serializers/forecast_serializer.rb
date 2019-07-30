class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :currently_brief, :currently_detail, :hourly, :daily
end
