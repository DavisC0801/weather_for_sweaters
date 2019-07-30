class City
  attr_reader :id, :city, :state
  attr_accessor :resturant_list

  def initialize(attributes)
    @id = 0
    split_location = attributes.split(",")
    @city = split_location.first.capitalize + ", " + split_location.second.upcase
    @resturant_list = []
  end
end
