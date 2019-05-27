class AddBapShipOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :bap_ship, :boolean, default: false
  end
end
