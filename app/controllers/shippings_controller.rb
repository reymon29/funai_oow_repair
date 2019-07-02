class ShippingsController < ApplicationController
  before_action :order_id_find, only: [:new, :create, :edit, :update]
  skip_after_action :verify_authorized, only: [:create_bnp]

  def index
    @shippings = Shipping.all
    authorize @shippings
  end

  def new
    @shipping = Shipping.new
    authorize @shipping
  end

  def create
  end

  def edit
  end

  def update
  end

  def resend
    @shipping = shipping_id_find
    @order = order_id_find
    authorize @shipping
    mail = OrderMailer.with(order: @order, shipping: @shipping.shipout_tracking).label
    mail.deliver_now
    redirect_to order_path(@order)
    flash[:notice] = "Email sent out"
  end

  def create_bnp
    @order = order_id_find
    @user = current_user
    Shipping.bap_label(@order, @user)
    @order.bap_ship = false
    @order.save
    redirect_to order_path(@order)
    flash[:notice] = "FedEx labels created, now available to print"
  end

  private

  def shipping_id_find
    @shipping = Shipping.find(params[:id])
  end

  def order_id_find
    @order = Order.find(params[:order_id])
  end

end
