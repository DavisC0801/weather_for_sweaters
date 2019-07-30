class Resturant
  attr_reader :id, :city, :resturant_list

  def initialize(location, resturants)
    @id = resturants.first[:id]
    split_location = location.split(",")
    @city = split_location.first.capitalize + ", " + split_location.second.upcase
    @resturant_list = format_resturants(resturants)
  end

  private
  def format_resturants(resturant_list)
    resturant_list.map do |resturant|
      {
        name: resturant[:name],
        address: resturant[:location][:display_address].join(" ")
      }
    end
  end
end
