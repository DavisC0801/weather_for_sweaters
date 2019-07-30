require "rails_helper"

describe "/api/v1/backgrounds" do
  it "renders a page" do
    VCR.use_cassette("background/denver", allow_playback_repeats: true) do
      get "/api/v1/backgrounds?location=denver,co"
      expect(response).to be_successful
    end
  end

  it "renders attributes" do
    VCR.use_cassette("background/denver", allow_playback_repeats: true) do
      get "/api/v1/backgrounds?location=denver,co"
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data]
      expect(parsed_response.keys).to contain_exactly(:id, :type, :attributes)
    end
  end
end
