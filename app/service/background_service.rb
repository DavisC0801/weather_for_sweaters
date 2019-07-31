class BackgroundService
  def initialize(location, limit)
    @city = location.split(",").first.capitalize
    @limit = limit
  end

  def self.find_background_url(location, limit)
    Rails.cache.fetch("background-#{location}", expires_in: 1.hour) do
      new(location, limit).find_background_url
    end
  end

  def find_background_url
    raw_background = get_json("/photos/random")
      {
        url: raw_background.first[:urls][:full],
        id: raw_background.first[:id]
      }
  end

  private
  def parameters
    {
      query: @city,
      count: @limit
    }
  end

  def get_json(url)
    response = conn.get(url, parameters)
    JSON.parse(response.body, symbolize_names: true)
  end

  def conn
    Faraday.new("https://api.unsplash.com") do |faraday|
      faraday.headers['Authorization'] = "Client-ID #{ENV["UNSPLASH_API_KEY"]}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
