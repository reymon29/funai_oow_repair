class RemoveColumnsFromShippings < ActiveRecord::Migration[5.2]
  def change
    remove_column :shippings, :receive_model
    remove_column :shippings, :receive_serial
  end
end
