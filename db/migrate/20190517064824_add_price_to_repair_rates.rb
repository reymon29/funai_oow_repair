class AddPriceToRepairRates < ActiveRecord::Migration[5.2]
  def change
    add_monetize :repair_rates, :price, currency: { present: false }
  end
end
