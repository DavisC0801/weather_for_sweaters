require "rails_helper"

describe "/api/v1/road_trip" do
  before :all do
    new_user_params = {
      "email": "road_trip@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    post "/api/v1/users", params: new_user_params
    user = User.find_by(email: "road_trip@example.com")

    @params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "#{user.api_key}"
    }

    @error_params = {
      "origin": "Denver,CO",
      "destination": "Pueblo,CO",
      "api_key": "somegarbage"
    }
  end

  before :each do
    allow(Time).to receive(:now).and_return(Time.at(1564423200))
  end

  it "returns a response" do
    VCR.use_cassette("road_trip/denver_to_pueblo", allow_playback_repeats: true) do
      post "/api/v1/road_trip", params: @params
      expect(response).to be_successful
    end
  end

  it "includes destination address info" do
    VCR.use_cassette("road_trip/denver_to_pueblo", allow_playback_repeats: true) do
      post "/api/v1/road_trip", params: @params
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:location]
      expect(parsed_response.keys).to contain_exactly(:trip_duration,
                                                      :arrival_time,
                                                      :destination_city, 
                                                      :destination_state,
                                                      :destination_country)
    end
  end

  it "includes destination weather info" do
    VCR.use_cassette("road_trip/denver_to_pueblo", allow_playback_repeats: true) do
      post "/api/v1/road_trip", params: @params
      parsed_response = JSON.parse(response.body, symbolize_names: true)[:data][:attributes][:currently_detail]
      expect(parsed_response.keys).to contain_exactly(:current_detail_summary,
                                                      :current_detail_icon,
                                                      :current_detail_humidity,
                                                      :current_detail_wind_speed,
                                                      :current_detail_wind_gust,
                                                      :current_detail_uv_index,
                                                      :current_detail_cloud_cover,
                                                      :current_detail_visibility,
                                                      :current_detail_temp,
                                                      :current_detail_feels_like,
                                                      :current_detail_percipitaion_chance)
    end
  end

  it "returns an error with the incorrect API key" do
    VCR.use_cassette("road_trip/denver_to_pueblo", allow_playback_repeats: true) do
      post "/api/v1/road_trip", params: @error_params
      expect(response.status).to eq(401)
      parsed_response = JSON.parse(response.body, symbolize_names: true)
      expect(parsed_response[:error]).to eq("Invalid API Key")
    end
  end
end
