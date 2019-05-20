class PaymentsController < ApplicationController
  before_action :set_order

  def create
    customer = Stripe::Customer.create(
      source: params[:stripeToken],
      email:  params[:stripeEmail],
      description: "DVD OOW"
    )

    charge = Stripe::Charge.create(
      customer:     customer.id,   # You should store this customer id and re-use it.
      amount:       @order.amount_cents,
      description:  "Payment for repair #{@order.product.name} for order #{@order.order_no}",
      currency:     @order.amount.currency
    )

    @payment = Payment.new(payment: charge.to_json, state: 'Paid', order: @order, amount: @order.amount)
    @payment.save
    raise
    redirect_to order_path(@order)

  rescue Stripe::CardError => e
    flash[:alert] = e.message
    redirect_to new_order_payment_path(@order)
  end

  private

  def set_order
    # @order = Payment.where(state: "Pending").find(params[:order_id])
    @order = Order.find(params[:order_id])
  end
end
