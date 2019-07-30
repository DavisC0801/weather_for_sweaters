require "spec_helper"
require "./app/models/background"

describe Background do
  before :all do
    background_fixture_hash =
    {
      :url=>
      "https://images.unsplash.com/photo-1524060073462",
      :id=>"WHibx_fMEWQ"
    }
    @test_background = Background.new(background_fixture_hash)
  end

  it "has an ID and URL" do
    expect(@test_background.id).to eq("WHibx_fMEWQ")
    expect(@test_background.url).to eq("https://images.unsplash.com/photo-1524060073462") 
  end
end
