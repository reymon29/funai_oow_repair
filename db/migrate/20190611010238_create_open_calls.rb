class CreateOpenCalls < ActiveRecord::Migration[5.2]
  def change
    create_table :open_calls do |t|
      t.string :case_no
      t.string :first_name
      t.string :last_name
      t.string :address
      t.string :address2
      t.string :city
      t.string :state
      t.string :zip
      t.string :telephone_no
      t.string :email
      t.boolean :called, default: false
      t.string :status
      t.references :product, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
