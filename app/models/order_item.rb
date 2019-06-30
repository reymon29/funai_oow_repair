class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :repair_rate
  validates :repair_rate_id, uniqueness: { scope: :order_id, message: "item has already been added to this order" }

end
