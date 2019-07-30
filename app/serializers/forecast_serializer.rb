class ForecastSerializer
  include FastJsonapi::ObjectSerializer
  attributes :currently, :hourly, :daily
end
