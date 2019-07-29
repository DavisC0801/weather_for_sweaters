class ResturantService
  def initialize(location, open_at, term)
    @location = location
    @open_at = open_at
    @term = term
  end

  def self.find_open_resturants(location, open_at, term)
    new(location, open_at, term).find_open_resturants
  end

  def find_open_resturants
    raw_resturants = get_json("v3/businesses/search")
    raw_resturants[:businesses].shuffle.slice(0,2)    
  end

  private
  def parameters
    {
      location: @location,
      categories: "resturants",
      open_at: @open_at,
      term: @term
    }
  end

  def get_json(url)
    response = conn.get(url, parameters)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.yelp.com") do |faraday|
      faraday.headers['Authorization'] = "Bearer #{ENV["YELP_API_KEY"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
