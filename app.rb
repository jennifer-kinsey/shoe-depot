require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/shoe')
require('pg')

get "/" do
  erb :index
end
