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
  FB_Firebase = Firebase::Client.new(ENV['FB_URL'])
end

def exists?(name)
  meetings = FB_Firebase.get('meetings').body
  meetings.detect { |_, v| v['name'] == name }
end

get '/' do
  erb :index
end

post '/new' do
  @name = params[:name]
  FB_Firebase.push('meetings', { :name => @name })
  redirect "/#{@name}"
end

get '/:name' do
  if !(exists? params[:name])
    redirect '/'
  else
    params[:name]
  end
end