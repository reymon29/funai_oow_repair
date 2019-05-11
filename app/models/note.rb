class Note < ApplicationRecord
  belongs_to :user
  belongs_to :order
  validates :comment, presence: true
end
