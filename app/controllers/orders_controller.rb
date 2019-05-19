class OrdersController < ApplicationController
  skip_before_action :authenticate_user!, only: [:create, :show, :new]
  before_action :order_id_find, only: [:show, :edit, :update, :destroy]
  def index
    @orders = Order.all
  end

  def show
    @note = Note.new
    @payment = Payment.new
  end

  def new
    @order = Order.new
    @product_model = Product.order(:model_no)
    @order_item = OrderItem.new
    @repair_rates = RepairRate.where(sku: ["SHIP001", "SHIP002", "SHIP003"])
    @payment = Payment.new
  end

  def create
    @product_model = Product.order(:model_no)
    @order = Order.new(order_params)
    @repair = RepairRate.find(1)
    @payment = Payment.new
    @order.user = current_user
    @order.state = "Pending"
    @notes = Note.new
    @notes.comment = "Created order request"
    @notes.user = user_signed_in? ? current_user : User.find_by_id(2)

    @order.order_status = "Order Created"
    if @order.save
      @notes.order = @order
      @notes.save
      @payment.repair_rate = @repair
      @payment.order = @order
      @payment.state = "Pending"
      @payment.amount = @repair.price
      @payment.save
      redirect_to order_path(@order)
    else
      render :new
    end
  end

  def edit
    @product_model = Product.order(:model_no)
    @note = Note.new
  end

  def update
    @product_model = Product.order(:model_no)
    @order.update(order_params)
    redirect_to order_path(@order)
  end

  private

  def order_id_find
    @order = Order.find(params[:id])
  end

  def order_params
    params.require(:order).permit(:first_name, :case_no, :last_name, :address, :address2, :city, :state, :zip, :telephone_no, :email, :product_id, :serial_number, :symptom, :order_status, :notes)
  end

end
