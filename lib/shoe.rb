class Brand < ActiveRecord::Base
  has_and_belongs_to_many :stores
  validates(:name, {:presence => true, uniqueness: true, :length => { :maximum => 100}})
  validates(:price, :presence => true)
  before_save(:titlecase)
  before_save(:monetize)

private
  define_method(:titlecase) do
    words = self.name.downcase.split(" ")
    words.each do |word|
      word.capitalize!
    end
    self.name = words.join(" ")
  end

  define_method(:monetize) do
    self.formatted_price = "$" + ("%.2f" % self.price)
  end
end


class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands
  validates(:name, {:presence => true, uniqueness: true, :length => { :maximum => 100}})
  before_save(:titlecase)

private
  define_method(:titlecase) do
    words = self.name.downcase.split(" ")
    words.each do |word|
      word.capitalize!
    end
    self.name = words.join(" ")
  end
end
