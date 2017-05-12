require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('sinatra/activerecord')
require('./lib/shoe')
require('pg')

get "/" do
  @brands = Brand.all
  @stores = Store.all
  erb :index
end
