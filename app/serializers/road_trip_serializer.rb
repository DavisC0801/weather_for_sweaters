class RoadTripSerializer
  include FastJsonapi::ObjectSerializer
  attributes :location, :currently_brief, :currently_detail
end
