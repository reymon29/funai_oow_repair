class CreateRepairRates < ActiveRecord::Migration[5.2]
  def change
    create_table :repair_rates do |t|
      t.string :sku
      t.string :name

      t.timestamps
    end
  end
end
