require "spec_helper"
require 'capybara/rspec'
require './app'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("viewing available shoes", {:type => :feature}) do
  it("reviews process of adding a new shoe and then seeing that shoe's page") do
    visit("/")
    fill_in("name", :with => "brand_name")
    fill_in("price", :with => "23")
    click_button("Add brand")
    click_link("Brand_name")
    expect(page).to have_content("Brand_name info")
    expect(page).to have_content("$23.00")
  end
  it("reviews process of adding store where new shoe is sold") do
    visit("/")
    fill_in("store-name", :with => "store_name")
    click_button("Add store")
    visit("/")
    fill_in("name", :with => "brand_name")
    fill_in("price", :with => "23")
    click_button("Add brand")
    click_link("Brand_name")
    expect(page).to have_content("You cannot buy those shoes anywhere.")
    select('Store_name', :from => 'store-id')
    click_button('Add')
    expect(page).to have_content("Here are the stores that sell Brand_name: Store_name")
  end
end
