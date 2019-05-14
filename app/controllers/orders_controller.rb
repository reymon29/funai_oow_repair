class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :new]
  before_action :order_id_find, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def new
    @order = Order.new
    @product_model = Product.order(:model_no)
  end

  def create
    @product_model = Product.order(:model_no)
    @order = Order.new(order_params)
    @order.order_status = "Order Created"
    if @order.save
      redirect_to order_path(@order)
    else
      render :new
    end
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

  def order_params
    params.require(:order).permit(:first_name, :case_no, :last_name, :address, :address2, :city, :state, :zip, :telephone_no, :email, :product_id, :serial_number, :symptom)
  end
end
