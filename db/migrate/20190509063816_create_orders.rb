class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.integer :order_no, { default: 1000 }
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :address1
      t.string :city
      t.string :state
      t.string :zip
      t.string :telephone_no
      t.string :email
      t.string :order_status
      t.monetize :amount, currency: { present: false }
      t.monetize :paid, currency: { present: false }
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
