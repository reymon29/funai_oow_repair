class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :shipout_courier, exclusion: { in: %w(FedEx UPS USPS DHL) }
end
