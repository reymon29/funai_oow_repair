class RepairRate < ApplicationRecord
  monetize :price_cents
  has_many :order_items

  def name
    "#{name} - #{price}"
  end
end
