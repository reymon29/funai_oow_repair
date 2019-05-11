class Order < ApplicationRecord
  belongs_to :product
  has_many :orders
  has_many :notes
  has_many :repairs
  has_one :shippings
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true, length: { in: 0..60 }
  validates :address1, length: { in: 0..60 }, allow_blank: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip, presence: true, length: { is: 5, message: "format for US: 90501" }
  validates :serial_number, presence: true, length: { is: 9, message: "format J123456789" }
  validates :telephone_no, presence: true, format: { with: /^[0-9]{10}$/, multiline: true,
    message: "format 5555555555" }

  before_create :check_order_id

  private

  def check_order_id
    orders = Order.all
    orders.empty? ? self.order_no : self.order_no = Order.last.order_no + 1
  end
end
