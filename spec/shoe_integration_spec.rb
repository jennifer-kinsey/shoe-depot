require "spec_helper"
require 'capybara/rspec'
require './app'

Capybara.app = Sinatra::Application
set(:show_exceptions, false)

describe("viewing available shoes and shoe functionality", {:type => :feature}) do
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

describe("viewing available stores and store functionality", {:type => :feature}) do
  it("reviews process of adding a new store and then seeing that store's page") do
    visit("/")
    fill_in("store-name", :with => "store_name")
    click_button("Add store")
    click_link("Store_name")
    expect(page).to have_content("Store_name info")
  end
  it("reviews process of adding brand that store sells") do
    visit("/")
    fill_in("name", :with => "brand_name")
    fill_in("price", :with => "23")
    click_button("Add brand")
    visit("/")
    fill_in("store-name", :with => "store_name")
    click_button("Add store")
    click_link('Store_name')
    expect(page).to have_content("There are only socks in stock.")
    select('Brand_name', :from => 'brand-id')
    click_button('Add')
    expect(page).to have_content("Here are the shoe brands sold at Store_name: Brand_name")
  end
end

describe("viewing error pages", {:type => :feature}) do
  it("takes you to an error page when you add invalid stores or brands") do
    visit("/")
    fill_in("name", :with => "hfduiiuydfuuhzvhzkvjhzjhvvjkchckjhckhvchkvhcjkhcjkhvjchvkhckjvhckhvkchvkjchkjvhckjhvkcjhvjkhvkjchkjvhckvhckvhcjkhvckhxkvhxkjhvkshkjhszhdvkdhkzdhvlHDVkudlgdGuliVlDHuihDViydiufyd")
    click_button("Add brand")
    expect(page).to have_content("Oh no! Something wrong's afoot. Here are your missteps: Name is too long (maximum is 100 characters) Price can't be blank Put your best foot forward and try again")
  end
end
