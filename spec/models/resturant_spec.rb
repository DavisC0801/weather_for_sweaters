require "spec_helper"
require "./app/models/resturant"

describe Resturant do
  before :all do
    resturant_fixture_hash =
    [
      {
        "id": "TKC7xro_LZOG08-wbzeCcw",
        "name": "Kan's Kitchen",
        "location":
        {
          "display_address":
          [
            "1620 S Prairie Ave", "Pueblo, CO 81005"
          ]
        }
      },
      {
        "name": "China Lantern",
        "location":
        {
          "display_address":
          [
            "315 W 4th St", "Pueblo, CO 81003"
          ]
        }
      },
      {
        "name": "Kuan's Kitchen",
        "location":
        {
          "display_address":
          [
            "750 Desert Flower Blvd", "Pueblo, CO 81001"
          ]
        }
      }
    ]
    @test_resturant = Resturant.new("pueblo,co", resturant_fixture_hash)
  end

  it "has an ID and city" do
    expect(@test_resturant.city).to eq("Pueblo, CO")
    expect(@test_resturant.id).to eq("TKC7xro_LZOG08-wbzeCcw")
  end

  it "has a resturant list" do
    expect(@test_resturant.resturant_list.first[:name]).to eq("Kan's Kitchen")
    expect(@test_resturant.resturant_list.first[:address]).to eq("1620 S Prairie Ave Pueblo, CO 81005")
    expect(@test_resturant.resturant_list.last[:name]).to eq("Kuan's Kitchen")
    expect(@test_resturant.resturant_list.last[:address]).to eq("750 Desert Flower Blvd Pueblo, CO 81001")
  end
end
