class OpenCall < ApplicationRecord
  validates :case_no, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true, length: { in: 0..60 }
  validates :address2, length: { in: 0..60 }, allow_blank: true
  validates :city, presence: true
  validates :state, presence: true
  validates :telephone_no, presence: true, format: { with: /^[0-9]{10}$/, multiline: true,
    message: "format 5555555555" }
  validates :symptom, presence: true, length: { in: 10..250 }
  validates :status, presence: true
end
