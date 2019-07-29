require "rails_helper"

describe "/api/v1/munchies" do
  it "renders a page" do
    get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"
    expect(response).to be_successful
  end

  it "includes a city" do
    get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"
    response = JSON.parse(response.body)
    expect(response["data"]["attributes"]["city"]).to eq("Pueblo, CO")
  end
end
