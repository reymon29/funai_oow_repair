class OrdersController < ApplicationController
  before_action :order_id_find, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def new

  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def order_id_find
    @order = Order.find(params[:id])
  end

  def return_params
    params.require(:order).permit(:first_name, :last_name, :address, :address1, :city, :state, :zip, :telephone_no, :email, :product_id)
  end
end
