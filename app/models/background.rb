class Background
  attr_reader :id, :url

  def initialize(attributes)
    @id = attributes[:id]
    @url = attributes[:url]
  end
end
