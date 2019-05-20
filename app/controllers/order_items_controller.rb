class OrderItemsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_params)
    @order_item.order = @order
    @order.amount = @order.amount + @order_item.repair_rate.price
    if @order_item.save
      @order.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def destroy
    @order_item = OrderItem.find(params[:id])
    @order = Order.find(@order_item.order_id)
    @repair = RepairRate.find(@order_item.repair_rate_id)
    @order.amount = @order.amount - @repair.price
    @order.save
    @order_item.destroy
    redirect_to order_path(@order_item.order)
  end

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

  def order_params
    params.require(:order_item).permit(:repair_rate_id)
  end
end
