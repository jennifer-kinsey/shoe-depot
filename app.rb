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

post '/add_brand' do
  name = params['name']
  price = params['price']
  @brand = Brand.create(name: name, price: price)
  if @brand.save
    redirect '/'
  else
    erb(:error)
  end
end

post '/add_store' do
  name = params['name']
  @store = Store.create(name: name)
  if @store.save
    redirect '/'
  else
    erb(:error)
  end
end
