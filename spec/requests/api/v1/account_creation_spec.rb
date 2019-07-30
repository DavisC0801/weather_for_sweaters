require "rails_helper"

describe "/api/v1/users" do
  before :each do
    @params = {
      "email": "whatever@example.com",
      "password": "password",
      "password_confirmation": "password"
    }
  end

  it "gives a reply" do
    post "/api/v1/users", params: @params
    expect(response).to be_successful
  end
end
