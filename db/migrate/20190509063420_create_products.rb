class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :brand
      t.string :model_no
      t.string :product_type
      t.decimal :weight, precision: 4, scale: 2, default: 0.00
      t.decimal :length, precision: 4, scale: 2, default: 0.00
      t.decimal :width, precision: 4, scale: 2, default: 0.00
      t.decimal :height, precision: 4, scale: 2, default: 0.00
      t.timestamps null: false
    end
  end
end
