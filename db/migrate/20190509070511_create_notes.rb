class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.text :comment
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps null: false
    end
  end
end
