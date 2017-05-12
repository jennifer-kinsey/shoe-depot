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
    erb :error
  end
end

post '/add_store' do
  name = params['name']
  @store = Store.create(name: name)
  if @store.save
    redirect '/'
  else
    erb :error
  end
end

get '/store/:id' do
  @store = Store.find(params['id'].to_i)
  erb :store
end

patch '/edit_store/:id' do
  @store = Store.find(params['id'].to_i)
  name = params['name']
  @store.update(name: name)
  if @store.update(name: name)
    erb :store
  else
    erb :error
  end
end

delete '/delete_store/:id' do
  @store = Store.find(params['id'].to_i)
  @store.delete
  redirect '/'
end

get '/brand/:id' do
  @brand = Brand.find(params['id'].to_i)
  @stores = Store.all
  erb :brand
end

post '/add_store/:id' do
  @brand = Brand.find(params['id'].to_i)
  store = Store.find(params['store-id'].to_i)
  @brand.stores.push(store)
  redirect "brand/#{@brand.id}"
end
