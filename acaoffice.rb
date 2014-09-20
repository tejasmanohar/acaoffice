# Require gems
require 'sinatra'
require 'bundler'
require 'firebase'
require 'json'
require 'net/http'
require './environments'
Bundler.require

# Configure database
configure do
  FB_Firebase = Firebase::Client.new(ENV['FB_URL'], ENV['FB_SECRET'])
end

get '/' do
  erb :index
end