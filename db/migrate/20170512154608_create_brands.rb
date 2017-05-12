class CreateBrands < ActiveRecord::Migration[5.1]
  def change
    create_table(:brands) do |t|
      t.column(:name, :string)
      t.column(:price, :decimal, :precision => 8, :scale => 2)
      t.timestamps
    end
  end
end
