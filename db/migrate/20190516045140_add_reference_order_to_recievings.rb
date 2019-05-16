class AddReferenceOrderToRecievings < ActiveRecord::Migration[5.2]
  def change
    add_reference :receivings, :order, foreign_key: true
  end
end
