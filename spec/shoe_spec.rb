require "spec_helper"

describe (Brand) do
  it { should have_and_belong_to_many(:stores) }

  it("validates presence of brand name") do
    shoe1 = Brand.create({:name => "", :price => 30})
    expect(shoe1.save).to eq(false)
  end
  it("validates presence of brand shoe price") do
    shoe1 = Brand.create({:name => "Doc Marten", :price=> nil})
    expect(shoe1.save).to eq(false)
  end

  describe('#titlecase') do
    it('ensures the name of the brand is titlecased') do
      shoe1 = Brand.create({name: "dOC maRTen", price: 100})
      expect(shoe1.name).to eq("Doc Marten")
    end
  end

  describe('#monetize') do
    it('converts an inputted two decimal place number into a currency.') do
      shoe = Brand.create({:name => "Sanuk", :price=> 20.57})
      expect(shoe.formatted_price).to eq("$20.57")
    end
    it('converts an inputted decimal into a currency even if it has a no or only one decimal place.') do
      shoe = Brand.create({:name => "Sanuk", :price=> 20.5})
      expect(shoe.formatted_price).to eq("$20.50")
    end
    it('converts an inputted decimal into a currency even if it has too many decimal places.') do
      shoe = Brand.create({:name => "Sanuk", :price=> 20.57687})
      expect(shoe.formatted_price).to eq("$20.58")
    end
  end

end


describe (Store) do
  it { should have_and_belong_to_many(:brands) }

  it("validates presence of store namee") do
    store1 = Store.new({:name => ""})
    expect(store1.save).to eq(false)
  end

  describe('#titlecase') do
    it('ensures the name of the store is titlecased') do
      store1 = Store.create({name: "WALLY woRLD"})
      expect(store1.name).to eq("Wally World")
    end
  end

end
