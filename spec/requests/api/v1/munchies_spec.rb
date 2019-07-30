require "rails_helper"

describe "/api/v1/munchies" do
  before :each do
    allow(Time).to receive(:now).and_return(Time.at(1564423200))
  end

  it "renders a page" do
    VCR.use_cassette("resturants/pueblo_chinese", allow_playback_repeats: true) do
      get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"
      expect(response).to be_successful
    end
  end

  it "includes a city" do
    VCR.use_cassette("resturants/pueblo_chinese", allow_playback_repeats: true) do
      get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"
      parsed_response = JSON.parse(response.body)
      expect(parsed_response["data"]["attributes"]["city"]).to eq("Pueblo, CO")
    end
  end

  it "includes a resturant" do
    VCR.use_cassette("resturants/pueblo_chinese_all", allow_playback_repeats: true) do
      all_resturant_list = ResturantService.find_open_resturants("pueblo,co", 1564423200, "chinese", 11)
      all_resturants = all_resturant_list.map { |attributes| Resturant.new(attributes) }
      VCR.use_cassette("resturants/pueblo_chinese", allow_playback_repeats: true) do
        get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"
        parsed_response = JSON.parse(body)
        names = all_resturants.map { |resturant| resturant.name }
        addresses = all_resturants.map { |resturant| resturant.address }
        ids = all_resturants.map { |resturant| resturant.id }

        expect(names.include?(parsed_response["data"]["attributes"]["resturant_list"].first["name"])).to be true
        expect(addresses.include?(parsed_response["data"]["attributes"]["resturant_list"].first["address"])).to be true
        expect(ids.include?(parsed_response["data"]["attributes"]["resturant_list"].first["id"])).to be true
        expect(names.include?(parsed_response["data"]["attributes"]["resturant_list"].last["name"])).to be true
        expect(addresses.include?(parsed_response["data"]["attributes"]["resturant_list"].last["address"])).to be true
        expect(ids.include?(parsed_response["data"]["attributes"]["resturant_list"].last["id"])).to be true
      end
    end
  end
end
