class CreateReceivingsTable < ActiveRecord::Migration[5.2]
  def change
    remove_column :shippings, :receive_courier
    remove_column :shippings, :receive_tracking

    create_table :receivings do |t|
      t.string :model_no
      t.string :serial_number
      t.string :receive_courier
      t.string :receive_tracking
    end
  end
end
