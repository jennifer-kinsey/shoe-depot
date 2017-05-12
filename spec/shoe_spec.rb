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
