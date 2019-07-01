class OrderItem < ApplicationRecord
  belongs_to :order
  belongs_to :repair_rate
  validates :repair_rate_id, uniqueness: { scope: :order_id, message: "item has already been added to this order" }
  before_destroy :check_paid_status?

  def check_paid_status?
    if self.payment_status == "Paid"
      throw :abort
    end
  end
end
