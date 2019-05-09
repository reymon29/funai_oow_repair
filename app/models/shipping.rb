class Shipping < ApplicationRecord
  belongs_to :user
  belongs_to :order
end
