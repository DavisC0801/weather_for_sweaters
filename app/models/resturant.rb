class Resturant
  attr_reader :id, :name, :address

  def initialize(attributes)
    @id = attributes[:id]
    @name = attributes[:name]
    @address = attributes[:location][:display_address].join(" ")
  end
end
