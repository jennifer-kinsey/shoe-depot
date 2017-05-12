class Brand < ActiveRecord::Base
  has_and_belongs_to_many :stores
  validates(:name, :presence => true)
  validates(:price, :presence => true)
end


class Store < ActiveRecord::Base
  has_and_belongs_to_many :brands
end
