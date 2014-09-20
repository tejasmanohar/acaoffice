# Set port compatibility with Nitrous.io
configure :development do   
  set :bind, '0.0.0.0' 
  set :port, 3000
end