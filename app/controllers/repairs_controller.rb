class RepairsController < ApplicationController
  before_action :order_id_find, only: [:new, :create]

  def create
    @repair = Repair.new(repair_params)
    @repair.order = @order
    @repair.user = current_user
    if @repair.save
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

end
