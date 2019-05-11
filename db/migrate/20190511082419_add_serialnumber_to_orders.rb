class AddSerialnumberToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :serial_number, :string
  end
end
