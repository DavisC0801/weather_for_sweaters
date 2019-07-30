require "rails_helper"

describe "/api/v1/forecast" do
  it "renders a page" do
    VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
      get "/api/v1/forecast?location=denver,co"
      expect(response).to be_successful
    end
  end

  it "includes city info" do
    VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
      get "/api/v1/forecast?location=denver,co"
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:location]
      expect(parsed_response.keys).to contain_exactly(:city, :state, :country, :date, :time)
    end
  end

  it "includes current brief info" do
    VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
      get "/api/v1/forecast?location=denver,co"
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:currently_brief]
      expect(parsed_response.keys).to contain_exactly(:current_brief_icon, :current_brief_summary, :current_temp, :current_high, :current_low)
    end
  end

  it "includes current detailed info" do
    VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
      get "/api/v1/forecast?location=denver,co"
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:currently_detail]
      expect(parsed_response.keys).to contain_exactly(:current_detail_icon, :current_detail_summary, :current_detail_feels_like, :current_detail_humidity, :current_detail_visibility, :current_detail_uv_index)
    end
  end

  it "includes hourly info" do
    VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
      get "/api/v1/forecast?location=denver,co"
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:hourly]
      expect(parsed_response.first.keys).to contain_exactly(:hourly_time, :hourly_icon, :hourly_temp)
      expect(parsed_response.length).to eq(8)
    end
  end

  it "includes daily info" do
    VCR.use_cassette("forecasts/denver", allow_playback_repeats: true) do
      get "/api/v1/forecast?location=denver,co"
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:daily]
      expect(parsed_response.first.keys).to contain_exactly(:daily_name, :daily_icon, :daily_summary, :daily_percipitation_chance, :daily_high, :daily_low)
      expect(parsed_response.length).to eq(5)
    end
  end
end
