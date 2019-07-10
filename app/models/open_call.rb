class OpenCall < ApplicationRecord
  belongs_to :product
  belongs_to :user
  validates :case_no, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true, length: { in: 0..60 }
  validates :address2, length: { in: 0..60 }, allow_blank: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true
  validates :telephone_no, presence: true, format: { with: /^[0-9]{10}$/, multiline: true,
    message: "format 5555555555" }
  validates :symptom, presence: true, length: { in: 10..250 }
  validates :status, presence: true
  validates :serial_number, presence: true, length: { in: 9..14 }
  validates :email, presence: true, format: { with: Devise.email_regexp, message: "invalid email" }
  geocoded_by :address_item
  after_validation :geocode

  def address_item
    [address, city, state, zip, "USA"].compact.join(', ')
  end

  def self.pending_calls_count
    @calls = self.where(status: ["Open Call", "Left Message"])
    return @calls.count
  end
end
