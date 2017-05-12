class AddFormattedPriceToBrandsTake2 < ActiveRecord::Migration[5.1]
  def change
    remove_column(:brands, :price, :integer)
    add_column(:brands, :price, :decimal)
    add_column(:brands, :formatted_price, :string)
  end
end
