class Payment < ApplicationRecord
  belongs_to :order
  monetize :amount_cents

  def update_ordered_items(order_no)
    @order = Order.find(order_no)

  end

  def self.today_sales
    total = 0
    @payments = self.where('DATE(created_at) = ? and State =?', Date.current, "Paid")
    @payments.each do |pay|
      total += pay.amount
    end
    return total
  end

  def self.sales_vs_profit
    report = []
    sales = 0
    expenses = 0
    profit = 0
    @payments = Payment.where(created_at: (Date.today - 30)..Date.tomorrow)
    @payments.each do |pay|
      sales += pay.amount.to_f
    end
    @shipping = Shipping.where(created_at: (Date.today - 30)..Date.tomorrow)
    @shipping.each do |shipping|
      expenses += shipping.shipping_amount.to_f
    end
    profit = sales - expenses
   return report << ['Last 30 days', sales, expenses, profit]
  end
end

