class Transaction < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :amount, presence: true
  validates :transaction_id, presence: true
  validates :auth_no, presence: true
end
