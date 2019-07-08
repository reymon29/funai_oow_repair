class OrderItemsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def new
    if @order.order_status == "Completed, Shipped" || @order.order_status == "Completed, Disposed"
      redirect_to order_path(@order)
      flash[:notice] = "Order is completed, cannot be adjusted"
    end
    @order_item = OrderItem.new
    authorize @order_item
  end

  def create
    @order_item = OrderItem.new(order_params)
    @shipping = Shipping.new
    @order_item.order = @order
    @repair_item = RepairRate.find(@order_item.repair_rate_id)
    @order.amount = @order.amount + @order_item.repair_rate.price
    authorize @order_item
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
    authorize @order_item
    if @order_item.destroy
      @order.amount = @order.amount - @repair.price
      @shipping.destroy_all
      if @order_item.repair_rate.name == "Return Box Fee"
       @order.bap_ship = false
      end
      @order.save
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
