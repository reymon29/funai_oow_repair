class Payment < ApplicationRecord
  belongs_to :order
  belongs_to :repair_rates
  monetize :amount_cents
end
