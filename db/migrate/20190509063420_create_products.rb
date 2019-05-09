class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :model_no
      t.string :type
      t.integer :weight
      t.integer :length
      t.integer :width
      t.integer :height
      t.timestamps null: false
    end
  end
end
