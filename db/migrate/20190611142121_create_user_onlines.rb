class CreateUserOnlines < ActiveRecord::Migration[5.2]
  def change
    create_table :user_onlines do |t|
      t.boolean :active
      t.string :status
      t.timestamps
    end
  end
end
