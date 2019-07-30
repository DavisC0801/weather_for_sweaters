class Forecast
  attr_reader :id, :currently, :hourly, :daily

  def initialize(attributes)
    @id = 0
    @currently = attributes[:currently]
    @hourly = attributes[:hourly]
    @daily = attributes[:daily]
  end

end
