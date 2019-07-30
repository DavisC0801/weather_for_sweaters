require "spec_helper"
require "./app/models/forecast"

describe Forecast do
  before :all do
    location_fixture_hash = {
      :coordinates=>{:lat=>39.7392358, :lng=>-104.990251},
      :city=>"Denver",
      :state=>"CO",
      :country=>"United States",
      :datetime=>DateTime.now
    }

    forecast_fixture_hash = {
      :currently=>
        {
        :summary=>"Mostly Cloudy",
        :icon=>"partly-cloudy-day",
        :temperature=>90.57,
        :apparentTemperature=>90.57,
        :humidity=>0.22,
        :uvIndex=>6,
        :visibility=>3.373
      },
      :hourly=>
        {
        :data=>
          [
            {
              :time=>1564513200,
              :icon=>"partly-cloudy-day",
              :temperature=>90.59
            },
            {
              :time=>1564516800,
              :icon=>"fog",
              :temperature=>90.25
            },
            {
              :time=>1564520400,
              :icon=>"partly-cloudy-day",
              :temperature=>93.21
            },
            {
              :time=>1564524000,
              :icon=>"partly-cloudy-day",
              :temperature=>95.21
            },
            {
              :time=>1564527600,
              :icon=>"partly-cloudy-day",
              :temperature=>94.8
            },
            {
              :time=>1564531200,
              :icon=>"partly-cloudy-day",
              :temperature=>93.86
            },
            {
              :time=>1564534800,
              :icon=>"partly-cloudy-day",
              :temperature=>91.57
            },
            {
              :time=>1564538400,
              :icon=>"partly-cloudy-day",
              :temperature=>87.26
            }
          ]
        },
      :daily=>
      {
        :data=>
        [
          {
            :time=>1564466400,
            :summary=>"Foggy in the morning and afternoon.",
            :icon=>"fog",
            :precipProbability=>0.06,
            :temperatureMax=>95.21,
            :temperatureMin=>68.15
          },
          {
            :time=>1564552800,
            :summary=>"Partly cloudy throughout the day.",
            :icon=>"partly-cloudy-day",
            :precipProbability=>0.14,
            :temperatureMax=>93.73,
            :temperatureMin=>65.7
          },
          {
            :time=>1564639200,
            :summary=>"Possible light rain in the evening.",
            :icon=>"rain",
            :precipProbability=>0.61,
            :temperatureMax=>84.89,
            :temperatureMin=>65.04
          },
          {
            :time=>1564725600,
            :summary=>"Partly cloudy throughout the day.",
            :icon=>"partly-cloudy-day",
            :precipProbability=>0.19,
            :temperatureMax=>85.69,
            :temperatureMin=>63.13
          },
          {
            :time=>1564812000,
            :summary=>"Partly cloudy throughout the day.",
            :icon=>"partly-cloudy-day",
            :precipProbability=>0.02,
            :temperatureMax=>90.01,
            :temperatureMin=>66.85
          }
        ]
      }
    }
    @test_forecast = Forecast.new(forecast_fixture_hash, location_fixture_hash)
  end

  it "has a location attribute hash" do
    location_hash = @test_forecast.location
    expect(location_hash[:city]).to eq("Denver")
    expect(location_hash[:state]).to eq("CO")
    expect(location_hash[:country]).to eq("United States")
    expect(location_hash[:date]).to eq(Time.now.strftime("%_m/%e"))
    expect(location_hash[:time]).to eq(Time.now.strftime("%l:%M %p"))
  end

  it "has a currently brief attribute hash" do
    brief_hash = @test_forecast.currently_brief
    expect(brief_hash[:current_brief_icon]).to eq("partly-cloudy-day")
    expect(brief_hash[:current_brief_summary]).to eq("Mostly Cloudy")
    expect(brief_hash[:current_temp]).to eq(90.57)
    expect(brief_hash[:current_high]).to eq(95.21)
    expect(brief_hash[:current_low]).to eq(68.15)
  end

  it "has a currently detail attribute hash" do
    detail_hash = @test_forecast.currently_detail
    expect(detail_hash[:current_detail_icon]).to eq("partly-cloudy-day")
    expect(detail_hash[:current_detail_summary]).to eq("Mostly Cloudy")
    expect(detail_hash[:current_detail_feels_like]).to eq(90.57)
    expect(detail_hash[:current_detail_humidity]).to eq(0.22)
    expect(detail_hash[:current_detail_visibility]).to eq(3.373)
    expect(detail_hash[:current_detail_uv_index]).to eq(6)
  end

  it "has a hourly attribute hash" do
    hourly_hash = @test_forecast.hourly
    #TODO - Figure out how to convert w/o timezone for TravisCI
    # expect(hourly_hash.first[:hourly_time]).to eq(" 1 PM")
    expect(hourly_hash.first[:hourly_icon]).to eq("partly-cloudy-day")
    expect(hourly_hash.first[:hourly_temp]).to eq(90.59)

    # expect(hourly_hash.last[:hourly_time]).to eq(" 8 PM")
    expect(hourly_hash.last[:hourly_icon]).to eq("partly-cloudy-day")
    expect(hourly_hash.last[:hourly_temp]).to eq(87.26)
  end

  it "has a daily attribute hash" do
    daily_hash = @test_forecast.daily
    expect(daily_hash.first[:daily_name]).to eq("Tuesday")
    expect(daily_hash.first[:daily_icon]).to eq("fog")
    expect(daily_hash.first[:daily_summary]).to eq("Foggy in the morning and afternoon.")
    expect(daily_hash.first[:daily_percipitation_chance]).to eq(0.06)
    expect(daily_hash.first[:daily_high]).to eq(95.21)
    expect(daily_hash.first[:daily_low]).to eq(68.15)

    expect(daily_hash.last[:daily_name]).to eq("Saturday")
    expect(daily_hash.last[:daily_icon]).to eq("partly-cloudy-day")
    expect(daily_hash.last[:daily_summary]).to eq("Partly cloudy throughout the day.")
    expect(daily_hash.last[:daily_percipitation_chance]).to eq(0.02)
    expect(daily_hash.last[:daily_high]).to eq(90.01)
    expect(daily_hash.last[:daily_low]).to eq(66.85)
  end
end
