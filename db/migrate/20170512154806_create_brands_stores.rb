class CreateBrandsStores < ActiveRecord::Migration[5.1]
  def change
    create_table :brands_stores do |r|
      r.integer :brand_id
      r.integer :store_id

      r.timestamps
    end
  end
end
