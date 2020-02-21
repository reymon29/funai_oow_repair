class AddColumnSample < ActiveRecord::Migration[5.2]
  def change
    add_column :samples, :original_delivery_return_time, :string
  end
end
