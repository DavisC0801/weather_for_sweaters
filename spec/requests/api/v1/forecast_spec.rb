require "rails_helper"

describe "/api/v1/forecast" do
  it "renders a page" do
    VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
      get "/api/v1/forecast?location=denver,co"
      expect(response).to be_successful
    end
  end
end
