class RepairsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def create
    @repair = Repair.new(repair_params)
    @repair.order = @order
    @repair.user = current_user
    @repair_comment = repair_comment["repair_charge"]
    @shipping = Shipping.new
    if @repair.status == "Repair Completed"
      @repair.comment = "on #{Date.today}"
      @repair.save
      @order.order_status = "Completed, Shipped"
      @order.save
      @shipping = Shipping.ship_out_tracking(@order)
      mail = OrderMailer.with(order: @order, shipping: @shipping).repair_completed
      mail.deliver_now
      redirect_to order_path(@order)
    elsif @repair.status == "Diagnosed"
      @repair.comment = "on #{Date.today}"
      @repair_rate = RepairRate.find_by(name: "Diagnose Fee")
      @create_major = OrderItem.new(order: @order, repair_rate: @repair_rate)
      @order.amount = @order.amount + @repair_rate.price
      if @repair.save
        @create_major.save
        @order.save
        redirect_to order_path(@order)
        flash[:notice] = "Saved and you now have pending charges"
      end
    elsif @repair.status == "Dispose"
      @repair.comment = "on #{Date.today}"
      @repair.save
      @order.order_status = "Completed, Disposed"
      @order.save
      redirect_to order_path(@order)
    else
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
        @repair_rate = RepairRate.find_by(name: "Non-repairable Fee")
        @ship_rate = RepairRate.find_by(name: "Shipback Fee")
        @create_major = OrderItem.new(order: @order, repair_rate: @repair_rate)
        @create_ship = OrderItem.new(order: @order, repair_rate: @ship_rate)
        @order.amount = @order.amount + @repair_rate.price + @ship_rate.price
      end
      if @repair.save
        @create_major.save
        if @create_ship.save
          @shipping.order = @order
          @shipping.user = current_user
          @shipping.name = @ship_rate.name
          @shipping.shipout_courier = "FedEx"
          @shipping.save
        end
        @order.save
        redirect_to order_path(@order)
        flash[:notice] = "Saved and you now have pending charges"
      else
        redirect_to order_path(@order)
        flash[:notice] = "Did not save comment please try again later"
      end
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
