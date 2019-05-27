class ShippingsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def new
    @shipping = Shipping.new

  end

  def create

  end

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

  def notes_params
    params.require(:note).permit(:comment, :order_id)
  end

end
