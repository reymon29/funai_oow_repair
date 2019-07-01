class OrderItemsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def new
    @order_item = OrderItem.new
  end

  def create
    @order_item = OrderItem.new(order_params)
    @shipping = Shipping.new
    @order_item.order = @order
    @repair_item = RepairRate.find(@order_item.repair_rate_id)
    @order.amount = @order.amount + @order_item.repair_rate.price
    if @order_item.save
      if @repair_item.category == "Shipping"
        if @repair_item.sku == "SHIP003"
          @order.bap_ship = true
        elsif @repair_item.sku == "SHIP004"
        else
          @shipping.order = @order
          @shipping.user = current_user
          @shipping.name = @repair_item.name
          @shipping.shipout_courier = "FedEx"
          @shipping.save
        end
      end
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
    @shipping = Shipping.where(order_id: @order, ready_ship: false, name: @repair.name).limit(1)
    @order.amount = @order.amount - @repair.price
    @order.save
    if @order_item.destroy
      @shipping.destroy_all
      redirect_to order_path(@order_item.order)
    else
      flash[:notice] = "Cannot be removed the item is paid."
      redirect_to order_path(@order_item.order)
    end
  end

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

  def order_params
    params.require(:order_item).permit(:repair_rate_id)
  end
end
