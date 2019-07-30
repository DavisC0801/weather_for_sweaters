class MunchiesFacade
  def initialize(origin, destination, food)
    @origin = origin
    @destination = destination
    @food = food
  end

  def self.resturant_list(origin, destination, food)
    new(origin, destination, food).resturant_list
  end

  def resturant_list
    time_arrived = GoogleService.find_arrival_time(@origin, @destination)
    open_resturants = ResturantService.find_open_resturants(@destination, time_arrived, @food, 3)
    destination = City.new(@destination)
    destination.resturant_list = open_resturants.map { |attributes| Resturant.new(attributes) }
    return destination
  end
end
