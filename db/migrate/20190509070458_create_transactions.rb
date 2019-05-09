class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.integer :amount
      t.string :auth_no
      t.string :transaction_no
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
