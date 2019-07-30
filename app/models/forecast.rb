class Forecast
  attr_reader :id, :currently, :hourly, :daily

  def initialize(attributes)
    @id = Time.now.to_i
    @currently = attributes[:currently]
    @hourly = attributes[:hourly]
    @daily = attributes[:daily]
  end
end
