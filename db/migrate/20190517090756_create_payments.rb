class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :state
      t.monetize :amount, currency: { present: false }
      t.jsonb :payment
      t.references :order, foreign_key: true

      t.timestamps
    end
  end
end
