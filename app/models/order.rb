class Order < ApplicationRecord
  belongs_to :product
  belongs_to :user
  has_many :notes
  has_many :repairs
  has_many :receivings
  has_many :shippings
  has_many :payments
  has_many :images
  has_many :order_items, dependent: :destroy
  has_many :repair_rates, through: :order_items
  monetize :amount_cents
  monetize :paid_cents
  accepts_nested_attributes_for :images, allow_destroy: :destroy
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :address, presence: true, length: { in: 0..60 }
  validates :address2, length: { in: 0..60 }, allow_blank: true
  validates :city, presence: true
  validates :state, presence: true
  validates :case_no, presence: true
  validates :zip, presence: true, length: { is: 5, message: "format for US: 90501" }
  validates :serial_number, presence: true, length: { is: 9, message: "format J123456789" }
  validates :telephone_no, presence: true, format: { with: /^[0-9]{10}$/, multiline: true,
    message: "format 5555555555" }
  validates :symptom, presence: true, length: { in: 10..250 }
  validates :order_status, inclusion: { in: ["Order Created", "Order Cancelled", "Item received", "Item in repair", "Completed, Shipped", "Completed, Disposed"] }
  before_create :check_order_id

  private

  def check_order_id
    orders = Order.all
    orders.empty? ? self.order_no : self.order_no = Order.last.order_no + 1
  end
end
