require "rails_helper"

describe "/api/v1/backgrounds" do
  VCR.use_cassette("background/denver") do
    it "renders a page" do
      get "/api/v1/backgrounds?location=denver,co"
      expect(response).to be_successful
    end
  end
end
