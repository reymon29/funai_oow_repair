class Repair < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :type, presence: true
  validates :comment, presence: true
end
