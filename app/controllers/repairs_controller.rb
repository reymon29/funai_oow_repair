class RepairsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def create
    @repair = Repair.new(repair_params)
    @repair.order = @order
    @repair.user = current_user
    @repair_comment = repair_comment["repair_charge"]
    if @repair_comment == "Major"
      @repair_rate = RepairRate.find_by(name: "Major Repair Fee")
      @ship_rate = RepairRate.find_by(name: "Shipback Fee")
      @create_major = OrderItem.new(order: @order, repair_rate: @repair_rate)
      @create_ship = OrderItem.new(order: @order, repair_rate: @ship_rate)
      @order.amount = @order.amount + @repair_rate.price + @ship_rate.price
    elsif @repair_comment == "Minor"
      @repair_rate = RepairRate.find_by(name: "Minor Repair Fee")
      @ship_rate = RepairRate.find_by(name: "Shipback Fee")
      @create_major = OrderItem.new(order: @order, repair_rate: @repair_rate)
      @create_ship = OrderItem.new(order: @order, repair_rate: @ship_rate)
      @order.amount = @order.amount + @repair_rate.price + @ship_rate.price
    elsif @repair_comment == "Non-repairable"
      @ship_rate = RepairRate.find_by(name: "Shipback Fee")
      @create_ship = OrderItem.new(order: @order, repair_rate: @ship_rate)
      @order.amount = @order.amount + @repair_rate.price + @ship_rate.price
    end
    if @repair.save
      @create_major.save
      @create_ship.save
      @order.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  private

  def order_id_find
    @order = Order.find(params[:order_id])
  end

  def repair_params
    params.require(:repair).permit(:comment, :order_id, :status)
  end

  def repair_comment
    params.require(:no_model_fields).permit(:repair_charge)
  end
end
