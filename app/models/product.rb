class Product < ApplicationRecord
  validates :model_no, presence: true
  validates :brand, presence: true
  validates :product_type, presence: true
  validates :weight, presence: true
  validates :length, presence: true
  validates :width, presence: true
  validates :height, presence: true
  has_many :orders
  has_many :open_calls

  def name
  "#{model_no} - #{product_type}"
  end
end
