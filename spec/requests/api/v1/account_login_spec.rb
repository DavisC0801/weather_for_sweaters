require "rails_helper"

describe "/api/v1/sessions" do
  before :all do
    new_user_params = {
      "email": "login@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    @params = {
      "email": "login@example.com",
      "password": "password",
    }

    @error_params = {
      "email": "login@example.com",
      "password": "notmireelpassword",
    }

    post "/api/v1/users", params: new_user_params
    @user = User.find_by(email: "login@example.com")
  end

  it "returns a response" do
    post "/api/v1/sessions"
    expect(response).to be_successful
  end

  it "returns an API key with a correct response" do
    post "/api/v1/sessions", params: @params
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:api_key]).to eq(@user.api_key)
  end

  it "returns an error with the incorrect response" do
    post "/api/v1/sessions", params: @error_params
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:error]).to eq("Invalid username/password combination")
  end
end
