require "spec_helper"
require "./app/models/road_trip"

describe RoadTrip do
  before :all do
    destination_fixture_hash =
      {
        :arrival_time=>1564429613,
        :destination_coordinates=>{:lat=>38.2542053, :lng=>-104.6087488},
        :duration=>"1 hour 47 mins",
        :destination_address=>"Pueblo, CO, USA"
      }

    forecast_fixture_hash =
    {
      :currently =>
      {
        :summary=>"Clear",
        :icon=>"clear-day",
        :precipProbability=>0,
        :temperature=>90.17,
        :apparentTemperature=>90.17,
        :humidity=>0.29,
        :windSpeed=>8.52,
        :windGust=>15.86,
        :cloudCover=>0,
        :uvIndex=>11,
        :visibility=>10,
      }
    }
    @test_road_trip = RoadTrip.new(forecast_fixture_hash, destination_fixture_hash)
  end

  it "has destination information" do
    destination = @test_road_trip.location
    expect(destination[:trip_duration]).to eq("1 hour 47 mins")
    expect(destination[:destination_city]).to eq("Pueblo")
    expect(destination[:destination_state]).to eq("CO")
    expect(destination[:destination_country]).to eq("USA")
  end

  it "has forecast information" do
    forecast = @test_road_trip.currently_detail
    expect(forecast[:current_detail_summary]).to eq("Clear")
    expect(forecast[:current_detail_icon]).to eq("clear-day")
    expect(forecast[:current_detail_humidity]).to eq(0.29)
    expect(forecast[:current_detail_wind_speed]).to eq(8.52)
    expect(forecast[:current_detail_wind_gust]).to eq(15.86)
    expect(forecast[:current_detail_uv_index]).to eq(11)
    expect(forecast[:current_detail_cloud_cover]).to eq(0)
    expect(forecast[:current_detail_visibility]).to eq(10)
    expect(forecast[:current_detail_temp]).to eq(90.17)
    expect(forecast[:current_detail_feels_like]).to eq(90.17)
    expect(forecast[:current_detail_percipitaion_chance]).to eq(0)
  end
end
