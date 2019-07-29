class ResturantSerializer
  include FastJsonapi::ObjectSerializer
  attributes :name, :address
end
