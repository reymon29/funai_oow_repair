class AddCaseNoToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :case_no, :string
  end
end
