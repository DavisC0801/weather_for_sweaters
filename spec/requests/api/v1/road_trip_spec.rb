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

  it "returns a response" do
    post "/api/v1/road_trip", params: @params
    expect(response).to be_successful
  end

  it "returns an error with the incorrect API key" do
    post "/api/v1/road_trip", params: @error_params
    expect(response.status).to eq(401)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:error]).to eq("Invalid API Key")
  end
end
