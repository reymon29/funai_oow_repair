class Receiving < ApplicationRecord
  validates :receive_courier, inclusion: { in: %w(FedEx UPS USPS DHL) }
  validates :model_no, presence: true
  validates :serial_number, presence: true
  validates :receive_tracking, presence: true
  belongs_to :order
end
