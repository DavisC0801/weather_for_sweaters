class GoogleService
  def self.find_coordinates(location)
    Rails.cache.fetch(location) do
      split_location = location.split(",")
      new.find_coordinates(split_location.first, split_location.last)
    end
  end

  def self.find_destination_information(origin, destination)
    Rails.cache.fetch("destination-#{origin}-#{destination}", expires_in: 10.minutes) do
      new.find_destination_information(origin, destination)
    end
  end

  def find_coordinates(city, state)
    coordinates_params = {
      components: "locality:#{city}|administrative_area:#{state}"
    }
    raw_coordinates = get_json("maps/api/geocode/json?", default_parameters.merge(coordinates_params))
    {
      coordinates: raw_coordinates[:results].first[:geometry][:location],
      city: raw_coordinates[:results].first[:address_components].first[:long_name],
      state: raw_coordinates[:results].first[:address_components].third[:short_name],
      country: raw_coordinates[:results].first[:address_components].fourth[:long_name],
      datetime: DateTime.now
    }
  end

  def find_destination_information(origin, destination)
    arrival_parameters = {
      origin: origin,
      destination: destination
    }
    raw_trip_info = get_json("maps/api/directions/json", default_parameters.merge(arrival_parameters))
    {
      arrival_time: Time.now.to_i + raw_trip_info[:routes].first[:legs].first[:duration][:value],
      destination_coordinates: raw_trip_info[:routes].first[:legs].first[:end_location],
      duration: raw_trip_info[:routes].first[:legs].first[:duration][:text],
      destination_address: raw_trip_info[:routes].first[:legs].first[:end_address]
    }
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
