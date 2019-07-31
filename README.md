# Rales Engine
An API for weather reports using Rails.

## Setup

* Download this project into a working directory.

* Install the requirements using bundle:
> bundle install

  This will install the required gems for the project.

* Create and migrate the local database using rake:
> rake db:create
> rake db:migrate

* Figaro is used for security purposes. To install Figaro, run:
> bundle exec figaro install

* After doing so, populate the created application.yml file with the following:
  1. DARKSKY_API_KEY: <Your Darksky API key>
  1. GOOGLE_API_KEY: <Your Google API key>
  1. YELP_CLIENT_ID: <Your Yelp client ID>
  1. YELP_API_KEY: <Your Yelp key>
  1. UNSPLASH_API_KEY: <Your Unsplash key>

* As a Rails based app, you are able to start the server using the following command:
> rails s

## Endpoints

The following endpoints are exposed on this API:

* /api/v1/forecast
* /api/v1/background
* /api/v1/munchies
* /api/v1/users
* /api/v1/sessions
* /api/v1/road_trip

#### /api/v1/forecast
This endpoint takes location as a query param, in the format of city,state. It returns current, hourly, and daily forecast information for the city.

#### /api/v1/background
This endpoint takes location as a query param, in the format of city,state. It returns a URL for an image that should be related to the city queried.

#### /api/v1/munchies
This endpoint takes an origin city, a destination city, and a food search term as a query param. The cities in the format of city,state, and the food search term can be any term. It returns the destination city and a list of 3 restaurants that match the search term that are open at the estimated arrival time.

#### /api/v1/users
This endpoint takes a post request, and a username, password and password confirmation as a query param. It returns an API key if the user is saved successfully, and an error message if not.

#### /api/v1/sessions
This endpoint takes a post request, and a username,  and password as a query param. It returns an API key if the user is authenticated successfully, and an error message if not.

#### /api/v1/road_trip
This endpoint takes a post request, and an origin city, a destination city, and a user API key as query params. The cities in the format of city,state. It returns the destination city, estimated travel time and arrival times, and a weather forecast for the location at the estimated time of arrival.
