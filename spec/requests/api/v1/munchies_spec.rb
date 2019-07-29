require "rails_helper"

describe "/api/v1/munchies" do
  it "renders a page" do
    get "/api/v1/munchies?start=denver,co&end=pueblo,co&food=chinese"
    expect(response).to be_successful
  end
end
