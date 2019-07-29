class DirectionsService
  def initialize(origin, destination)
    @origin = origin
    @destination = destination
  end

  def self.find_arrival_time(origin, destination)
    new(origin, destination).find_arrival_time
  end

  def find_arrival_time
    raw_trip_info = get_json("maps/api/directions/json")
    Time.now.to_i + raw_trip_info[:routes].first[:legs].first[:duration][:value]
  end

  private
  def parameters
    {
      origin: @origin,
      destination: @destination,
      key: ENV["GOOGLE_API_KEY"]
    }
  end

  def get_json(url)
    response = conn.get(url, parameters)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://maps.googleapis.com")
  end
end
