# Preview all emails at http://localhost:3000/rails/mailers/order_mailer
class OrderMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/order_mailer/label
  def label
    order = Order.last
    shipping = Shipping.last.shipout_tracking
    OrderMailer.with(order: order, shipping: shipping).label
  end

  def invoice
    order = Order.last
    OrderMailer.with(order: order).invoice
  end

  def repair_completed
    @order = Order.first
    @shipping = Shipping.ship_out_tracking(@order)
    OrderMailer.with(order: @order, shipping: @shipping).repair_completed
  end
end
