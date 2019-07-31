require "rails_helper"

describe "/api/v1/users" do
  before :all do
    @params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }

    @error_params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "notPassword"
    }
  end

  it "returns a response" do
    User.first.delete if !User.first.nil?
    post "/api/v1/users", params: @params
    expect(response).to be_successful
    expect(response.status).to eq(201)
  end

  it "returns an API key with a correct response" do
    User.first.delete if !User.first.nil?
    post "/api/v1/users", params: @params
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    new_user = User.last
    expect(parsed_response[:api_key]).to eq(new_user.api_key)
  end

  it "returns an error with the incorrect response" do
    post "/api/v1/users", params: @error_params
    expect(response.status).to eq(401)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    expect(parsed_response[:error]).to eq("Password confirmation doesn't match Password")
  end
end
