class ShippingsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def index
    @shippings = Shipping.all
  end

  def new
    @shipping = Shipping.new
  end

  def create
    @order = order_id_find
    @user = current_user
    Shipping.bap_label(@order, @user)
    @order.bap_ship = false
    @order.save
    redirect_to root_path
  end

  def resend
    @shipping = shipping_id_find
    @order = order_id_find
    mail = OrderMailer.with(order: @order, shipping: @shipping.shipout_tracking).label
    mail.deliver_now
    redirect_to order_path(@order)
    flash[:notice] = "Email sent out"
  end

  private

  def shipping_id_find
    @shipping = Shipping.find(params[:id])
  end

  def order_id_find
    @order = Order.find(params[:order_id])
  end

end
