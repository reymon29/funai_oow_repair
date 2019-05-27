class AddReadyShipToShipping < ActiveRecord::Migration[5.2]
  def change
    add_column :shippings, :ready_ship, :boolean, default: false
  end
end
