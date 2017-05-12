class AddFormattedPriceToBrands < ActiveRecord::Migration[5.1]
  def change
    def change
      add_column(:brands, :formatted_price, :string)
    end
  end
end
