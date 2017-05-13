require 'sinatra'
require 'sinatra/reloader'
also_reload 'lib/**/*.rb'
require 'sinatra/activerecord'
require './lib/shoe'
require 'pg'

get '/' do
  @brands = Brand.all
  @stores = Store.all
  erb :index
end

post '/add_brand' do
  name = params['name']
  price = params['price']
  @brand = Brand.create(name: name, price: price, formatted_price: "")
  if @brand.save
    redirect '/'
  else
    erb :error
  end
end

post '/add_store' do
  name = params['store-name']
  @store = Store.create(name: name)
  if @store.save
    redirect '/'
  else
    erb :error
  end
end

get '/store/:id' do
  @store = Store.find(params['id'].to_i)
  @all_brands = Brand.all
  @brands_available = @all_brands - @store.brands
  erb :store
end

patch '/edit_store/:id' do
  @store = Store.find(params['id'].to_i)
  name = params['name']
  @store.update(name: name)
  if @store.update(name: name)
    redirect "/store/#{@store.id}"
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
  @all_stores = Store.all
  @stores_available = @all_stores - @brand.stores
  erb :brand
end

post '/add_store/:id' do
  @brand = Brand.find(params['id'].to_i)
  store = Store.find(params['store-id'].to_i)
  @brand.stores.push(store)
  redirect "brand/#{@brand.id}"
end

post '/add_brand/:id' do
  @store = Store.find(params['id'].to_i)
  brand = Brand.find(params['brand-id'].to_i)
  @store.brands.push(brand)
  redirect "store/#{@store.id}"
end
