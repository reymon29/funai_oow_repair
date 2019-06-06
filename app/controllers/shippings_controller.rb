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

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

end
