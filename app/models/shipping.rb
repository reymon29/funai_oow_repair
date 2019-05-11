class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :receive_courier, exclusion: { in: %w(FedEx UPS USPS DHL) }
  validates :shipout_courier, exclusion: { in: %w(FedEx UPS USPS DHL) }
end
