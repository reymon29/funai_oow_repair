class PaymentsController < ApplicationController
  before_action :set_order

  def new
    @order.amount = @order.amount - @order.paid
    @payment = paid_check
    @customer = stripe_customer
  end

  def create
    @order.amount = @order.amount - @order.paid
      customer = Stripe::Customer.create(
        source: params[:stripeToken],
        email:  params[:stripeEmail],
        description: "DVD OOW"
      )
    if paid_check.empty?
      charge = Stripe::Charge.create(
        customer:     customer.id,   # You should store this customer id and re-use it.
        amount:       @order.amount_cents,
        description:  "Payment for repair #{@order.product.name} for order #{@order.order_no}",
        currency:     @order.amount.currency
      )
    else
      charge = Stripe::Charge.create(
        customer:     stripe_customer,   # You should store this customer id and re-use it.
        amount:       @order.amount_cents,
        description:  "Payment for repair #{@order.product.name} for order #{@order.order_no}",
        currency:     @order.amount.currency
      )
    end

    @payment = Payment.new(payment: charge.to_json, state: 'Paid', order: @order, amount: @order.amount)
    @order.paid == 0 ? @order.amount : @order.amount += @order.paid
    @order.paid += @order.amount - @order.paid
    @order.save
    @payment.save
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

  def paid_check
    @payment = Payment.where(state: "Paid", order_id: @order).limit(1)
  end

  def stripe_customer
    paid_check.each do |payment|
      a = JSON.parse(payment.payment)
      return a["customer"]
    end
  end

end
