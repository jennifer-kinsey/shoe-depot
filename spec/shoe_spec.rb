require "spec_helper"

describe (Brand) do
  it { should have_and_belong_to_many(:stores) }

  it("validates presence of brand name") do
    shoe1 = Brand.new({:name => "", :price => 30})
    expect(shoe1.save).to eq(false)
  end
  it("validates presence of brand shoe price") do
    shoe1 = Brand.new({:name => "Doc Marten", :price=> nil})
    expect(shoe1.save).to eq(false)
  end

end


describe (Store) do
  it { should have_and_belong_to_many(:brands) }

  it("validates presence of store namee") do
    store1 = Store.new({:name => ""})
    expect(store1.save).to eq(false)
  end
end
