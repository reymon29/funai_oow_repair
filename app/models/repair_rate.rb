class RepairRate < ApplicationRecord
  monetize :price_cents
  has_many :order_items

  def name_type
    "#{name} - #{price}"
  end
end
