class CreateShippings < ActiveRecord::Migration[5.2]
  def change
    create_table :shippings do |t|
      t.string :receive_model
      t.string :receive_serial
      t.string :receive_courier
      t.string :receive_tracking
      t.string :shipout_courier
      t.string :shipout_tracking
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
