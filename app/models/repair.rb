class Repair < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :status, presence: true, inclusion: { in: [ "Diagnosed", "Reviewed", "Repair Completed"] }
  validates :comment, presence: true
end
