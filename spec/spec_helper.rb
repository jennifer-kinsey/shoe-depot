ENV['RACK_ENV'] = 'test'
require 'rspec'
require 'pg'
require 'sinatra/activerecord'
require 'shoe'
require 'shoulda-matchers'
require 'pry'
require 'capybara'

RSpec.configure do |config|
  config.after(:each) do
    Brand.all.each do |d|
      d.destroy
    end
    Store.all.each do |d|
      d.destroy
    end
  end
end
