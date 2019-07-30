require "rails_helper"

describe "/api/v1/forecast" do
  VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
    it "renders a page" do
      get "/api/v1/forecast?location=denver,co"
      expect(response).to be_successful
    end
  end
end
