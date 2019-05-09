class Order < ApplicationRecord
  belongs_to :products
  has_many :orders
  has_many :notes
  has_many :repairs
  has_many :shippings
  before_create :check_order_id

  private

  def check_order_id
   self.order_no = Order.last.order_no + 1
  end
end
