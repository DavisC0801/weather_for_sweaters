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
    destination = Resturant.new(@destination, open_resturants)
    return destination
  end
end
