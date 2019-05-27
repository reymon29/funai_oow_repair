class AddFreightAmountToShipping < ActiveRecord::Migration[5.2]
  def change
    add_column :shippings, :shipping_amount, :string
  end
end
