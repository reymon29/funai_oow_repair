class RepairRate < ApplicationRecord
  monetize :price_cents
  has_many :order_items
  accepts_nested_attributes_for :order_items, reject_if: :all_blank, allow_destroy: true

  def name_type
    "#{name} - #{price}"
  end
end
