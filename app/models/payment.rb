class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :repair_rate
  monetize :amount_cents
end
