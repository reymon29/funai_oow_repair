class Receiving < ApplicationRecord
    validates :receive_courier, exclusion: { in: %w(FedEx UPS USPS DHL) }
end
