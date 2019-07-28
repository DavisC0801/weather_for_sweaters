class GeocodeService
  def initialize(location)
    parsed_location = location.split(",")
    @city = parsed_location.first
    @state = parsed_location.last
  end

  def self.find_coordinates(location)
    new(location).find_coordinates
  end

  def find_coordinates
    raw_coordinates = get_json("maps/api/geocode/json?")
    {
      coordinates: raw_coordinates[:results].first[:geometry][:location],
      city: raw_coordinates[:results].first[:address_components].first[:long_name],
      state: raw_coordinates[:results].first[:address_components].third[:short_name],
      country: raw_coordinates[:results].first[:address_components].fourth[:long_name],
      time: DateTime.now
    }
  end

  private
  
  def parameters
    {
      key: ENV["GOOGLE_API_KEY"],
      components: "locality:#{@city}|administrative_area:#{@state}"
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
