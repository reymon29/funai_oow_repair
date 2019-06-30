class AddPaymentStatusOnOrderItem < ActiveRecord::Migration[5.2]
  def change
    add_column :order_items, :payment_status, :string, default: "Unpaid"
  end
end
