class ReceivingsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def new
    @receive = Receiving.new
  end

  def create
    @receive = Receiving.new(receive_params)
    @order.order_status = "Item received"
    @receive.order = @order
    if @receive.save
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

  def receive_params
    params.require(:receiving).permit(:model_no, :serial_number, :receive_courier, :receive_tracking, :order_id)
  end

end
