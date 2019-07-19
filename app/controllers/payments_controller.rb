class PaymentsController < ApplicationController
  before_action :set_order

  def new
    @order.amount = @order.amount - @order.paid
    if @order.amount == 0
      redirect_to order_path(@order)
      flash[:notice] = "Add something to the order, there is no amount due."
    end
    @payment = paid_check
    @customer = stripe_customer
    @card = card_type
    authorize @payment
  end

  def create
    @order.amount = @order.amount - @order.paid

    if payment_params.empty?
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
    else
      charge = Stripe::Charge.create(
        customer:     payment_params['stripe_id'],   # If payment was already taken before to locate stripe customer id.
        amount:       @order.amount_cents,
        description:  "Payment for repair #{@order.product.name} for order #{@order.order_no}",
        currency:     @order.amount.currency
      )
    end

    @payment = Payment.new(payment: charge.to_json, state: 'Paid', order: @order, amount: @order.amount)
    authorize @payment
    @order.paid == 0 ? @order.amount : @order.amount += @order.paid
    @order.paid += @order.amount - @order.paid
    @order.save
    @payment.save
    mail = OrderMailer.with(order: @order).invoice
    mail.deliver_now
    payment_shipping
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

  def payment_shipping
    @shipping = Shipping.where(order_id: @order, ready_ship: false)
    if @shipping.empty?
    else
      @shipping.each do |item|
        a = Shipping.find(item.id)
        a.ready_ship = true
        a.save
        if item.name == "Return Label Fee"
          label = Shipping.email_label(set_order, item)
        else item.name == "Shipback Fee"
          label = Shipping.ship_out_label(set_order, item)
        end
      end
    end
  end

  def payment_params
    params.permit(:stripe_id)
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

  def card_type
    paid_check.each do |payment|
      a = JSON.parse(payment.payment)
      return "#{a["payment_method_details"]["card"]["brand"].upcase} Ending(4) #{a["payment_method_details"]["card"]["last4"]}"
    end
  end
end
