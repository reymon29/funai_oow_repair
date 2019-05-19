class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :repair_rate
end
