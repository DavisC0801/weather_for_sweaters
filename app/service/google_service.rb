class GoogleService
  def self.find_coordinates(location)
    split_location = location.split(",")
    new.find_coordinates(split_location.first, split_location.last)
  end

  def self.find_arrival_time(origin, destination)
    new.find_arrival_time(origin, destination)
  end

  def find_coordinates(city, state)
    coordinates_params = {
      components: "locality:#{city}|administrative_area:#{state}"
    }
    raw_coordinates = get_json("maps/api/geocode/json?", default_parameters.merge(coordinates_params))
    require 'pry'; binding.pry
    {
      coordinates: raw_coordinates[:results].first[:geometry][:location]
    }
  end

  def find_arrival_time(origin, destination)
    arrival_parameters = {
      origin: origin,
      destination: destination
    }
    raw_trip_info = get_json("maps/api/directions/json", default_parameters.merge(arrival_parameters))
    Time.now.to_i + raw_trip_info[:routes].first[:legs].first[:duration][:value]
  end

  private
  def default_parameters
    {
      key: ENV["GOOGLE_API_KEY"],
    }
  end

  def get_json(url, parameters)
    response = conn.get(url, parameters)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://maps.googleapis.com")
  end
end
