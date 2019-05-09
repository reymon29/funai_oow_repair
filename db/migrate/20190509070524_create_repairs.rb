class CreateRepairs < ActiveRecord::Migration[5.2]
  def change
    create_table :repairs do |t|
      t.string :type
      t.text :comment
      t.references :order, foreign_key: true
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
