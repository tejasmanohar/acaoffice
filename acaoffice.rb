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
    name = params[:name]
    meet = params[:meet]
    token = params[:token]
    FB_Firebase.push('meetings', { :name => name, :meet => meet, :token => token })
end

get '/moxtra' do
  erb :moxtra
end

get '/meet' do
  erb :meet
end

get '/:name' do
  if !(exists? params[:name])
    redirect '/'
  else
    params[:name]
  end
end

post '/api' do
  if !(exists? params[:name])
    'true'
  else
    'false'
  end
end