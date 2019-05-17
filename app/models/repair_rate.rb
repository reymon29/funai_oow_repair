class RepairRate < ApplicationRecord
  monetize :price_cents
  has_many :payments
end
