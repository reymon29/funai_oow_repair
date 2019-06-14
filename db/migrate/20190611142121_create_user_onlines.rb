class CreateUserOnlines < ActiveRecord::Migration[5.2]
  def change
    create_table :user_onlines do |t|
      t.boolean :active
      t.string :status
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
