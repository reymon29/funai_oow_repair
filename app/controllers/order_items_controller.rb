class OrderItemsController < ApplicationController
  before_action :order_id_find

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new
  end

  def destroy

  end

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

  def order_params
    params.require(:order_items).permit()
  end
end
