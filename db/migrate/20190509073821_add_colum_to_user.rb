class AddColumToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :dept, :string
    add_column :users, :location, :string
  end
end
