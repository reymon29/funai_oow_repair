class Order < ApplicationRecord
  belongs_to :products
  has_many :orders
  has_many :notes
  has_many :repairs
end
