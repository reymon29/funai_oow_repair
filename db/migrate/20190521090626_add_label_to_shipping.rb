class AddLabelToShipping < ActiveRecord::Migration[5.2]
  def change
    add_column :shippings, :label, :string
    add_column :shippings, :name, :string
  end
end
