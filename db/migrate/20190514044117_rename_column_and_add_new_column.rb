class RenameColumnAndAddNewColumn < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :symptom, :text
    rename_column :orders, :address1, :address2
  end
end
